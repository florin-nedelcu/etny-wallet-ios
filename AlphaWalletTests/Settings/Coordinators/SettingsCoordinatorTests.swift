// Copyright SIX DAY LLC. All rights reserved.

import XCTest
@testable import AlphaWallet

extension ServerDictionary {
    static func make(server: RPCServer = .main) -> ServerDictionary<WalletSession> {
        var sessons: ServerDictionary<WalletSession> = .init()
        sessons[.main] = WalletSession.make()
        return sessons
    }
}

class SettingsCoordinatorTests: XCTestCase {
    func testOnDeleteCleanStorage() {
        class Delegate: SettingsCoordinatorDelegate, CanOpenURL {
            var deleteDelegateMethodCalled = false

            func didRestart(with account: Wallet, in coordinator: SettingsCoordinator, reason: RestartReason) {}
            func didUpdateAccounts(in coordinator: SettingsCoordinator) {}
            func didCancel(in coordinator: SettingsCoordinator) {}
            func didPressShowWallet(in coordinator: SettingsCoordinator) {}
            func assetDefinitionsOverrideViewController(for: SettingsCoordinator) -> UIViewController? { return nil }
            func showConsole(in coordinator: SettingsCoordinator) {}
            func delete(account: Wallet, in coordinator: SettingsCoordinator) {
                deleteDelegateMethodCalled = true
            }
            func didPressViewContractWebPage(forContract contract: AlphaWallet.Address, server: RPCServer, in viewController: UIViewController) {}
            func didPressViewContractWebPage(_ url: URL, in viewController: UIViewController) {}
            func didPressOpenWebPage(_ url: URL, in viewController: UIViewController) {}
            func restartToReloadServersQueued(in coordinator: SettingsCoordinator) {}
            func openBlockscanChat(in coordinator: SettingsCoordinator) {}
        }

        let storage = FakeTransactionsStorage(server: .main)
        let promptBackupCoordinator = PromptBackupCoordinator(keystore: FakeKeystore(), wallet: .make(), config: .make(), analyticsCoordinator: FakeAnalyticsService())
        let sessons = ServerDictionary<Any>.make(server: .main)

        let coordinator = SettingsCoordinator(
            navigationController: FakeNavigationController(),
            keystore: FakeEtherKeystore(),
            config: .make(),
            sessions: sessons,
            restartQueue: .init(),
            promptBackupCoordinator: promptBackupCoordinator,
            analyticsCoordinator: FakeAnalyticsService(),
            walletConnectCoordinator: .fake(),
            walletBalanceService: FakeMultiWalletBalanceService()
        )
        let delegate = Delegate()
        coordinator.delegate = delegate
        storage.add(transactions: [.make()])

        XCTAssertEqual(1, storage.transactionCount(forServer: .main))

        let accountCoordinator = AccountsCoordinator(
            config: .make(),
            navigationController: FakeNavigationController(),
            keystore: FakeEtherKeystore(),
            promptBackupCoordinator: promptBackupCoordinator,
            analyticsCoordinator: FakeAnalyticsService(),
            viewModel: .init(configuration: .changeWallets),
            walletBalanceService: FakeMultiWalletBalanceService()
        )

        XCTAssertFalse(delegate.deleteDelegateMethodCalled)
        coordinator.didDeleteAccount(account: .make(), in: accountCoordinator)
        XCTAssertTrue(delegate.deleteDelegateMethodCalled)

//        XCTAssertEqual(0, storage.count)
    }
}

import PromiseKit

final class FakeMultiWalletBalanceService: WalletBalanceService {
    var subscribableWalletsSummary: Subscribable<WalletSummary> = .init(nil)

    init(config: Config = .make(), account: Wallet = .make()) {

    }

    func subscribableWalletBalance(wallet: Wallet) -> Subscribable<WalletBalance> {
        return .init(nil)
    }

    func subscribableTokenBalance(addressAndRPCServer: AddressAndRPCServer) -> Subscribable<BalanceBaseViewModel> {
        return .init(nil)
    }

    func start() {

    }

    func refreshBalance() -> Promise<Void> {
        return .value(())
    }

    func refreshEthBalance() -> Promise<Void> {
        return .value(())
    }

    func refreshBalance(updatePolicy: PrivateBalanceFetcher.RefreshBalancePolicy, force: Bool) -> Promise<Void> {
        return .value(())
    }
}
