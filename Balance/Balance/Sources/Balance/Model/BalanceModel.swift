
import Foundation
import SwiftUI

public struct BalanceModel: Identifiable, Hashable {

    // MARK: - Properties

    public var id: UUID
    public var name: String
    
    public static func == (lhs: BalanceModel, rhs: BalanceModel) -> Bool {
        return lhs.name == rhs.name
    }
    
    // MARK: - Initializer
    
    public init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}