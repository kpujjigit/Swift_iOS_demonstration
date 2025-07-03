import SwiftUI
import Sentry

struct CatalogView: View {
    @State private var products: [Product] = []
    @EnvironmentObject private var cartManager: CartManager

    var body: some View {
        NavigationView {
            List(products) { product in
                HStack {
                    VStack(alignment: .leading) {
                        Text(product.name)
                        Text("$\(product.price, specifier: "%.2f")")
                    }
                    Spacer()
                    Button("Add") {
                        cartManager.add(product)
                    }
                }
            }
            .navigationTitle("Catalog")
            .toolbar {
                NavigationLink(destination: CartView()) {
                    Image(systemName: "cart")
                }
            }
        }
        .onAppear(perform: loadCatalog)
    }

    private func loadCatalog() {
        let span = SentrySDK.startTransaction(name: "Load Catalog", operation: "catalog.load")
        // intentionally slow load
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.products = Product.sampleCatalog
            span.finish()
        }
    }
}
