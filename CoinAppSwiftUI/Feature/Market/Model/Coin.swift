//
//  Coin.swift
//  CoinAppSwiftUI
//
//  Created by cem on 22.08.2023.
//

import Foundation

struct Coin: Codable, Identifiable {
    let id: String?
    private let symbol: String?
    private let name: String?
    private let image: String?
    private let marketCapRank: Int?
    private let currentPrice: Double?
    private let priceChange24h: Double?
    private let marketCap: Double?
    private let marketCapChange24h: Double?
    private let priceHigh24h: Double?
    private let priceLow24h: Double?
    private let priceChangePercentage24h: Double?
    private let marketCapChangePercentage24h: Double?
    private let volume: Double?
    private let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case marketCapRank = "market_cap_rank"
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case priceHigh24h = "high_24h"
        case priceLow24h = "low_24h"
        case priceChange24h = "price_change_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case marketCapChange24h = "market_cap_change_24h"
        case marketCapChangePercentage24h = "market_cap_change_percentage_24h"
        case volume = "total_volume"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
    }

    struct SparklineIn7D: Codable {
        let price: [Double]?
    }

    private func unwrappedValue<T>(_ optionalValue: T?, default defaultValue: T) -> T {
        optionalValue ?? defaultValue
    }

    var uSymbol: String { unwrappedValue(symbol, default: "btc") }
    var uName: String { unwrappedValue(name, default: "Bitcoin") }
    var uImage: String { unwrappedValue(image, default: "1") }
    var uMarketCapRank: Int { unwrappedValue(marketCapRank, default: 1) }
    var uCurrentPrice: Double { unwrappedValue(currentPrice, default: 0) }
    var uPriceChange24h: Double { unwrappedValue(priceChange24h, default: 0) }
    var uMarketCap: Double { unwrappedValue(marketCap, default: 0) }
    var uMarketCapChange24h: Double { unwrappedValue(marketCapChange24h, default: 0) }
    var uPriceHigh24h: Double { unwrappedValue(priceHigh24h, default: 0) }
    var uPriceLow24h: Double { unwrappedValue(priceLow24h, default: 0) }
    var uPriceChangePercentage24h: Double { unwrappedValue(priceChangePercentage24h, default: 0) }
    var uMarketCapChangePercentage24h: Double { unwrappedValue(marketCapChangePercentage24h, default: 0) }
    var uVolume: Double { unwrappedValue(volume, default: 0) }
    var uLastUpdated: String { unwrappedValue(lastUpdated, default: "") }

    static let example = Coin(
        id: "bitcoin",
        symbol: "BTC",
        name: "Bitcoin",
        image: "https://example.com/bitcoin.png",
        marketCapRank: 1,
        currentPrice: 45000.0,
        priceChange24h: 2.3,
        marketCap: 850000000000,
        marketCapChange24h: 7189707062,
        priceHigh24h: 46000.0,
        priceLow24h: 44000.0,
        priceChangePercentage24h: 5.0,
        marketCapChangePercentage24h: 0.06,
        volume: 60000000000,
        lastUpdated: "2021-05-09T04:06:09.766Z",
        sparklineIn7D: SparklineIn7D(price: [45000.0, 46000.0, 47000.0, 46000.0, 47000.0, 48000.0, 49000.0])
    )
}
