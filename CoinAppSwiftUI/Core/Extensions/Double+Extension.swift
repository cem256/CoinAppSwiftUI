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

    private func currencyFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter
    }

    func toCurrencyString() -> String {
        guard let currency = currencyFormatter().string(for: self) else { return "" }
        return currency
    }

    func toPercentString() -> String {
        guard let numberAsString = percentFormatter.string(for: self) else { return "" }
        return numberAsString + "%"
    }

    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""
        let currencySymbol: String = currencyFormatter().currencySymbol

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.toNumberString()
            return "\(sign)\(currencySymbol)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.toNumberString()
            return "\(sign)\(currencySymbol)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.toNumberString()
            return "\(sign)\(currencySymbol)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.toNumberString()
            return "\(sign)\(currencySymbol)\(stringFormatted) K"
        case 0...:
            return "\(currencySymbol)\(toNumberString())"

        default:
            return "\(sign)\(currencySymbol)\(self)"
        }
    }

    func toNumberString() -> String {
        return String(format: "%.2f", self)
    }
}
