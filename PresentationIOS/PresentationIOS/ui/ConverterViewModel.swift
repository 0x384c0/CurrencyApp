//
//  ConverterViewModel.swift
//  PresentationIOS
//
//  Created by 0x384c0 on 8/10/22.
//

import Foundation
import Combine
import Domain
import Common

class ConverterViewModel: ObservableObject {
    //MARK: Constants
    private let DEFAULT_SELL_AMOUNT = 100.0
    private var DEFAULT_SELL_CURRENCY:String? { currencies.first }
    private var DEFAULT_RECEIVE_CURRENCY:String? { currencies.last }

    //MARK: init
    private let accountsInteractor:AccountsInteractor
    private let currencyExchangeInteractor:CurrencyExchangeInteractor
    init(accountsInteractor: AccountsInteractor, currencyExchangeInteractor: CurrencyExchangeInteractor) {
        self.accountsInteractor = accountsInteractor
        self.currencyExchangeInteractor = currencyExchangeInteractor
    }

    //MARK: State
    var currencies = [String]()
    @Published var loading = false
    @Published var loadingReceiveAmount = false
    @Published var accounts = [AccounState]()
    @Published var sellAmount:Double?
    @Published var sellCurrency:String?
    @Published var receiveAmount:Double?
    @Published var receiveCurrency:String?
    @Published var successState: SuccessState?
    @Published var errorState: ErrorState?

    //MARK: LifeCycle
    func refresh(){
        refreshCancellable?.cancel()
        refreshCancellable = Publishers.CombineLatest3(
            $sellAmount.debounce(for: 0.3, scheduler: DispatchQueue.main),
            $sellCurrency,
            $receiveCurrency
        )
        .map{InputsState(sellAmount:$0,sellCurrency:$1,receiveCurrency:$2)}
        .debounce(for: 0.01, scheduler: DispatchQueue.main)
        .removeDuplicates()
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
        .flatMap{[unowned self] state in
            accountsInteractor
                .getAccounts()
                .map{[unowned self] models in
                    accounts = models.map{AccounState(model: $0)}
                }
                .map{state}
        }
        .flatMap{[unowned self] state in
            currencyExchangeInteractor
                .getCurrencies()
                .map{[unowned self] models in
                    currencies = models.map{$0.rawValue}
                }
                .map{state}
        }
        .sink(
            receiveCompletion: {[unowned self] completion in
                switch completion {
                case .failure(let error): errorState = ErrorState(error:error)
                case .finished: break
                }
            },
            receiveValue:  { [unowned self] state in
                print(state)
                if sellAmount == nil { sellAmount = DEFAULT_SELL_AMOUNT }
                if sellCurrency == nil { sellCurrency = DEFAULT_SELL_CURRENCY ?? "" }
                if receiveCurrency == nil { receiveCurrency = DEFAULT_RECEIVE_CURRENCY ?? "" }
                updateState(newState: state)
            }
        )
    }

    deinit {
        refreshCancellable?.cancel()
    }

    //MARK: UI Actions
    private var oldState:InputsState?
    private func updateState(newState:InputsState) {
        if (sellCurrency == receiveCurrency){
            swapCurrencies(sellCurrencyChanged: oldState?.sellCurrency != newState.sellCurrency, oldState: oldState)
        } else {
            refreshReceiveAmount()
        }
        oldState = newState
    }

    func submit(){
        if
            !loadingReceiveAmount,
            !loading,
            let sellAmount = sellAmount,
            let sellCurrencyString = sellCurrency,
            let receiveAmount = receiveAmount,
            let receiveCurrencyString = receiveCurrency,
            let sellCurrency = CurrencyModel(rawValue: sellCurrencyString),
            let receiveCurrency = CurrencyModel(rawValue: receiveCurrencyString){
            loading = true
            submitCancellable = currencyExchangeInteractor
                .submitExchange(
                    sellAmount: sellAmount,
                    sellCurrency: sellCurrency,
                    receiveAmount: receiveAmount,
                    receiveCurrency: receiveCurrency
                )
                .flatMap({ [unowned self] model in
                    accountsInteractor
                        .getAccounts()
                        .mapError{_ in TransactionError.unknownError}
                        .map{[unowned self] models in
                            accounts = models.map{AccounState(model: $0)}
                        }
                        .map{model}
                })
                .sink { [unowned self] completion in
                    loading = false
                    switch completion {
                    case .failure(let error): errorState = ErrorState(error:error)
                    case .finished: break
                    }
                } receiveValue: { [unowned self] model in
                    successState = SuccessState(model:model)
                }
        }
    }

    //MARK: Private
    private var refreshCancellable: AnyCancellable?
    private var exchangeCancellable: AnyCancellable?
    private var submitCancellable: AnyCancellable?

    private func swapCurrencies(sellCurrencyChanged:Bool, oldState:InputsState?){
        if let oldState = oldState,
           let sellCurrency = oldState.sellCurrency,
           let receiveCurrency = oldState.receiveCurrency{
            if sellCurrencyChanged {
                self.receiveCurrency = sellCurrency
            } else {
                self.sellCurrency = receiveCurrency
            }
        }
    }

    private func refreshReceiveAmount(){
        if let sellAmount = sellAmount,
           let sellCurrencyString = sellCurrency,
           let receiveCurrencyString = receiveCurrency,
           let sellCurrency = CurrencyModel(rawValue: sellCurrencyString),
           let receiveCurrency = CurrencyModel(rawValue: receiveCurrencyString){
            loadingReceiveAmount = true
            exchangeCancellable = currencyExchangeInteractor
                .calculateExchange(
                    sellAmount: sellAmount,
                    sellCurrency: sellCurrency,
                    receiveCurrency: receiveCurrency
                )
                .sink { [unowned self] completion in
                    loadingReceiveAmount = false
                    switch completion {
                    case .failure(let error): errorState = ErrorState(error:error)
                    case .finished: break
                    }
                } receiveValue: { [unowned self] model in
                    receiveAmount = model.receiveAmount
                }
        }
    }

    //MARK: mock
    static func provideMockViewModel() -> ConverterViewModel{
        ConverterViewModel(
            accountsInteractor: DIContainer.shared.resolve(AccountsInteractor.self)!,
            currencyExchangeInteractor: DIContainer.shared.resolve(CurrencyExchangeInteractor.self)!
        )
    }
}
