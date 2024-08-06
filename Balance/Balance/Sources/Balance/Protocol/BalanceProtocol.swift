
import Foundation
import SwiftUI

public protocol BalanceViewModelProtocol: ObservableObject {
    
    // MARK: - Initializer
    
    init(configuration: BalanceConfigurationProtocol, bundleMainApp: Bundle)
}

public protocol BalanceConfigurationProtocol: AnyObject {
    
    // MARK: - Properties
    
    var config: [String: AnyObject] { get set }
}

public protocol BalanceCoordinatorProtocol: ObservableObject {

    // MARK: - Properties

    var path: NavigationPath { get set }

    // MARK: - Functions

    init(path: NavigationPath, configuration: BalanceConfigurationProtocol, bundleMainApp: Bundle?)
    func push(page: BalancePage)
    func popToRoot()
    func pop()
    
    associatedtype view: View
    func build(page: BalancePage) -> view
}