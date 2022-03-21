//
//  AddAccount.swift
//  EthernityWallet
//
//  Created by King Python on 3/21/22.
//

import SwiftUI

struct AddAccount: View {
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 100, height: 50)
                Spacer()
            }
            HStack {
                Text("Add account")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                Spacer()
            }
            Spacer()
        }
        .padding(10)
        .background(Color.green)
        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.3)
        .cornerRadius(20)
        .foregroundColor(Color.white)
    }
}

struct AddAccount_Previews: PreviewProvider {
    static var previews: some View {
        AddAccount()
    }
}
