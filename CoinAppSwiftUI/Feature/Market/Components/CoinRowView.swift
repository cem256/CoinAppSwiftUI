//
//  CoinRowView.swift
//  CoinAppSwiftUI
//
//  Created by cem on 23.08.2023.
//

import SwiftUI

struct CoinRowView: View {
    let coin: Coin

    var body: some View {
        HStack {
            CircularNetworkImage(imageUrl: coin.uImage)
            VStack(alignment: .leading) {
                Text(coin.uName)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text("\(coin.uMarketCapRank). \(coin.uSymbol.uppercased())")
                    .font(.footnote)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(coin.uCurrentPrice, format: .currency(code: "USD"))")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(coin.uPriceChange24h.toPercentString())
                    .font(.footnote)
                    .foregroundColor((coin.uPriceChange24h) > 0 ? .green : .red)
            }
        }.padding(4)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: Coin.example)
    }
}
