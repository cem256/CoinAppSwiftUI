//
//  DetailView.swift
//  CoinAppSwiftUI
//
//  Created by cem on 22.08.2023.
//

import SwiftUI

struct DetailView: View {
    let coin: Coin
    private let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                CustomChartView(coin: coin)
                    .padding(.vertical)
                Text("Overview").font(.title.bold())
                Divider()
                LazyVGrid(columns: columns, alignment: .leading, content: {
                    DetailItemView(title: "Current Price",
                                   value: coin.uCurrentPrice.toCurrencyString(),
                                   percentageChange: coin.uPriceChange24h)
                    DetailItemView(title: "Market Cap",
                                   value: coin.uMarketCap.formattedWithAbbreviations(),
                                   percentageChange: coin.uMarketCapChangePercentage24h)
                    DetailItemView(title: "Rank",
                                   value: String(coin.uMarketCapRank),
                                   percentageChange: nil)
                    DetailItemView(title: "Volume",
                                   value: coin.uVolume.formattedWithAbbreviations(),
                                   percentageChange: nil)
                })
                Divider()
                Text("Additional Details").font(.title.bold())
                LazyVGrid(columns: columns, alignment: .leading, content: {
                    DetailItemView(title: "24h High",
                                   value: String(coin.uPriceHigh24h.toCurrencyString()),
                                   percentageChange: nil)

                    DetailItemView(title: "24h Low",
                                   value: String(coin.uPriceLow24h.toCurrencyString()),
                                   percentageChange: nil)
                    DetailItemView(title: "24h Price Change",
                                   value: String(coin.uPriceChange24h.toCurrencyString()),
                                   percentageChange: coin.uPriceChangePercentage24h)

                    DetailItemView(title: "24h Market Cap Change",
                                   value: coin.uMarketCapChange24h.formattedWithAbbreviations(),
                                   percentageChange: coin.uMarketCapChangePercentage24h)
                })
            }
        }
        .padding()
        .navigationTitle(coin.uName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                CircularNetworkImage(imageUrl: coin.uImage)
            }
        }
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: Coin.example)
    }
}
