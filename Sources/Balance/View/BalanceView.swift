//
//  SwiftUIView.swift
//  
//
//  Created by Bodgar Espinosa Miranda on 22/08/24.
//

import SwiftUI
import DesignSystem

struct BalanceView: View {
    
    private let viewModel: BalanceViewModel
    
    init(viewModel: BalanceViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    BalanceCardView(title: .init(title: viewModel.title, sizeTitle: .large),
                                    subtitle: .init(title: viewModel.balance.currentAmount.currencyFormat(),
                                                    sizeTitle: .xxLargePlus2,
                                                    isBold: true),
                                    principalButtonTitle: .init(
                                        title: viewModel.firstButtonTitle,
                                        colorTitle: .white,
                                        sizeTitle: .medium,
                                        isBold: true
                                    ),
                                    secondaryButtonTitle: .init(
                                        title: viewModel.secondButtonTitle,
                                        colorTitle: .white,
                                        sizeTitle: .medium,
                                        isBold: true
                                    ),
                                    principalButtonBackground: .purple,
                                    secondaryButtonBackground: .red.opacity(0.7),
                                    callbackFirstButton: {
                        self.viewModel.sendToAddCashInView()
                    },
                                    callbackSecondButton: {
                        self.viewModel.sendToCashOutView()
                    })
                    HStack {
                        GenericText(configuration: .init(title: viewModel.balance.month, sizeTitle: .large, isBold: true))
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(Sizes.medium.rawValue)
                    .background(Color(UIColor.systemGray6))
                    if viewModel.historyMonthBalance.count == 0 {
                        ErrorMessageView(
                            icon: CashIcons.withoutCash.image,
                            title: .init(title: viewModel.errorTitle,
                                         sizeTitle: .xxLargePlus2,isBold: true),
                            subtitle: .init(title: viewModel.errorSubtitle,
                                            sizeTitle: .large)
                        )
                        Spacer()
                    } else {
                        ForEach(viewModel.historyMonthBalance, id: \.self) { historyBalance in
                            CellInfoView(icon: historyBalance.iconName, titleConfiguration: .init(title: historyBalance.category.rawValue, sizeTitle: .large, isBold: true), subtitleConfiguration: .init(title: historyBalance.subcategory), thirdTitleConfiguration: .init(title: historyBalance.amount.currencyFormat(), colorTitle: historyBalance.colorAmount, isBold: true))
                        }
                    }
                }
                .navigationTitle("Controla tu Lana")
            }
        }
    }
}

#Preview {
    BalanceView(viewModel: BalanceViewModel())
}
