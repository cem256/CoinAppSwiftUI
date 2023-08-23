//
//  MarketViewModel.swift
//  CoinAppSwiftUI
//
//  Created by cem on 22.08.2023.
//

import Foundation

protocol MarketViewModel: ObservableObject {
    func fetchTopCoins() async
    func refreshTopCoins() async
}

@MainActor
final class MarketViewModelImpl: MarketViewModel {
    private let service: MarketService
    private let perPage: Int = 50
    private var page: Int = 1
    private var hasReachedMax: Bool = false
    private var coins: [Coin]

    @Published private(set) var state: State

    init(service: MarketService) {
        self.service = service
        coins = []
        state = .initial
    }

    func fetchTopCoins() async {
        // if has reached is true exit from the function
        guard !hasReachedMax else { return }
        // show loading screen only for the first load
        if page == 1 {
            state = .loading
        }
        do {
            // send request to the api
            let coins = try await service.fetchTopCoins(page: page, perPage: perPage)
            // if the response is empty it means that we have reached to the end of the list
            if coins.isEmpty {
                hasReachedMax = true
                return
            }
            // appending the api response to the coins array
            self.coins.append(contentsOf: coins)
            // updating the state
            state = .loaded(self.coins)
            page += 1
        } catch {
            // error case
            print(error.localizedDescription)
        }
    }

    func refreshTopCoins() async {
        // reset variables to their initial values
        page = 1
        coins = []
        do {
            // send request to the api
            let coins = try await service.fetchTopCoins(page: page, perPage: perPage)
            // appending the api response to the coins array
            self.coins.append(contentsOf: coins)
            // updating the state
            state = .loaded(self.coins)
            page += 1
        } catch {
            // error case
            print(error.localizedDescription)
        }
    }
}

extension MarketViewModelImpl {
    enum State {
        case initial
        case loading
        case loaded([Coin])
        case error
    }
}
