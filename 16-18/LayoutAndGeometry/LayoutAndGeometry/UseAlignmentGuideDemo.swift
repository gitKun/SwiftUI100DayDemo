//
//  UseAlignmentGuideDemo.swift
//  LayoutAndGeometry
//
//  Created by DR_Kun on 2020/3/15.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct UseAlignmentGuideDemo: View {
    var body: some View {
        AlignmentGuideDemo4()
    }
}

struct UseAlignmentGuideDemo_Previews: PreviewProvider {
    static var previews: some View {
        UseAlignmentGuideDemo()
    }
}

// 文本对齐方式
struct AlignmentGuideDemo4: View {
    var body: some View {
        VStack(alignment: .leading) {
            #if false
            Text("Hello, world!")
            #else
            /**
             * alignmentGuide()修饰符 重写对齐的向导,使后续视图沿用更改后的对齐方式,
             * 这有两个参数：
             * 我们要更改的指南，以及一个返回新对齐方式的闭包。
             * 给闭包一个ViewDimensions对象，
             * 该对象包含其视图的宽度和高度以及读取其各种边缘的能力。
             */
            Text("Hello, world!")
                .alignmentGuide(.leading) { (d: ViewDimensions) in
                    d[.trailing]
            }
            #endif
            Text("This is a longer line of text")
        }
        .background(Color.red)
        .frame(width: 400, height: 400)
        .background(Color.blue)
    }
}

struct AlignmentGuideDemo0: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello, world!")
                .alignmentGuide(.leading) { vd in // 重写对齐的向导,使后续视图沿用更改后的对齐方式
                    vd[.trailing]
            }
            Text("This is a longer line of text")
        }
        .background(Color.red)
        .frame(width: 300, height: 300)
        .background(Color.blue)
    }
}

// 使用 alignment 创建分层视图
struct AlignmentGuideDemo1: View {
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<10) { position in
                Text("Number \(position)")
                    .alignmentGuide(.leading) { _ in CGFloat(position) * -10 }
            }
        }
        .background(Color.red)
        .frame(width: 400, height: 400)
        .background(Color.blue)
    }
}

// 使用 alignment 和 offset 控制对齐
struct AlignmentGuideDemo2: View {
    var body: some View {
        Text("Hello, World!")
            .frame(width: 300, height: 300, alignment: .leading)
            .offset(x: 40, y: -100)
            .background(Color.blue)
            .foregroundColor(.white)
    }
}

// 文本对齐方式
struct AlignmentGuideDemo3: View {
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text("Live")
                .font(.caption)
            Text("long")
            Text("and")
                .font(.title)
            Text("prosper")
                .font(.largeTitle)
        }
    }
}


// Mark: 使用自定义的 Alignment

struct ShowAlignmentDemo: View {
    var body: some View {
        ZStack {
            Color.gray.edgesIgnoringSafeArea(.all)
            #if false
            UseDefaultAligment()
            #elseif true
            UseCustomAilgnment()
            #endif
        }
    }
}


/**
 * 使用自定义修饰符
 * AlignmentID 协议只有一个要求，即符合类型必须提供一个静态defaultValue(in:)方法
 * 该方法接受一个ViewDimensions对象并返回一个CGFloat指定的视图，
 * 如果该视图没有alignmentGuide()修饰符，则该视图应如何对齐。
 */

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}



struct UseCustomAilgnment: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@twostraws")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image("touxiang_8")
                    .resizable()
                    .frame(width: 64, height: 64)
            }

            VStack {
                Text("Full name:")
                Text("SwiftUI Kun")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)
            }
        }
    }
}

struct UseDefaultAligment: View {
    var body: some View {
        HStack {
            VStack {
                Text("@twostraws")
                Image("touxiang_8")
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            
            VStack {
                Text("Full name:")
                Text("SwiftUI Kun")
                    .font(.largeTitle)
            }
        }
    }
}




