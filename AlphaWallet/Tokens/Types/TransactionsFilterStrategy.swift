//Copyright © 2022 Stormbird PTE. LTD.

import Foundation 

enum TransactionsFilterStrategy {
    case all
    case filter(strategy: ActivitiesFilterStrategy, tokenObject: TokenObject)
}
