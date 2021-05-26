
import Foundation

// MARK: - FeedsResponse
 public struct FeedsResponse: Codable {
    var feeds: [Feed]?
    var lastUpdate: String?

    enum CodingKeys: String, CodingKey {
        case feeds = "Feeds"
        case lastUpdate = "LastUpdate"
    }
}

// MARK: - Feed
struct Feed: Codable {
    var buyPrice: Price?
    var sellPrice: Price?
    var stockID: Int?
    
    enum CodingKeys: String, CodingKey {
        case buyPrice = "BuyPrice"
        case sellPrice = "SellPrice"
        case stockID = "StockId"
    }
}

enum Price: Codable {
    case double(Double)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Price.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Price"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
    
    var value: Double?{
        switch self {
        case .double(let val):
            return val
        default:
            return nil
        }
    }
}
