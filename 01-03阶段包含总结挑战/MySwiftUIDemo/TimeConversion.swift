//
//  TimeConversion.swift
//  MySwiftUIDemo
//
//  Created by DR_Kun on 2020/2/29.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct TimeConversion: View {
    
    @State private var total = ""
    @State private var inputUnit = 2
    @State private var outputUnit = 0
    
    let unitArray = ["秒", "分", "时", "天"]
    let multipleArray = [1, 60, 3600, 86400]
    var resultTime: Double {
        guard inputUnit < unitArray.count && outputUnit < multipleArray.count else {
            return 0
        }
        let inputMultip = Double(multipleArray[inputUnit])
        let outputMultip = Double(multipleArray[outputUnit])
        let input = Double(total) ?? 0
        
        let output = input * inputMultip / outputMultip
        
        return output
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: HStack {
                    Image(systemName: "timer")
                    Text("Enter total time and select unit")
                }) {
                    TextField("Total", text: $total)
                        .keyboardType(.numberPad)
                    Picker("The unit of input time", selection: $inputUnit) {
                        ForEach(0 ..< unitArray.count) {
                            Text("\(self.unitArray[$0])")
                        }
                    }
                }
                
                Section(header: HStack {
                    Image(systemName: "timer")
                    Text("Select output unit")
                }) {
                    Picker("The unit of output time", selection: $outputUnit) {
                        ForEach(0 ..< unitArray.count) {
                            Text("\(self.unitArray[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: HStack {
                    Image(systemName: "timer")
                        .foregroundColor(.red)
                    Text("Result")
                }) {
                    Text("\(resultTime, specifier: "%.2f")\(unitArray[outputUnit])")
                }
            }
            .navigationBarTitle("Time Conversion")
        }
    }
}

struct TimeConversion_Previews: PreviewProvider {
    static var previews: some View {
        TimeConversion()
    }
}





