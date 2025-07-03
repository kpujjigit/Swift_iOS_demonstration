import Foundation
import Sentry

final class CartManager: ObservableObject {
    @Published private(set) var items: [Product] = []

    func add(_ product: Product) {
        let span = SentrySDK.startTransaction(name: "Add to Cart", operation: "cart.add")
        items.append(product)
        span.finish()
    }

    func checkout() {
        let span = SentrySDK.startTransaction(name: "Checkout", operation: "cart.checkout")
        // Intentionally trigger an error when checkout is attempted
        let error = NSError(domain: "SampleCheckout", code: 999, userInfo: [NSLocalizedDescriptionKey: "Checkout failed intentionally"])
        SentrySDK.capture(error: error)
        span.finish(status: .internalError)
    }
}
