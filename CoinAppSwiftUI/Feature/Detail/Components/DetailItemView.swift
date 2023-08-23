//
//  DetailItemView.swift
//  CoinAppSwiftUI
//
//  Created by cem on 23.08.2023.
//

import SwiftUI

struct DetailItemView: View {
    let title: String
    let value: String
    let percentageChange: Double?

    init(title: String, value: String, percentageChange: Double?) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.headline)

            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees: (percentageChange ?? 0) >= 0 ? 0 : 180))

                Text("\(percentageChange?.toPercentString() ?? "0")")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor((percentageChange ?? 0) >= 0 ? .green : .red)
            .opacity(percentageChange == nil ? 0.0 : 1.0)
        }
    }
}

struct GridItemView_Previews: PreviewProvider {
    static var previews: some View {
        DetailItemView(title: "Current Price", value: String(Coin.example.uCurrentPrice), percentageChange: Coin.example.uPriceChange24h)
    }
}
