//
//  ContentView.swift
//  PresentationIOS
//
//  Created by 0x384c0 on 8/10/22.
//

import SwiftUI
import Common

struct ConverterView: View {
    @ObservedObject var viewModel:ConverterViewModel
    
    @FocusState var sellFocused: Bool
    @FocusState var receiveFocused: Bool

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: Padding.medum) {
                Text("MY_BALANCES".localized)
                    .modifier(SectionHeaderModifier())
                    .padding([.leading,.trailing, .top],Padding.medum)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack() {
                        ForEach(viewModel.accounts, id: \.self) {account in
                            Text(account.label)
                                .padding([.trailing], Padding.large)
                        }
                    }
                    .padding([.leading,.trailing], Padding.medum)
                }
                .frame(height: Padding.extraLarge)
                VStack(alignment: .leading, spacing: Padding.medum) {
                    Text("CURRENCY_EXCHANGE".localized)
                        .modifier(SectionHeaderModifier())

                    ExchangeView(
                        exchangeType: .sell,
                        editable: true,
                        currencies: $viewModel.currencies,
                        currency: $viewModel.sellCurrency,
                        amount: $viewModel.sellAmount,
                        isFocused: _sellFocused
                    )
                    ExchangeView(
                        exchangeType: .receive,
                        editable: false,
                        currencies: $viewModel.currencies,
                        currency: $viewModel.receiveCurrency,
                        amount: $viewModel.receiveAmount,
                        isFocused: _receiveFocused
                    )
                    Spacer()
                        .alert(item: $viewModel.errorState, content: { error in
                            Alert(
                                title: Text("ERROR_ALERT_TITLE".localized),
                                message: Text(error.description)
                            )
                        })
                    Button("SUBMUT".localized) {
                        closeKeybaord()
                        viewModel.submit()
                    }
                    .alert(item: $viewModel.successState, content: { successState in
                        Alert(
                            title: Text("SUCCSESS_ALERT_TITLE".localized),
                            message: Text(
                                String(
                                    format: "SUCCSESS_ALERT_MESSAGE".localized,
                                    successState.sellAmount,
                                    successState.sellCurrency,
                                    successState.receiveAmount,
                                    successState.receiveCurrency,
                                    successState.feeAmount,
                                    successState.feeCurrency
                                )
                            )
                        )
                    })
                    .onAppear {
                        viewModel.refresh()
                        openKeyboard()
                    }
                    .buttonStyle(ActionButtonStyle())
                }
                .padding([.leading],Padding.medum)
            }
            .modifier(NavigationBarModifier(title: "CURRENCY_CONVERTER".localized))
        }
    }

    func openKeyboard(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { sellFocused = true }
    }
    
    func closeKeybaord(){
        sellFocused = false
        receiveFocused = false
    }
}

struct ConverterView_Previews: PreviewProvider {
    static var previews: some View {
        ConverterView(viewModel:ConverterViewModel.provideMockViewModel())
    }
}
