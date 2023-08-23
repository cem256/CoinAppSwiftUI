//
//  MarketView.swift
//  CoinAppSwiftUI
//
//  Created by cem on 22.08.2023.
//

import SwiftUI

struct MarketView: View {
    @StateObject private var marketViewModel = MarketViewModelImpl(service: MarketServiceImpl(networkClient: NetworkClient.shared))

    var body: some View {
        VStack {
            switch marketViewModel.state {
            case .initial, .loading:
                LoadingView()
            case .loaded(let coins):
                LoadedView(coins: coins, refreshAction: marketViewModel.refreshTopCoins, paginationAction: marketViewModel.fetchTopCoins)
            case .error:
                ErrorView(retryAction: marketViewModel.refreshTopCoins)
            }
        }
        .task {
            await marketViewModel.fetchTopCoins()
        }
    }
}

private struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
        }
    }
}

private struct LoadedView: View {
    let coins: [Coin]
    let refreshAction: () async -> Void
    let paginationAction: () async -> Void

    var body: some View {
        NavigationView {
            List {
                ForEach(coins) { coin in
                    NavigationLink {
                        DetailView(coin: coin)
                    }
                    label: {
                        CoinRowView(coin: coin).onAppear {
                            if coin.id == coins.last?.id {
                                Task {
                                    await paginationAction()
                                }
                            }
                        }
                    }.buttonStyle(PlainButtonStyle())
                }
            }
            .refreshable {
                Task {
                    await refreshAction()
                }
            }
            .navigationTitle("Markets")
        }
    }
}

private struct ErrorView: View {
    let retryAction: () async -> Void

    var body: some View {
        VStack {
            Text("Oops something went wrong! but it's not your fault").multilineTextAlignment(.center)
            HStack {
                Image(systemName: "arrow.clockwise").foregroundColor(.accentColor)
                Button("Retry") {
                    Task {
                        await retryAction()
                    }
                }
            }.padding(.vertical)
        }.padding()
    }
}

struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        MarketView()
    }
}
