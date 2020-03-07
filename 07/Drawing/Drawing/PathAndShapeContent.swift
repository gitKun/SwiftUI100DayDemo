//
//  PathAndShapeContent.swift
//  Drawing
//
//  Created by DR_Kun on 2020/3/6.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct PathAndShapeContent: View {
    var body: some View {
        VStack {
            TestPath()
            FillAndStrokeView()
            Triangle()
                .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .frame(width: 150, height: 150)
                .padding(.bottom, 10)
            Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
                .stroke(Color.blue, lineWidth: 5)
                .frame(width: 100, height: 100)
        }
        .navigationBarTitle("Path And Shape")
    }
}

struct PathAndShapeContent_Previews: PreviewProvider {
    static var previews: some View {
        PathAndShapeContent()
    }
}



fileprivate struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

fileprivate struct TestPath: View {
    var body: some View {
        VStack {
            Path { path in
                path.move(to: CGPoint(x: 200, y: 100))
                path.addLine(to: CGPoint(x: 100, y: 300))
                path.addLine(to: CGPoint(x: 300, y: 300))
                path.addLine(to: CGPoint(x: 200, y: 100))
                path.addLine(to: CGPoint(x: 100, y: 300))
            }
            .stroke(Color.blue.opacity(0.25), lineWidth: 10)
            
            Path { path in
                path.move(to: CGPoint(x: 200, y: 400))
                path.addLine(to: CGPoint(x: 100, y: 600))
                path.addLine(to: CGPoint(x: 300, y: 600))
                path.addLine(to: CGPoint(x: 200, y:400))
            }
            .stroke(Color.blue.opacity(0.25), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round, miterLimit: 10, dash: [10, 20], dashPhase: 10))
            
        }
    }
}


/// 支持同时 fill 和 stroke
extension Shape {
    public func fill<S:ShapeStyle>(_ fillContent: S, strokeStyle: StrokeStyle) -> some View {
        ZStack {
            self.fill(fillContent)
            self.stroke(style: strokeStyle)
        }
    }
    
    public func fill<S, T>(_ fillContent: S, strokeContnets: T, strokeStyle: StrokeStyle) -> some View where S: ShapeStyle, T: ShapeStyle {
        ZStack {
            self.fill(fillContent)
            self.stroke(strokeContnets, style: strokeStyle)
        }
    }
}

// 例子

struct FillAndStrokeView: View {
    let gradient = RadialGradient(
        gradient   : Gradient(colors: [.yellow, .red]),
        center     : UnitPoint(x: 0.25, y: 0.25),
        startRadius: 0.2,
        endRadius  : 200
    )
    // stroke line width, dash
    let w: CGFloat   = 6
    let d: [CGFloat] = [20,10]
    // view body
    var body: some View {
        HStack {
            Circle()
                // ⭐️ Shape.fill(_:stroke:)
                .fill(Color.red, strokeContnets:Color.blue, strokeStyle: StrokeStyle(lineWidth:w, dash:d))
            Circle()
                .fill(gradient, strokeContnets: Color.blue, strokeStyle: StrokeStyle(lineWidth:w, dash:d))
        }
        .padding()
        .frame(height: 300)
    }
}

