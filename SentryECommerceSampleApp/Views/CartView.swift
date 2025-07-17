import SwiftUI
import Sentry

struct CartView: View {
    @EnvironmentObject private var cartManager: CartManager
    @State private var navigateToCheckout = false
    @State private var showAlert = false

    var body: some View {
        ZStack {
            List {
                ForEach(cartManager.items) { item in
                    Text(item.name)
                }
            }

            if cartManager.isProcessing {
                ProgressView("Processing...")
            }
        }
        .navigationTitle("Cart")
        .toolbar {
            Button("Checkout") {
                navigateToCheckout = true
                cartManager.checkout()
            }
        }
        .onChange(of: cartManager.lastError) { error in
            showAlert = error != nil
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text("Purchase can't be completed."), dismissButton: .default(Text("OK")))
        }
        .background(
            NavigationLink(
                destination: CheckoutView(),
                isActive: $navigateToCheckout
            ) { EmptyView() }
        )
    }
}
