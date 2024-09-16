//
//  SwiftDataTransactionService.swift
//
//
//  Created by Bodgar Espinosa Miranda on 16/09/24.
//

import Foundation
import SwiftData
import SwiftUI
import CashSwitchboard

public class SwiftDataTransactionService: TransactionService {
    
    private let modelContext: ModelContext
    public var id = UUID()
    
    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    public func fetchTransactions() -> [CashSwitchboard.Transaction] {
        do {
            let descriptor = FetchDescriptor<CashSwitchboard.Transaction>(sortBy: [SortDescriptor(\.date)])
            return try modelContext.fetch(descriptor)
        } catch {}
        return []
    }
}
