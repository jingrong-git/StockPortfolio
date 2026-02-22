//
//  Untitled.swift
//  StockPortfolio
//
//  Created by Jingrong Zhou on 2/18/26.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class PortfolioViewModel: ObservableObject {

    @Published var chartData: PortfolioResult?

    let service = YahooFinanceService()

    let symbols = ["AAPL", "MSFT", "GOOGL", "AMZN", "NVDA"]
    let benchmark = "^GSPC"

    func load() async {

        do {

            var symbolData: [[PricePoint]] = []

            for symbol in symbols {
                let prices = try await service.fetchHistoricalPrices(symbol: symbol)
                symbolData.append(prices)
            }

            let sp = try await service.fetchHistoricalPrices(symbol: benchmark)

            let portfolio = calculateEqualWeightPortfolio(data: symbolData)

            chartData = PortfolioResult(portfolio: portfolio, sp500: normalizeSeries(sp))

        } catch {
            print("Load error:", error)
        }
    }

    private func calculateEqualWeightPortfolio(data: [[PricePoint]]) -> [PricePoint] {

        guard let first = data.first else { return [] }

        let normalizedSeries = data.map { normalizeSeries($0) }

        var output: [PricePoint] = []

        for i in 0..<first.count {

            let date = first[i].date

            let avg = normalizedSeries.map { $0[i].value }.reduce(0, +) / Double(normalizedSeries.count)

            output.append(PricePoint(date: date, value: avg))
        }

        return output
    }

    private func normalizeSeries(_ series: [PricePoint]) -> [PricePoint] {

        guard let first = series.first else { return [] }

        let base = first.value

        return series.map {
            PricePoint(date: $0.date, value: $0.value / base)
        }
    }
}
