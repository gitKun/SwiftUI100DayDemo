//
//  ContentView.swift
//  MySwiftUIDemo
//
//  Created by DR_Kun on 2020/2/22.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GuessFlag()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// Test Views

/**
 * 为什么修饰符的顺序很重要: SwiftUI 会逐条初始化 struct: View ,不同的顺序就是不同的 struct
 *
 * 1. 每次我们修改视图时，SwiftUI都会使用泛型：来应用该修改器 `ModifiedContent<OurThing, OurModifier>。`
 * 2. 当我们应用多个修饰符时，它们会叠加起来：`ModifiedContent<ModifiedContent<…`
 */
struct ModifierOrderDemo: View {
    var body: some View {
        Text("Hello, World!")
            .padding(.all, 20)
            .background(Color.red)
            .padding()
            .background(Color.blue)
            .padding()
            .background(Color.green)
            .padding()
            .background(Color.yellow)
    }
}

struct NameFormInfoView1: View {
    @State private var name = ""
    var body: some View {
        NavigationView {
            Form {
                TextField("Enter your name", text: $name)
                HStack {
                    Text("Your name is:")
                    Text("\(name)")
                        .foregroundColor(.red)
                }
            }
            .navigationBarTitle("SwiftUI", displayMode: .inline)
        }
    }
}

struct MyForme1: View {
    var body: some View {
        Form {
            Section {
                HStack {
                    Text("Hello World")
                        .font(Font.system(size: 16, weight: .bold))
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    Image(systemName: "heart")
                        .foregroundColor(.green)
                    Button(action: {
                        print("Info button clicked!")
                    }) {
                        Image(systemName: "info.circle")
                            .foregroundColor(.blue)
                    }
                    .frame(maxWidth: 40, maxHeight: 40)
                }
                Text("Hello World")
            }
            Section {
                Text("Hello World")
                HStack {
                    Text("Hello World")
                        .font(Font.system(size: 16, weight: .bold))
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    Image(systemName: "heart")
                        .foregroundColor(.green)
                    
                    Image(systemName: "info.circle")
                        .foregroundColor(.blue)
                    
                }
                Text("Hello World")
            }
        }
        .navigationBarTitle(Text("SwiftUI"), displayMode: .automatic)
    }
}

struct ShowAlert1: View {
    @State private var showAlert = false
    var body: some View {
        Button("Show Alert") {
            self.showAlert = true
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Alert"), message: Text("Hello SwiftUI"), dismissButton: .default(Text("OK")))
        }
    }
}

struct HeartButton: View {
    @State private var animationAmount: CGFloat = 1
    var body: some View {
        Button("Tap Me") {
            // do nothing
            //            self.animationAmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.red)
                .scaleEffect(animationAmount * 0.75)
                .opacity(Double(2 - animationAmount))
                .animation(
                    Animation.easeOut(duration: 1)
                        .repeatForever(autoreverses: false)
            )
        )
            .onAppear {
                self.animationAmount = 2
        }
    }
}

/// 蛇形文字动画 animation
fileprivate struct Serpentine: View {
    private let letters = Array("Hello SwiftUI")
    @State private var dragAmount = CGSize.zero
    @State private var enable = false
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { num in
                Text(String(self.letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(self.enable ? Color.blue : .red)
                    .offset(self.dragAmount)
                    .animation(Animation.default.delay(Double(num) / 20))
            }
        }
        .gesture(
            DragGesture()
                .onChanged{ self.dragAmount = $0.translation }
                .onEnded { _ in
                    self.dragAmount = .zero
                    self.enable.toggle()
            }
        )
            .onAppear {
                self.dragAmount = CGSize(width: 0, height: 50)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.dragAmount = CGSize(width: 0, height: -20)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.dragAmount = .zero
                    self.enable.toggle()
                }
        }
    }
}

