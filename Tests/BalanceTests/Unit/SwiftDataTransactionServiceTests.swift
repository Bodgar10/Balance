//
//  SwiftDataTransactionServiceTests.swift
//
//
//  Created by Bodgar Espinosa Miranda on 16/09/24.
//

import XCTest
import Foundation
import SwiftData
import CashSwitchboard
@testable import Balance

final class SwiftDataTransactionServiceTests: XCTestCase {
    
    @MainActor func testAppStartsEmpty() throws {
        
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Transaction.self, configurations: config)

        let sut = SwiftDataTransactionService(modelContext: container.mainContext)

        XCTAssertEqual(sut.fetchTransactions().count, 0)
    }
    
    @MainActor func test_fetchTransaction_withSamples_shouldSendTransactions() throws {
        
        // GIVEN
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Transaction.self, configurations: config)

        let sut = SwiftDataTransactionService(modelContext: container.mainContext)

        // WHEN
        
        addSamples(with: container.mainContext)
        
        // THEN
        let transactions = sut.fetchTransactions()
        XCTAssertEqual(transactions.count, 3)
        XCTAssertEqual(transactions.first?.category, .cash)
        XCTAssertEqual(transactions.first?.amount, 200)
    }
    
    // MARK: Helpers
    
    func addSamples(with modelContext: ModelContext) {
        let first = Transaction(category: .cash, subcategory: "Dinero efectivo", amount: 200, date: Date())
        let second = Transaction(category: .cash, subcategory: "Dinero efectivo", amount: 300, date: Date())
        let third = Transaction(category: .cash, subcategory: "Dinero efectivo", amount: 400, date: Date())
        
        modelContext.insert(first)
        modelContext.insert(second)
        modelContext.insert(third)
        try? modelContext.save()
    }

}
