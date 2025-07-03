import SwiftUI
import Sentry

struct CartView: View {
    @EnvironmentObject private var cartManager: CartManager
    @State private var navigateToCheckout = false

    var body: some View {
        List {
            ForEach(cartManager.items) { item in
                Text(item.name)
            }
        }
        .navigationTitle("Cart")
        .toolbar {
            Button("Checkout") {
                navigateToCheckout = true
                cartManager.checkout()
            }
        }
        .background(
            NavigationLink(
                destination: CheckoutView(),
                isActive: $navigateToCheckout
            ) { EmptyView() }
        )
    }
}
