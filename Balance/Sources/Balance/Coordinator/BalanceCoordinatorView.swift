
import Foundation
import SwiftUI

@available(iOS 16, *)
public struct BalanceCoordinatorView<Coordinator>: View where Coordinator: BalanceCoordinatorProtocol {

    // MARK: - Properties

    @ObservedObject private var coordinator: Coordinator
    let config: BalanceConfigurationProtocol

    // MARK: - Initializer

    public init(coordinator: Coordinator, config: BalanceConfigurationProtocol) {
        self.coordinator = coordinator
        self.config = config
    }
    
    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .root)
                .navigationDestination(for: BalancePage.self) { page in
                    coordinator.build(page: page)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            print("Some action")
                        })
                        {
                            Image(systemName: "globe.fill")
                                .foregroundColor(.white)
                                .imageScale(.small)
                                .background(
                                    Color.blue.frame(width: 35, height: 35)
                                        .clipShape(RoundedRectangle(cornerRadius: 6.0))
                                )
                        }
                    }
                }
        }
        .environmentObject(coordinator)
    }
}