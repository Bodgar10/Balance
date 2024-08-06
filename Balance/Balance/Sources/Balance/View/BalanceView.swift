
import Foundation
import SwiftUI

public struct BalanceView<VM>: View where VM: BalanceViewModelProtocol {

    // MARK: - Properties

    @ObservedObject var viewModel: VM

    // MARK: - Initialize

    public init( viewModel: VM) {
        self.viewModel = viewModel    
    }

    public var body: some View {
        Text("Balance View")
    }
}

struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceView(viewModel: BalanceViewModel(configuration: configMock(), bundleMainApp: .main))
    }
}

class configMock: BalanceConfigurationProtocol {
    var config: [String : AnyObject] = ["Any" : "Any" as AnyObject]
}