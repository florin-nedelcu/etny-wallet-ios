//
//  AccountList.swift
//  EthernityWallet
//
//  Created by King Python on 3/21/22.
//

import SwiftUI

struct AccountList: View {
    var body: some View {
        ScrollView (.horizontal){
            HStack(spacing: 10) {
                Account()
                AddAccount()
            }
            
        }
    }
}

struct AccountList_Previews: PreviewProvider {
    static var previews: some View {
        AccountList()
    }
}
