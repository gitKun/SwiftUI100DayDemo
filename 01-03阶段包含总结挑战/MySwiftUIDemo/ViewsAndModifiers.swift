//
//  ViewsAndModifiers.swift
//  MySwiftUIDemo
//
//  Created by DR_Kun on 2020/3/1.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct ViewsAndModifiers: View {
    var body: some View {
        GridStack(rows: 4, columns: 4) { row, col in
            Image(systemName: "\(4 * row + col).circle")
            Text("R\(row) C\(col)")
        }
    }
}

struct ViewsAndModifiers_Previews: PreviewProvider {
    static var previews: some View {
        ViewsAndModifiers()
    }
}


fileprivate struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0 ..< self.columns) { row in
                HStack {
                    ForEach(0 ..< self.columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
    
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}

fileprivate struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
    }
}

extension View {
    fileprivate func titleStyle() -> some View {
        self.modifier(Title())
    }
}

fileprivate struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

extension View {
    fileprivate func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}
