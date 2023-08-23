//
//  Date+Extension.swift
//  CoinAppSwiftUI
//
//  Created by cem on 23.08.2023.
//

import Foundation

extension Date {
    init(apiDateString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: apiDateString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }

    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }

    func asShortDateString() -> String {
        return shortFormatter.string(from: self)
    }
}
