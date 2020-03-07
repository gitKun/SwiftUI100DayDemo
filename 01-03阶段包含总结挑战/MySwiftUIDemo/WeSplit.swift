//
//  WeSplit.swift
//  MySwiftUIDemo
//
//  Created by DR_Kun on 2020/2/29.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct WeSplit: View {
    var body: some View {
        WeSplitView()
    }
}

struct WeSplit_Previews: PreviewProvider {
    static var previews: some View {
        WeSplit()
    }
}


struct WeSplitView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    // 计算属性
    var totalPerPerson: Double {
        // calculate the total per person here
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: MySectionHeader1()) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                        .foregroundColor(tipPercentage == tipPercentages.count - 1 ? .red : .black)
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}


// Subviews
struct MySectionHeader1: View {
    var body: some View {
        HStack {
            Image(systemName: "creditcard")
                .foregroundColor(.red)
            Text("How much tip do you want to leave?")
        }
    }
}
