//
//  BalanceViewModel.swift
//  
//
//  Created by Bodgar Espinosa Miranda on 04/09/24.
//

import SwiftData
import SwiftUI
import CashSwitchboard
import Common

public class BalanceViewModel {
    
    @Dependency var transactionService: TransactionService
    @Dependency var navigationService: NavigationService

    @Published var historyMonthBalance: [CashSwitchboard.Transaction] = []
    @Published var balance: Balance = .init(currentAmount: 0.0, month: "")
    
    let title = "Mi Balance"
    let firstButtonTitle = "AGREGAR INGRESO"
    let secondButtonTitle = "AGREGAR GASTO"
    
    let errorTitle = "No tienes lana 😢"
    let errorSubtitle = "Aún no tienes un movimiento registrado este mes, puedes añadirlo dando click en AGREGAR INGRESO o AGREGAR GASTO."
    
    public init() {
        getHistoryBalance()
    }
    
    public func sendToAddCashInView() {
        navigationService.navigate(to: CashDestination.cashInOut(type: "CashIn"))
    }
    
    public func sendToCashOutView() {
        navigationService.navigate(to: CashDestination.cashInOut(type: "CashOut"))
    }
    
    private func getHistoryBalance() {
        let transactions = transactionService.fetchTransactions()
        historyMonthBalance =  transactions.filter { transaction in
            transaction.date.isSameMonthAndYear(dateCompare: Date())
        }
        getBalance()
    }
    
    private func getBalance() {
        let currentAmount = historyMonthBalance.map {$0.amount}.reduce(0, +)
        balance = .init(currentAmount: currentAmount, month: Date().getDateName())
    }
}
