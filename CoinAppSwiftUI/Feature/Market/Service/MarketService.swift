//
//  MarketService.swift
//  CoinAppSwiftUI
//
//  Created by cem on 22.08.2023.
//

import Foundation

protocol MarketService {
    func fetchTopCoins(page: Int, perPage: Int) async throws -> [Coin]
}

final class MarketServiceImpl: MarketService {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func fetchTopCoins(page: Int, perPage: Int) async throws -> [Coin] {
        let queryParameters: [String: String] = ["page": "\(page)", "per_page": "\(perPage)", "vs_currency": "usd", "order": "market_cap_desc", "sparkline": "true", "price_change_percentage": "24h"]

        let (data, _) = try await networkClient.performRequest(path: ApiConstants.topCoins, method: HTTPMethod.get, queryParameters: queryParameters)

        let coins = try JSONDecoder().decode([Coin].self, from: data)
        return coins
    }
}
