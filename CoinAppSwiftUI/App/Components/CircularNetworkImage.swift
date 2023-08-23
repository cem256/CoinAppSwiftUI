//
//  CircularNetworkImage.swift
//  CoinAppSwiftUI
//
//  Created by cem on 23.08.2023.
//

import SwiftUI

struct CircularNetworkImage: View {
    let imageUrl: String

    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: ImageSizes.small.rawValue)
                .clipShape(Circle())
        } placeholder: {
            Circle()
                .frame(width: ImageSizes.small.rawValue)
        }
    }
}

struct CircularNetworkImage_Previews: PreviewProvider {
    static var previews: some View {
        CircularNetworkImage(imageUrl: Coin.example.uImage)
    }
}
