import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject private var cartManager: CartManager
    @State private var showAlert = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Shipping")
                .font(.headline)
            Text("John Doe")
            Text("123 Main St")
            Text("City, State 00000")

            Text("Billing")
                .font(.headline)
            Text("Visa **** 4242")

            Spacer()
        }
        .padding()
        .navigationTitle("Review Order")
        .onChange(of: cartManager.lastError) { error in
            showAlert = error != nil
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text("Purchase can't be completed."), dismissButton: .default(Text("OK")))
        }
        .overlay(
            Group {
                if cartManager.isProcessing {
                    ProgressView("Processing...")
                }
            }
        )
    }
}
