//
//  ContentView.swift
//  DailyHabits
//
//  Created by DR_Kun on 2020/3/8.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    
    var showingListStyle = false
    
    var body: some View {
        TabView(selection: $selection) {
            ZStack {
                Color(red: 0.96, green: 0.96, blue: 0.96)
                    .edgesIgnoringSafeArea(.all)
                NavigationView {
                    VStack {
                        ScrollView(.horizontal) {
                            HStack {
                                
                                Button(action: {
                                    
                                }) {
                                    TimeTypeButton(name: "全部", isSelected: true)
                                }
                                Button(action: {
                                    
                                }) {
                                    TimeTypeButton(name: "任意时间")
                                }
                                Button(action: {
                                    
                                }) {
                                    TimeTypeButton(name: "睡前")
                                }
                            }
                            .padding()
                            //.background(Color.red)
                        }
                        
                        
                        if showingListStyle {
                            List {
                                HabitsListCell()
                                AddHabitsListCell()
                            }
                        } else {
                            ScrollView(.vertical) {
                                
                                HabitsListCell()
                                    .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                                
                                Button(action: {
                                    print("xxxx")
                                }) {
                                    AddHabitsListCell()
                                        .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                                }
                                
                            }
                        }
                        
                    }
                    .navigationBarTitle("所有习惯", displayMode: .inline)
                }
            }
            .tabItem {
                VStack {
                    Image(systemName: "calendar")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.red)
                    Text("日常习惯")
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TimeTypeButton: View {
    let name: String
    var isSelected = false
    var body: some View {
        Text(name)
            .font(Font.system(size: 14))
            .fontWeight(.bold)
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(Color(red: 0.93, green: 0.93, blue: 0.93, opacity: isSelected ? 0.85 : 0))
            .foregroundColor(Color(red: 0.388, green: 0.388, blue: 0.388))
            .layoutPriority(1.0)
            .clipShape(Capsule())
    }
}

struct HabitsListCell: View {
    var body: some View {
        ZStack {
            Color(red: 0.89, green: 0.94, blue: 0.99)
            HStack {
                Image(systemName: "hare")
                    .resizable()
                    .frame(width: 42, height: 42)
                    .foregroundColor(Color(red: 0.2588, green: 0.596, blue: 0.815686))
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0))
                VStack(alignment: .leading) {
                    Text("腹肌训练入门")
                        .font(Font.system(size: 14))
                        .fontWeight(.bold)
                    
                    Text("为了衣服")
                        .font(Font.system(size: 10))
                        .foregroundColor(Color(red: 0.435, green: 0.443, blue: 0.455))
                        .padding(.top, 2)
                    
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("\(4) 天")
                        .font(Font.system(size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0, green: 0, blue: 0))
                    
                    Text("共计坚持")
                        .font(Font.system(size: 10))
                        .foregroundColor(Color(red: 0.235, green: 0.243, blue: 0.255))
                        .padding(.top, 2)
                }
                GeometryReader { geo in
                    ZStack {
                        
                        Image(systemName: "heart.fill")
                            .resizable()
                            .foregroundColor(Color(red: 1, green: 0.5, blue: 0.5))
                            .frame(width: 15, height: 15)
                    }
                    .frame(width: 15, height: geo.size.height)
                        .offset(x: -2, y: 10 - geo.size.height * 0.5) // scrollView
                    //.offset(x: -2, y: 10 - geo.size.height * 0.5) // List
                }
                .frame(width: 17)
            }
            .overlay(Rectangle().stroke(Color.primary, lineWidth: 1))
        }
    }
}

struct Habitssssss {
    
    var backgroundColorValue: (r: Int, g: Int, b: Int) = (0, 0, 0)
}



extension Color {
    init(_ colorValue: (r: Int, g: Int, b: Int), a: Double = 1) {
        let red = Double(colorValue.r) / 255
        let green = Double(colorValue.g) / 255
        let blue = Double(colorValue.b) / 255
        self.init(red: red, green: green, blue: blue, opacity: a)
    }
}


struct AddHabitsListCell: View {
    
    let textColor = Color((177, 177, 177)) //Color(red: 0.7, green: 0.7, blue: 0.7)
    
    var body: some View {
        ZStack {
            Color(red: 0.9747, green: 0.9647, blue: 0.9725)
            HStack(spacing: 3) {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 8, height: 8)
                    .foregroundColor(textColor)
                Text("添加一个自定义习惯")
                    .font(Font.system(size: 14))
                    .foregroundColor(textColor)
                    .padding(EdgeInsets(top: 24, leading: 0, bottom: 24, trailing: 0))
            }
        }
    }
    
}


