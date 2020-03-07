//
//  CheckerborderShape.swift
//  Drawing
//
//  Created by DR_Kun on 2020/3/6.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct CheckerborderShape: View {
    @State private var rows = true
    @State private var columns = true
    var body: some View {
        GeometryReader { geometry in
            Checkerborder(rows: self.rows ? 4 : 8, columns: self.columns ? 4 : 16)
                .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                .onTapGesture {
                    withAnimation {
                        self.rows.toggle()
                        self.columns.toggle()
                    }
            }
        }
        .navigationBarTitle("Checkerborder")
    }
}

struct CheckerborderShape_Previews: PreviewProvider {
    static var previews: some View {
        CheckerborderShape()
    }
}


struct Checkerborder: Shape {
    var rows: Int
    var columns: Int
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(rows), Double(columns))
        }
        set {
            self.rows = Int(newValue.first)
            self.columns = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowSize = rect.height / CGFloat(rows)
        let columnSize = rect.width / CGFloat(rows)
        
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2) {
                    let startX = columnSize * CGFloat(column)
                    let startY = rowSize * CGFloat(row)
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        
        return path
    }
}
