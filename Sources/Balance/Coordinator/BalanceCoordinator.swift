//
//  File.swift
//  
//
//  Created by Bodgar Espinosa Miranda on 17/09/24.
//

import Foundation
import SwiftUI
import SwiftData
import CashSwitchboard
import Common

public class BalanceCoordinator {
    
    private var modelContext: ModelContext
    
    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
        addSamples(with: modelContext)
        registerDependencies()
    }
    
    @ViewBuilder public func start() -> some View {
        BalanceView(viewModel: BalanceViewModel())
    }
    
    private func registerDependencies() {
        ServiceLocator.register(TransactionService.self, factory: SwiftDataTransactionService(modelContext: self.modelContext))
    }
    
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
