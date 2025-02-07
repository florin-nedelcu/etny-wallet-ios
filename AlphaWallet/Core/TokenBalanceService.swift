// Copyright SIX DAY LLC. All rights reserved.

import Foundation

protocol TokenBalanceService {
    var ethBalanceViewModel: BalanceBaseViewModel { get }
    var subscribableEthBalanceViewModel: Subscribable<BalanceBaseViewModel> { get }

    func refresh()
    func refreshEthBalance()

    // NOTE: only tests purposes
    func update()

    func coinTicker(_ addressAndRPCServer: AddressAndRPCServer) -> CoinTicker?
    func subscribableTokenBalance(_ addressAndRPCServer: AddressAndRPCServer) -> Subscribable<BalanceBaseViewModel>
}

class SingleChainTokenBalanceService: NSObject, TokenBalanceService {
    private let wallet: Wallet
    private let server: RPCServer

    var ethBalanceViewModel: BalanceBaseViewModel {
        if let value = privateSubscribableViewModel.value {
            return value
        } else {
            return NativecryptoBalanceViewModel(server: server, balance: Balance(value: .zero), ticker: nil)
        }
    }

    lazy private (set) var subscribableEthBalanceViewModel: Subscribable<BalanceBaseViewModel> = .init(ethBalanceViewModel)

    lazy private var privateSubscribableViewModel: Subscribable<BalanceBaseViewModel> = {
        let etherToken = MultipleChainsTokensDataStore.functional.etherToken(forServer: server).addressAndRPCServer
        return subscribableTokenBalance(etherToken)
    }()

    private let walletBalanceService: WalletBalanceService
    private var balanceSubscriptionKey: Subscribable<BalanceBaseViewModel>.SubscribableKey?
    
    init(wallet: Wallet, server: RPCServer, walletBalanceService: WalletBalanceService) {
        self.wallet = wallet
        self.server = server
        self.walletBalanceService = walletBalanceService

        super.init()

        balanceSubscriptionKey = privateSubscribableViewModel.subscribe { [weak subscribableEthBalanceViewModel] viewModel in
            DispatchQueue.main.async {
                subscribableEthBalanceViewModel?.value = viewModel
            }
        }
    }

    func coinTicker(_ addressAndRPCServer: AddressAndRPCServer) -> CoinTicker? {
        subscribableTokenBalance(addressAndRPCServer).value?.ticker
    }

    func subscribableTokenBalance(_ addressAndRPCServer: AddressAndRPCServer) -> Subscribable<BalanceBaseViewModel> {
        walletBalanceService.subscribableTokenBalance(addressAndRPCServer: addressAndRPCServer)
    }

    deinit {
        balanceSubscriptionKey.flatMap { privateSubscribableViewModel.unsubscribe($0) }
    }

    func refresh() {
        walletBalanceService.refreshBalance().done { _ in

        }.cauterize()
    }
    func refreshEthBalance() {
        walletBalanceService.refreshEthBalance().done { _ in

        }.cauterize()
    }

    func update() {
        // NOTE: update method to refresh subscribable view model, only tests purposes
        subscribableEthBalanceViewModel.value = ethBalanceViewModel
    }
}
