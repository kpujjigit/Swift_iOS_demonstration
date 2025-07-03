import Foundation

struct Product: Identifiable {
    let id: UUID = UUID()
    let name: String
    let price: Double
}

extension Product {
    static let sampleCatalog: [Product] = [
        Product(name: "Widget", price: 9.99),
        Product(name: "Gadget", price: 12.49),
        Product(name: "Doohickey", price: 7.25)
    ]
}
