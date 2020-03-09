//
//  CheckoutView.swift
//  CupcakeCorner_10
//
//  Created by DR_Kun on 2020/3/9.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("您的总消费为 $\(self.order.cost, specifier: "%.2f")")
                        .font(.title)
                    Button("下单") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text("感谢您"), message: Text(confirmationMessage), dismissButton: .default(Text("好的")))
        }
    }
    
    func placeOrder() {
        guard let encode = try? JSONEncoder().encode(order) else {
            fatalError("oredr 未能正确解码!")
        }
        // 网络请求 https://reqres.in/api/xxx
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encode
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                fatalError("未能从\'https://reqres.in\'请求到数据")
            }
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                self.confirmationMessage = "您的 \(decodedOrder.quantity)份\(Order.types[decodedOrder.type])纸杯蛋糕正在路上"
                self.showingConfirmation = true
            } else {
                print("Invalid response from server")
            }
        }.resume()
    }
    
    
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
