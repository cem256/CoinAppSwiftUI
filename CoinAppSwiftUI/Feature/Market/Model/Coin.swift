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
    private let priceChange1h: Double?
    private let priceChange24h: Double?
    private let priceChange7d: Double?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case marketCapRank = "market_cap_rank"
        case currentPrice = "current_price"
        case priceChange1h = "price_change_percentage_1h_in_currency"
        case priceChange24h = "price_change_percentage_24h_in_currency"
        case priceChange7d = "price_change_percentage_7d_in_currency"
    }

    private func unwrappedValue<T>(_ optionalValue: T?, default defaultValue: T) -> T {
        optionalValue ?? defaultValue
    }

    var uSymbol: String { unwrappedValue(symbol, default: "btc") }
    var uName: String { unwrappedValue(name, default: "Bitcoin") }
    var uImage: String { unwrappedValue(image, default: "1") }
    var uMarketCapRank: Int { unwrappedValue(marketCapRank, default: 1) }
    var uCurrentPrice: Double { unwrappedValue(currentPrice, default: 0) }
    var uPriceChange1h: Double { unwrappedValue(priceChange1h, default: 0) }
    var uPriceChange24h: Double { unwrappedValue(priceChange24h, default: 0) }
    var uPriceChange7d: Double { unwrappedValue(priceChange7d, default: 0) }

    static let example = Coin(
        id: "bitcoin",
        symbol: "BTC",
        name: "Bitcoin",
        image: "https://example.com/bitcoin.png",
        marketCapRank: 1,
        currentPrice: 45000.0,
        priceChange1h: -0.5,
        priceChange24h: 2.3,
        priceChange7d: 10.1
    )
}
