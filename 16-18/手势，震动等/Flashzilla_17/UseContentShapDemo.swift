//
//  UseContentShapDemo.swift
//  Flashzilla_17
//
//  Created by DR_Kun on 2020/3/14.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct UseContentShapDemo: View {
    var body: some View {
        ContentShapView()
    }
}

struct UseContentShapDemo_Previews: PreviewProvider {
    static var previews: some View {
        UseContentShapDemo()
    }
}

struct ContentShapView: View {
    var body: some View {
        VStack {
            Text("Hello")
                .background(Color.gray)
            Spacer().frame(height: 100)
            Text("World")
                .background(Color.gray)
        }
            .contentShape(Rectangle()) // 使文本中的空白处也响应点击
            .onTapGesture {
                print("VStack tapped!")
        }
    }
}


struct ContentShapView2: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle tapped!")
            }
            
            Circle()
                .fill(Color.red)
                .frame(width: 300, height: 300)
                .contentShape(Rectangle()) // 使 Circle 所处的方形区域全部可以响应交互事件
                .onTapGesture {
                    print("Circle tapped!")
            }
            //.allowsHitTesting(false) // 使 Circle 不响应交互事件
            
        }
    }
}
