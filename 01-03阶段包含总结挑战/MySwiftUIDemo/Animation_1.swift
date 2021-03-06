//
//  Animation_1.swift
//  MySwiftUIDemo
//
//  Created by DR_Kun on 2020/3/3.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct Animation_1: View {
    var body: some View {
        ShowOrHiddenAnimation2()
    }
}

struct Animation_1_Previews: PreviewProvider {
    static var previews: some View {
        Animation_1()
    }
}


fileprivate extension AnyTransition {
    static var moveToOpacity: AnyTransition {
        let insertion = AnyTransition.move(edge: .bottom)
        let removal = AnyTransition.opacity
        return .asymmetric(insertion: insertion, removal: removal)
    }
}


fileprivate class CModel: Identifiable {
    let id = UUID()
}



fileprivate struct ShowOrHiddenAnimation3: View {
    
    @State private var model: CModel? = nil
    
    var body: some View {
       
            NavigationView {
                ZStack {
                    Button("Tap Me") {
                        withAnimation(.easeOut(duration: 3)) {
                            self.model = CModel()
                        }
                    }
                    if self.model != nil {
                        FullScreenView1(model: $model)
                    }
                    
                }
                .navigationBarTitle("xxx", displayMode: .inline)
            }
            
            
            
    }
}

fileprivate struct ShowOrHiddenAnimation2: View {
    
    @State private var model: CModel? = nil
    
    var body: some View {
        ZStack {
            NavigationView {
                Button("Tap Me") {
                    withAnimation(.easeOut(duration: 3)) {
                        self.model = CModel()
                    }
                }
                .navigationBarTitle("xxx", displayMode: .inline)
            }
            
            if self.model != nil {
                FullScreenView1(model: $model)
                
            }
            
        }
    }
}

fileprivate struct ShowOrHiddenAnimation1: View {
    
    @State private var model: CModel? = nil
    
    var body: some View {
        ZStack {
            
            Button("Tap Me") {
                withAnimation(.easeOut(duration: 3)) {
                    self.model = CModel()
                }
            }
            
            
            if self.model != nil {
                FullScreenView1(model: $model)
                
            }
            
        }
    }
}

fileprivate struct FullScreenView1: View {
    @Binding var model: CModel?
    var body: some View {
        ZStack {
            Color.pink.edgesIgnoringSafeArea(.all)
        }
        .transition(.moveToOpacity)
        .animation(.easeOut(duration: 3))
        .onTapGesture {
            withAnimation(.easeOut(duration: 3)) {
                self.model = nil
            }
        }
    }
}


fileprivate struct ShowOrHiddenAnimation: View {
    
    @State private var isShowingRed = false
    
    var body: some View {
        print("animationAmount")
        
        return VStack {
            Button("Tap Me") {
                withAnimation(.easeInOut(duration: 5)) {
                    self.isShowingRed.toggle()
                }
            }
            
            if isShowingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    //.transition(.pivot)
                    .transition(.moveToOpacity)
            }
        }
    }
}


fileprivate struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()// 不绘制本身以外的图像
    }
}

fileprivate extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -180, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}


