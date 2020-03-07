//
//  DrawingGroupDemo.swift
//  Drawing
//
//  Created by DR_Kun on 2020/3/6.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct DrawingGroupDemo: View {
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            ColorCyclingCircle(amount: self.colorCycle)
                .frame(width: 300, height: 300)
            Slider(value: $colorCycle)
                .padding([.horizontal, .top])
        }
        .navigationBarTitle("DrawingGroup Demo")
    }
}

struct DrawingGroupDemo_Previews: PreviewProvider {
    static var previews: some View {
        DrawingGroupDemo()
    }
}


/**
 * drawingGroup()
 *
 * 这告诉SwiftUI，在将视图内容作为单个呈现的输出放回到屏幕上之前，
 * 应将视图的内容呈现到屏幕外的图像中，这要快得多。
 * 在幕后，此功能由Metal提供支持，
 * Metal是Apple的框架，可直接与GPU协同工作以实现极快的图形。
 */


struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        if targetHue > 1 {
            targetHue -= 1
        }
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                self.color(for: value, brightness: 1),
                                self.color(for: value, brightness: 0.5)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2)
            }
        }
        .drawingGroup()
    }
}
