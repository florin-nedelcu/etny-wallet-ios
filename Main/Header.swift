//
//  Header.swift
//  EthernityWallet
//
//  Created by King Python on 3/21/22.
//

import SwiftUI

struct Header: View {
    var body: some View {
        VStack {
            HStack {
                Text("Wallet")
                    .font(.system(size: 36))
                    .fontWeight(.bold)
                Spacer()
            }
            HStack {
                Text("TOTAL PORTFOLIO VALUE")
                    .font(.system(size: 14))
                Spacer()
            }
            HStack {
                Text("$0.00")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                Spacer()
            }
        }.padding(10)
        
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
