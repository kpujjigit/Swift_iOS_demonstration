import SwiftUI

struct CheckoutView: View {
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
    }
}
