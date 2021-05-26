
import Foundation

// MARK: - StockResponseElement

public struct StockElement: Codable {
    var id: Int?
    var name: String?
    var symbol: String?
    var precisionDigit: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case symbol = "Symbol"
        case precisionDigit = "PrecisionDigit"
    }
}
