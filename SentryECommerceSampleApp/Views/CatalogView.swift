import SwiftUI
import Sentry
import Foundation

struct CatalogView: View {
    @State private var products: [Product] = []
    @State private var isLoading = false
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
            .overlay(
                Group {
                    if isLoading {
                        ProgressView("Loading...")
                    }
                }
            )
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
        isLoading = true
        DispatchQueue.global().async {
            _ = recursiveSlowWork(43)
            DispatchQueue.main.async {
                self.products = Product.sampleCatalog
                self.isLoading = false
                span.finish()
            }
        }
    }
}
