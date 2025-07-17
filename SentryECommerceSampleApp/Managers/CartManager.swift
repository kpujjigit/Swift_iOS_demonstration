import Foundation
import Sentry

final class CartManager: ObservableObject {
    @Published private(set) var items: [Product] = []
    @Published var isProcessing = false
    @Published var lastError: Error?

    func add(_ product: Product) {
        let span = SentrySDK.startTransaction(name: "Add to Cart", operation: "cart.add")
        items.append(product)
        span.finish()
    }

    func checkout() {
        isProcessing = true
        lastError = nil
        let span = SentrySDK.startTransaction(name: "Checkout", operation: "cart.checkout")
        DispatchQueue.global().async {
            _ = recursiveSlowWork(43)

            let urlString = ProcessInfo.processInfo.environment["CHECKOUT_URL"] ?? "http://localhost:5000/checkout"
            let request = URLRequest(url: URL(string: urlString)!)
            let child = span.startChild(operation: "http.client", description: "POST /checkout")
            URLSession.shared.dataTask(with: request) { _, _, _ in
                child.finish()
                let error = NSError(domain: "SampleCheckout", code: 999, userInfo: [NSLocalizedDescriptionKey: "Checkout failed intentionally"])
                let eventId = SentrySDK.capture(error: error)
                var feedback = UserFeedback(eventId: eventId)
                feedback.comments = "User attempted checkout and failed."
                SentrySDK.capture(userFeedback: feedback)
                DispatchQueue.main.async {
                    self.isProcessing = false
                    self.lastError = error
                    span.finish(status: .internalError)
                }
            }.resume()
        }
    }
}
