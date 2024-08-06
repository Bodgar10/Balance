
import Foundation
import SwiftUI

public enum BalancePage: Hashable {
    case root
}

@available(iOS 16, *)
public class BalanceCoordinator: BalanceCoordinatorProtocol {

    // MARK: - Properties

    @Published public var path = NavigationPath()
    private let configuration: BalanceConfigurationProtocol
    private let bundleMainApp: Bundle?

    // MARK: - Initializer

    public required init(path: NavigationPath = NavigationPath(), configuration: BalanceConfigurationProtocol, bundleMainApp: Bundle? = nil) {
        self.path = path
        self.configuration = configuration
        self.bundleMainApp = bundleMainApp
    }
    
    // MARK: - Functions

    public func push(page: BalancePage) {
        path.append(page)
    }
    
    public func popToRoot() {
        path.removeLast(path.count)
    }
    
    public func pop() {
        path.removeLast()
    }

    @ViewBuilder public func build(page: BalancePage) -> some View {
        switch page {
        case .root:
            BalanceView(
                viewModel: BalanceViewModel(
                    configuration: configuration,
                    bundleMainApp: bundleMainApp ?? .main
                )
            )
        }
    }
}