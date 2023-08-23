//
//  Double+Extension.swift
//  CoinAppSwiftUI
//
//  Created by cem on 23.08.2023.
//

import Foundation

extension Double {
    private var percentFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }

    func toPercentString() -> String {
        guard let numberAsString = percentFormatter.string(for: self) else { return "" }
        return numberAsString + "%"
    }
}
