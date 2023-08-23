//
//  CustomChartView.swift
//  CoinAppSwiftUI
//
//  Created by cem on 23.08.2023.
//

import SwiftUI

struct CustomChartView: View {
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    @State private var percentage: CGFloat = 0

    init(coin: Coin) {
        data = coin.sparklineIn7D?.price ?? []
        // finding maximum and minimum values
        maxY = data.max() ?? 0
        minY = data.min() ?? 0

        // finding price change
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? .green : .red

        endingDate = Date(apiDateString: coin.uLastUpdated)
        // 7 Days before ending date
        startingDate = endingDate.addingTimeInterval(-7 * 24 * 60 * 60)
    }

    var body: some View {
        VStack {
            GeometryReader { geometry in
                Path { path in
                    for index in data.indices {
                        // calculating the xPosition dynamically according to device screen size
                        let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)

                        let yAxis = maxY - minY
                        // inverse graph
                        let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height

                        if index == 0 {
                            path.move(to: CGPoint(x: xPosition, y: yPosition))
                        }
                        path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    }
                }
                .trim(from: 0, to: percentage)
                .stroke(lineColor, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                .shadow(color: lineColor, radius: 10, x: 0.0, y: 10)
                .shadow(color: lineColor, radius: 10, x: 0.0, y: 20)
            }
            .frame(height: 200)
            .modifier(ChartBackground())
            .modifier(ChartOverlay(maxY: maxY, minY: minY))

            HStack {
                Text(startingDate.asShortDateString())
                Spacer()
                Text(endingDate.asShortDateString())
            }
            .padding(.top, 4)
        }
        .font(.subheadline)
        .padding(.horizontal, 4)
        .onAppear {
            withAnimation(.linear(duration: 1)) {
                percentage = 1.0
            }
        }
    }
}

private struct ChartOverlay: ViewModifier {
    let maxY: Double
    let minY: Double
    func body(content: Content) -> some View {
        content
            .overlay(VStack {
                Spacer()
                Text(maxY.formattedWithAbbreviations())
                Spacer()
                Spacer()
                Text(((maxY + minY) / 2).formattedWithAbbreviations())
                Spacer()
                Spacer()
                Text(minY.formattedWithAbbreviations())
                Spacer()
            }
            .padding(0), alignment: .leading)
    }
}

private struct ChartBackground: ViewModifier {
    func body(content: Content) -> some View {
        content.background(
            VStack {
                Divider()
                Spacer()
                Divider()
                Spacer()
                Divider()
            })
    }
}

struct CustomChartView_Previews: PreviewProvider {
    static var previews: some View {
        CustomChartView(coin: Coin.example)
    }
}
