//
//  PlusMinusAnimationIcon.swift
//  Drawing
//
//  Created by DR_Kun on 2020/3/7.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct PlusMinusAnimationIcon: View {
    @State var size: CGFloat = 30
    @State var showingAdd = true
    var color = Color.red
    
    var insetAmount: CGFloat {
        let result = size * 0.25
        return result
    }
    
    var lineWidth: CGFloat {
        
        return size * 0.1
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(color, lineWidth: lineWidth * 0.3)
                    
                    PlusMinusShape(showingAdd: showingAdd, insetAmount: insetAmount)
                        .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.degrees(self.showingAdd ? 0 : 90))
                        .animation(.default)
                    
                }
                .frame(width: size, height: size)
                .scaleEffect(showingAdd ? 1 : 0.95)
                .animation(.spring())
                .padding()
                .onTapGesture {
                    withAnimation(.default) {
                        self.showingAdd.toggle()
                    }
                }
                
                
                Text("Size \(size, specifier: "%g")")
                Slider(value: $size, in: 20...200)
                    .padding([.horizontal, .bottom])
                
                Text("LineWidth: \(lineWidth, specifier: "%g")")
                
                Text("insetAmount: \(insetAmount, specifier: "%g")")
                    .padding()

                Spacer()
            }
            .navigationBarTitle("Animation PlusMinus")
        }
    }
}

struct PlusMinusAnimationIcon_Previews: PreviewProvider {
    static var previews: some View {
        PlusMinusAnimationIcon()
    }
}


struct PlusMinusShape: Shape {
    
    let insetAmount: CGFloat
    var lineRatio: CGFloat
    
    var showingAdd = true
    
    init(showingAdd: Bool, insetAmount: CGFloat = 10) {
        self.showingAdd = showingAdd
        self.lineRatio = showingAdd ? 1 : 0
        self.insetAmount = insetAmount
    }
    
    init() {
        self.showingAdd = true
        self.lineRatio = 1
        self.insetAmount = 10
    }
    
    var animatableData: CGFloat {
        get { self.lineRatio }
        set { self.lineRatio = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let lineSize = (rect.width - 2 * insetAmount) * 0.5
        let startX = rect.midX - lineSize * self.lineRatio
        let endX = rect.midX + lineSize * self.lineRatio
        
        let startY = rect.minY + insetAmount
        let endY = rect.maxY - insetAmount
        
        // 水平
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: startX, y: rect.midY))
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: endX, y: rect.midY))
        
        // 垂直
        path.move(to: CGPoint(x: rect.midX, y: startY))
        path.addLine(to: CGPoint(x: rect.midX, y: endY))
        
        return path
    }
}
