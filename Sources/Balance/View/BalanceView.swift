//
//  SwiftUIView.swift
//  
//
//  Created by Bodgar Espinosa Miranda on 22/08/24.
//

import SwiftUI
import DesignSystem

struct BalanceView: View {
    
    private var balance = Balance(currentAmount: 9201.57, month: "Agosto 2024")
    private var historyMonthBalance: [Transaction] = [
        .init(category: .salary, subcategory: "Salario mensual del trabajo", amount: 120000, date: Date()),
        .init(category: .debit, subcategory: "Compras de despensa en frutería", amount: 605.00, date: Date()),
        .init(category: .credit, subcategory: "Compra de nueva macbook", amount: 27000.00, date: Date()),
        .init(category: .debit, subcategory: "Compras de despensa en frutería", amount: 700.00, date: Date()),
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                BalanceCardView(title: .init(title: "Mi Balance", sizeTitle: .large),
                                subtitle: .init(title: balance.currentAmount.currencyFormat(),
                                                sizeTitle: .xxLargePlus2,
                                                isBold: true),
                                principalButtonTitle: .init(
                                    title: "AGREGAR INGRESO",
                                    colorTitle: .white,
                                    sizeTitle: .medium,
                                    isBold: true
                                ),
                                secondaryButtonTitle: .init(
                                    title: "AGREGAR GASTO",
                                    colorTitle: .white,
                                    sizeTitle: .medium,
                                    isBold: true
                                ),
                                principalButtonBackground: .purple,
                                secondaryButtonBackground: .red.opacity(0.7)
                )
                HStack {
                    GenericText(configuration: .init(title: balance.month, sizeTitle: .large, isBold: true))
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(Sizes.medium.rawValue)
                .background(Color(UIColor.systemGray6))
                List {
                    ForEach(historyMonthBalance, id: \.self) { historyBalance in
                        CellInfoView(icon: historyBalance.iconName, titleConfiguration: .init(title: historyBalance.category.rawValue, sizeTitle: .large, isBold: true), subtitleConfiguration: .init(title: historyBalance.subcategory), thirdTitleConfiguration: .init(title: historyBalance.amount.currencyFormat(), colorTitle: historyBalance.colorAmount, isBold: true))
                    }
                }
                .listStyle(PlainListStyle())
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Controla tu Lana")
        }
    }
}

#Preview {
    BalanceView()
}
