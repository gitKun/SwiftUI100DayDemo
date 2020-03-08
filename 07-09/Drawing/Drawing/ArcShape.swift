//
//  ArcShape.swift
//  Drawing
//
//  Created by DR_Kun on 2020/3/6.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct ArcShape: View {
    var body: some View {
        Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
            .strokeBorder(Color.red, lineWidth: 40)
            .navigationBarTitle("Arc Insettable")
    }
}

struct ArcShape_Previews: PreviewProvider {
    static var previews: some View {
        ArcShape()
    }
}



/// 按照人类理解方式正确的画圆弧的方法
struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var amount: CGFloat = 0
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - amount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        return path
    }
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.amount = amount
        return arc
    }
}

