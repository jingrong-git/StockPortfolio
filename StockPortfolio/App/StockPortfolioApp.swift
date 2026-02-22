//
//  StockPortfolioApp.swift
//  StockPortfolio
//
//  Created by Jingrong Zhou on 2/18/26.
//

import SwiftUI
import CoreData

@main
struct StockPortfolioApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                              persistenceController.container.viewContext)
        }
    }
}
