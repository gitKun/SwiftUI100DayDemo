//
//  TrapezoidShap.swift
//  Drawing
//
//  Created by DR_Kun on 2020/3/6.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

/**
 * 1. 平移后旋转 和 旋转后平移 是不同的效果,
 *      类似于先左转再向前走10步和先向前走10步再左转
 * 2. saturation 颜色的饱和度
 * 3. brightness 颜色的明亮度
 */

struct TrapezoidShap: View {
    @State private var insetAmount: CGFloat = 50
    var body: some View {
        Trapezoid(insetAmount: insetAmount)
            .fill(Color(
                hue: Double.random(in: 0...1),
                saturation: Double.random(in: 0...1),
                brightness: Double.random(in: 0...1)
            ))
            .frame(width: 200, height: 100)
            .onTapGesture {
                withAnimation(Animation.easeIn(duration: 4)) {
                    self.insetAmount = CGFloat.random(in: 10...50)
                }
        }
        .rotationEffect(.degrees(45))
        .transformEffect(CGAffineTransform(translationX: 0, y: 50))
        .navigationBarTitle("Trapezoid")
    }
}


struct TrapezoidShap_Previews: PreviewProvider {
    static var previews: some View {
        TrapezoidShap()
    }
}


struct Trapezoid: Shape {
    var insetAmount: CGFloat
    
    var animatableData: CGFloat {
        get { insetAmount }
        set { self.insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        return path
    }
}
