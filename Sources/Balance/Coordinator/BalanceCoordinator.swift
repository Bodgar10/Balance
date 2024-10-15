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
        registerDependencies()
    }
    
    @ViewBuilder public func start() -> some View {
        BalanceView(viewModel: BalanceViewModel())
    }
    
    private func registerDependencies() {
        ServiceLocator.register(TransactionService.self, factory: SwiftDataTransactionService(modelContext: self.modelContext))
    }
}
