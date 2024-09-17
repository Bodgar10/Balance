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
    
    @Environment(\.modelContext) var modelContext
    
    public init() {
        registerDependencies()
    }
    
    @ViewBuilder public func start() -> some View {
        BalanceView(viewModel: BalanceViewModel())
    }
    
    private func registerDependencies() {
        ServiceLocator.register(TransactionService.self, factory: SwiftDataTransactionService(modelContext: self.modelContext))
    }
}
