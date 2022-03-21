//
//  Account.swift
//  EthernityWallet
//
//  Created by King Python on 3/21/22.
//

import SwiftUI

struct Account: View {
    var body: some View {
        VStack {
            HStack {
                Text("My account")
                Spacer()
            }
            HStack {
                Text("0x0000000000000")
                Spacer()
            }
            Spacer()
            HStack {
                Text("$0.00")
                Spacer()
            }
            Spacer()
            HStack {
                Text("0 ETH and 0 Tokens")
                    .frame(width: 100)
                    .multilineTextAlignment(.center)
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray)
                        .frame(width: 50, height: 50)
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray)
                        .frame(width: 50, height: 50)
                }
            }
        }
        .padding(30)
        .background(Color.blue)
        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.3)
        .cornerRadius(20)
        .foregroundColor(Color.white)
        
    }
}

struct Account_Previews: PreviewProvider {
    static var previews: some View {
        Account()
    }
}
