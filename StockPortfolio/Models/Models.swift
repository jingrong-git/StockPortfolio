//
//  Models.swift
//  StockPortfolio
//
//  Created by Jingrong Zhou on 2/18/26.
//

import Foundation

struct PricePoint: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}

struct PortfolioResult {
    let portfolio: [PricePoint]
    let sp500: [PricePoint]
}
