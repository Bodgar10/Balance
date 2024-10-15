//
//  BalanceViewModelTests.swift
//  
//
//  Created by Bodgar Espinosa Miranda on 10/09/24.
//

import XCTest
import SwiftData
import Common
import CashSwitchboard
import Combine
@testable import Balance
import _SwiftData_SwiftUI

final class BalanceViewModelTests: XCTestCase {

    let mockNavigationService = MockNavigationService()
    
    var container: ModelContainer!
    private var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        
        container = try! ModelContainer(for: Transaction.self, configurations: .init(isStoredInMemoryOnly: true))
    }
    
    func test_sendToAddCashInView_withNavigationService_shouldNavigateToNextScreen() {
        // GIVEN
        let sut = sut()
        XCTAssertFalse(mockNavigationService.didSendToNavigate)
        // WHEN
        sut.sendToAddCashInView()
        // THEN
        XCTAssertTrue(mockNavigationService.didSendToNavigate)
    }
    
    func test_sendToCashOutView_withNavigationService_shouldNavigateToNextScreen() {
        // GIVEN
        let sut = sut()
        XCTAssertFalse(mockNavigationService.didSendToNavigate)
        // WHEN
        sut.sendToCashOutView()
        // THEN
        XCTAssertTrue(mockNavigationService.didSendToNavigate)
    }
    
    func test_historyMonthBalance_withTransactionsInTheMonth_shouldReturnTransactions() {
        
        // GIVEN
        let sut = sut()
        
        let expectation = XCTestExpectation(description: "History Month Balance changed")
        
        // THEN
        sut.$historyMonthBalance.sink { transactions in
            XCTAssertNotNil(transactions)
            XCTAssertEqual(transactions.count, 3)
            XCTAssertEqual(transactions.first?.category, .cash)
            XCTAssertEqual(transactions.first?.amount, 200)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
        
    }
    
    func test_balance_withTransactionsInTheMonth_shouldReturnSuccessBalance() {
        // GIVEN
        let sut = sut()
        
        let expectation = XCTestExpectation(description: "Balance changed")
        
        // THEN
        sut.$balance.sink { balance in
            XCTAssertNotNil(balance)
            XCTAssertEqual(balance.month, Date().getDateName())
            XCTAssertEqual(balance.currentAmount, 900)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    // MARK: HELPERS
    
    private func sut() -> BalanceViewModel {
        registerMockDependencies()
        let balanceViewModel = BalanceViewModel()
        trackForMemoryLeaks(balanceViewModel)
        return balanceViewModel
    }
    
    private func registerMockDependencies() {
        ServiceLocator.register((any NavigationService).self, factory: self.mockNavigationService)
        
        ServiceLocator.register(TransactionService.self, factory: MockTransactionService())
    }
    
    override func tearDown() {
        ServiceLocator.remove((any NavigationService).self)
        container = nil
        super.tearDown()
    }
    
}

final class MockNavigationService: NavigationService {
    var navigationState = NavigationState()
    
    func presentModal(to destination: Common.Destination) {
        
    }
    
    func dismissModal() {
        
    }
    
    
    var id =  UUID()
    
    var didSendToNavigate = false
    
    func navigate(to destination: Destination) {
        didSendToNavigate = true
    }
}

final class MockTransactionService: TransactionService {
    
    var id = UUID()
    
    func fetchTransactions() -> [CashSwitchboard.Transaction] {
        return [
            Transaction(category: .cash, subcategory: "Dinero efectivo", amount: 200, date: Date()),
            Transaction(category: .cash, subcategory: "Dinero efectivo", amount: 300, date: Date()),
            Transaction(category: .cash, subcategory: "Dinero efectivo", amount: 400, date: Date())
        ]
    }
}
