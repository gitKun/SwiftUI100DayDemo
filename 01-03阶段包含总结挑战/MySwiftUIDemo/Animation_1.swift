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
        ShowOrHiddenAnimation()
    }
}

struct Animation_1_Previews: PreviewProvider {
    static var previews: some View {
        Animation_1()
    }
}



fileprivate struct ShowOrHiddenAnimation: View {
    
    @State private var isShowingRed = false
    
    var body: some View {
        print("animationAmount")
        
        return VStack {
            Button("Tap Me") {
                withAnimation {
                    self.isShowingRed.toggle()
                }
            }
            
            if isShowingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
//                    .transition(.modifier(active: <#T##ViewModifier#>, identity: <#T##ViewModifier#>))
                    .transition(.pivot)
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
