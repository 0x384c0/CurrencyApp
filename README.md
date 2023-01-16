# Currency App
A sample darwin app that simulates currency convertion between accounts

[![tests workflow](https://github.com/0x384c0/CurrencyApp/actions/workflows/build-darwin.yml/badge.svg)](https://github.com/0x384c0/CurrencyApp/actions/workflows/build-darwin.yml)

<img src="/media/ffmpeg_out_white.gif"> <img src="/media/ffmpeg_out_dark.gif">

### Build Requirements
- Xcode 14

# App architecture

### Modules
App has single feature - Currency conversion\
Feature split in to 3 modules
- [PresentationIOS](/PresentationIOS) - contains iOS Presentation Layer
- [Domain](/Domain) - contains Domain layer with business logic
    - [CurrencyExchangeInteractor](/Domain/Sources/Domain/interactors/CurrencyExchangeInteractor.swift) - calculates fee and performs currency exchanges
    - [AccountsInteractor](/Domain/Sources/Domain/interactors/AccountsInteractor.swift) - manages user accounts balances
    - [HistoryInteractor](/Domain/Sources/Domain/interactors/HistoryInteractor.swift) - collects and stores transaction history 
- [Data](/Data) - contains Data layer with REST API requests

### Architecture notes
- Layes implemented by [Clear Architectue Guide](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- UI layer has MVVM achitecture
- [Domain](/Domain) knows nothing about other layers
- Layers can communicate between each other only via exposed Protocols. [Injection exmple](/PresentationIOS/PresentationIOS/PresentationIOSApp.swift#L22)
- Implementations of layer protocols are injected using library Swinject.

### Communication between layers
1. UI [ConverterView](/PresentationIOS/PresentationIOS/ui/ConverterView.swift) calls functions from [ConverterViewModel](PresentationIOS/PresentationIOS/ui/ConverterViewModel.swift).
1. ViewModel executes Use cases from [Interactor](/Domain/Sources/Domain/interactors/CurrencyExchangeInteractorImpl.swift).
1. Use case obtains data from [DataSource](Data/Sources/Data/datasource/CurrencyRemoteDataSourceImpl.swift)
1. Repository returns data from a [EvpApi](/Data/Sources/Data/api/EvpApi.swift).
1. Information flows back to the UI to be displayed.

# Addition of a new functionality

### Adding new Currencies
- add new case in to [CurrencyModel](/Domain/Sources/Domain/data/CurrencyModel.swift)
- add account with new currency in to [DomainConfig.getInitialAccountState()](/Domain/Sources/Domain/DomainConfig.swift#L15) 

### Adding new Comission rules
- create new implementation of [FeeRule](Domain/Sources/Domain/interactors/feeRules/FeeRule.swift)
- add created rule implementation in to [DomainConfig.getAllFees()](/Domain/Sources/Domain/DomainConfig.swift#L23)

# Project development notes

### Dependencies and Frameworks
1. [SwiftUI](https://developer.apple.com/xcode/swiftui/)
1. [Combine](https://developer.apple.com/documentation/combine)
1. [Alamofire](https://github.com/Alamofire/Alamofire.git)
1. [Swinject](https://github.com/Swinject/Swinject.git)

### Unit tests coverage
- [Currency conversion use cases](/Domain/Tests/DomainTests/CurrencyExchangeInteractorImplTests.swift)
- [Account use cases](/Domain/Tests/DomainTests/AccountsInteractorMockImplTests.swift)
- [Transaction history use cases](/Domain/Tests/DomainTests/HistoryInteractorMockImplTests.swift)
- Note: test can be executed automatically using [Github Actions](https://github.com/0x384c0/CurrencyApp/actions/workflows/build-darwin.yml)

### Estimated time spent
|Task|Time (hours)|
|-|-|
|creating UI layer|8h|
|creating Domain layer + Unit Tests|8h|
|creating Data layer|4h|
|writing documentations|4h|
|refactoring|4h|
|TOTAL|28h|

### TODO
- add loading indicators
- add swiftlint
- add ui tests
- use [dedicated data mappers](https://medium.com/jesus-medina/mapping-data-between-layers-db8ad93f0f8f) for each layer instead of protocol inheritance 
