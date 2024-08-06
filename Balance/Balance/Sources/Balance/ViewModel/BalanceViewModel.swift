
import Combine
import Foundation
import SwiftUI

public class BalanceViewModel: BalanceViewModelProtocol {

    // MARK: - Properties

    private let configuration: BalanceConfigurationProtocol
    private let bundleMainApp: Bundle

    // MARK: - Initializer

    public required init(configuration: BalanceConfigurationProtocol, bundleMainApp: Bundle) {
        self.configuration = configuration
        self.bundleMainApp = bundleMainApp
    }
}