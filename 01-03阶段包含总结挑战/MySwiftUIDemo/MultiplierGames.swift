//
//  MultiplierGames.swift
//  MySwiftUIDemo
//
//  Created by DR_Kun on 2020/3/3.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct MultiplierGames: View {
    static private let questionCountArray = [5, 10, 20, 25, 30]
    @State private var showGame = false
    @State private var maxNum = 8
    @State private var count = 0
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.red.edgesIgnoringSafeArea(.all)
                VStack(alignment: .trailing) {
                    HStack {
                        Text(!showGame ? "游戏设置" : "开始游戏")
                            .font(.headline)
                            .padding(.leading, 16)
                            .padding(.top, 16)
                        Spacer()
                    }
                    if showGame {
                        
                    } else {
                        Form {
                            
                            Section (header: HStack {
                                Image(systemName: "doc.text")
                                    .foregroundColor(.red)
                                Text("请选择最大乘数")
                            }) {
                                Stepper("\(maxNum)", value: $maxNum, in: 8...12, step: 1)
                            }
                            
                            Section(header: HStack {
                                Image(systemName: "doc.text")
                                    .foregroundColor(.red)
                                Text("请选择你要进行的轮数")
                            }) {
                                Picker("问题数目", selection: $count) {
                                    ForEach(0..<MultiplierGames.questionCountArray.count) { num in
                                        Text("\(MultiplierGames.questionCountArray[num])")
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                        }
                    }
                    Spacer()
                }
                .navigationBarTitle("数乘游戏", displayMode: .inline)
                .navigationBarItems(trailing: Button("开始") {
                    withAnimation {
                        
                        self.showGame.toggle()
                    }
                })
            }
        }
    }
}

struct MultiplierGames_Previews: PreviewProvider {
    static var previews: some View {
        MultiplierGames()
    }
}
