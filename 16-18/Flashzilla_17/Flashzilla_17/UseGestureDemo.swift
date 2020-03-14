//
//  UseGestureDemo.swift
//  Flashzilla_17
//
//  Created by DR_Kun on 2020/3/14.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct UseGestureDemo: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct UseGestureDemo_Previews: PreviewProvider {
    static var previews: some View {
        UseGestureDemo()
    }
}

// 放大手势
struct MagnificationGestureView: View {
    
    @GestureState var magnifyBy = CGFloat(1.0)
    
    var magnification: some Gesture {
        MagnificationGesture()
            .updating($magnifyBy) { currentState, gestureState, transaction in
                gestureState = currentState
        }
    }
    
    var body: some View {
        Circle()
            .frame(width: 100 * magnifyBy,
                   height: 100 * magnifyBy,
                   alignment: .center)
            .gesture(magnification)
    }
}

// 旋转手势
struct RotationGestureView: View {
    @State var angle = Angle(degrees: 0.0)
    
    var rotation: some Gesture {
        RotationGesture()
            .onChanged { angle in
                self.angle = angle
        }
    }
    
    var body: some View {
        Rectangle()
            .frame(width: 200, height: 200, alignment: .center)
            .rotationEffect(self.angle)
            .gesture(rotation)
    }
}
// 旋转手势
struct RotationGestureView2: View {
    @State private var currentAmount: Angle = .degrees(0)
    @State private var finalAmount: Angle = .degrees(0)
    
    var body: some View {
        Text("Hello, World!")
            .rotationEffect(currentAmount + finalAmount)
            .gesture(
                RotationGesture()
                    .onChanged { angle in
                        self.currentAmount = angle
                }
                .onEnded { angle in
                    self.finalAmount += self.currentAmount
                    self.currentAmount = .degrees(0)
                }
        )
    }
}


// 手势冲突1: 默认给子视图提供手势
struct GestureConflictByDefault: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .onTapGesture {
                    print("Text tapped")
            }
        }
        .onTapGesture {
            print("VStack tapped")
        }
    }
}

// 手势冲突2: .highPriorityGesture 拦截子视图手势
struct GestureConflictByHighPriorityGesture: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .onTapGesture {
                    print("Text tapped")
            }
        }
        .highPriorityGesture(
            TapGesture()
                .onEnded { _ in
                    print("VStack tapped")
            }
        )
    }
}

// 手势冲突2: .simultaneousGesture 同时识别两者(父先子后)
struct GestureConflictBySimultaneousGesture: View {
   var body: some View {
       VStack {
           Text("Hello, World!")
               .onTapGesture {
                   print("Text tapped")
               }
       }
       .simultaneousGesture(
           TapGesture()
               .onEnded { _ in
                   print("VStack tapped")
               }
       )
   }
}

// 合并手势
struct CombinGesture: View {
    
    @State private var offset = CGSize.zero
    @State private var isDragging = false

    var body: some View {
        
        let dragGesture = DragGesture()
            .onChanged { value in self.offset = value.translation }
            .onEnded { _ in
                withAnimation {
                    self.offset = .zero
                    self.isDragging = false
                }
            }

        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    self.isDragging = true
                }
            }

        /* 对一个手势与另一个手势进行排序以创建一个新手势，
         * 这导致第二个手势仅在第一个手势成功后才接收事件。
         * pressGesture 识别后 再识别 dragGesture
         */
        let combined = pressGesture.sequenced(before: dragGesture)
        
        return Circle()
            .fill(Color.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
    }
}
