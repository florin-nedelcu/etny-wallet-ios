//
//  MainView.swift
//  EthernityWallet
//
//  Created by King Python on 3/21/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            Header()
            AccountList()
            Spacer()
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
