//
//  AddressView.swift
//  CupcakeCorner_10
//
//  Created by DR_Kun on 2020/3/9.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    
    
    var body: some View {
        Form {
            Section {
                TextField("城市", text: $order.city)
                TextField("街道", text: $order.streetAddress)
                TextField("姓名", text: $order.name)
                TextField("邮编", text: $order.zip)
            }
            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("提交")
                }
            }
            .disabled(order.addSprinkles)
        }
        .navigationBarTitle("订单细节", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
