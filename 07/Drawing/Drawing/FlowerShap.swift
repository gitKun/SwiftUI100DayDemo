//
//  FlowerShap.swift
//  Drawing
//
//  Created by DR_Kun on 2020/3/6.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct FlowerShap: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    
    var body: some View {
        VStack {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                .fill(Color.red, style: FillStyle(eoFill: true))
            Text("Offset")
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal, .bottom])
            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
        }
        .navigationBarTitle("Flower")
    }
}

struct FlowerShap_Previews: PreviewProvider {
    static var previews: some View {
        FlowerShap()
    }
}


struct Flower: Shape {
    var petalOffset: Double = -20// 花瓣间隔
    var petalWidth: Double = 100// 花瓣的宽
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 4) {
            let rotation = CGAffineTransform(rotationAngle: number)
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))
            let rotatedPetal = originalPetal.applying(position)
            path.addPath(rotatedPetal)
        }
        return path
    }
}
