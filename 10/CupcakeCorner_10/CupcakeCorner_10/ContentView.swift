//
//  ContentView.swift
//  CupcakeCorner_10
//
//  Created by DR_Kun on 2020/3/8.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var order = Order()
    
    @State var seleee = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack(alignment: .leading) {
                        Text("选择你需要的类型")
                        // 第二次错误: Picker 的 selection 类型必须和 ForEach 内部使用的参数($0)类型一致
                        Picker("选择你需要的类型", selection: $order.type) {
                            ForEach(0..<Order.types.count, id: \.self) {
                                Text(Order.types[$0])
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    
                    Stepper(value: $order.quantity, in: 3...20) {
                        Text("蛋糕数量: \(order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.specialRequestEnable.animation()) {
                        Text("别的特殊需求?")
                    }
                    if order.specialRequestEnable {
                        Toggle(isOn: $order.extraFrosting) {
                            Text("添加额外的糖霜配料")
                        }
                        
                        Toggle(isOn: $order.addSprinkles) {
                            Text("添加额外的酒精配料")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(order: order)) {
                        Text("交货细节")
                    }
                }
            }
            .navigationBarTitle("蛋糕角")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class Order: ObservableObject, Codable {
    static let types =  ["香草", "草莓", "巧克力", "彩虹"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnable = false {
        didSet {
            if specialRequestEnable == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    // MARK: init
    
    init() {
        
    }
    
    
    /// getter
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        cost += (Double(type) / 2)
        if extraFrosting {
            cost += Double(quantity)
        }
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        return cost
    }
    
    // MARK: Codable
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    
}




/// disable() form
struct FromDisable: View {
    @State private var userName = ""
    @State private var email = ""
    
    private var disaableForm: Bool {
        return userName.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $userName)
                TextField("Email", text: $email)
            }
            
            Button("Create account") {
                print("Create account...")
            }
            .disabled(disaableForm)
        }
    }
}
