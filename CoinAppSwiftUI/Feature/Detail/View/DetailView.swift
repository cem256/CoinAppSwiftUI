//
//  DetailView.swift
//  CoinAppSwiftUI
//
//  Created by cem on 22.08.2023.
//

import SwiftUI

struct DetailView: View {
    let coin: Coin
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: Coin.example)
    }
}
