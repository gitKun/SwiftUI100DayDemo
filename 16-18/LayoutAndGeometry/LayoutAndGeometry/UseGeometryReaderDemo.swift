//
//  UseGeometryReaderDemo.swift
//  LayoutAndGeometry
//
//  Created by DR_Kun on 2020/3/16.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct UseGeometryReaderDemo: View {
    var body: some View {
        OuterView()
            .background(Color.red)
            .coordinateSpace(name: "Custom")
    }
}

struct UseGeometryReaderDemo_Previews: PreviewProvider {
    static var previews: some View {
        UseGeometryReaderDemo()
    }
}

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(Color.green)
            Text("Bottom")
        }
    }
}
/**
 *该代码运行时所获得的输出取决于您所使用的设备，但这是我得到的：
 *
 * Global center: 202.0 x 455.16666666666663
 * Custom center: 202.0 x 411.16666666666663
 * Local center:  164.0 x 378.5
 *
 * 这些尺寸大部分是不同的，因此希望您能看到这些框架如何工作的全部范围：
 
 * 1. 全局中心X为202表示文本视图的中心距离屏幕左边缘202个点。这并不是死在屏幕中央，
 *      因为“左”和“右”标签的大小不同。
 *      全局中心Y为455.167表示文本视图的中心距屏幕顶部边缘455.167点。
 *      这并不是死在屏幕中央，因为顶部的安全区域比底部的安全区域大。
 * 2. 自定义中心X为202表示文本视图的中心距拥有“自定义”坐标空间的任何视图的左边缘202个点，
 *      在我们的情况下，这是OuterView因为我们将其附加到ContentView。
 *      该数字与全局位置匹配，因为OuterView水平边缘到另一边缘。
 *      自定义中心Y为411.167表示文本视图的中心距离的顶部边缘为411.167点OuterView。
 *      该值小于全局中心Y，因为OuterView它没有扩展到安全区域。
 * 3. 局部中心X为164表示文本视图的中心距离其直接容器的左边缘164点，
 *      在这种情况下为GeometryReader。
 *      Y的本地中心378.5表示文本视图的中心距离其直接容器的顶部边缘378.6点，
 *      该顶部再次是GeometryReader。
 *
 * 您要使用哪个坐标空间取决于您要回答的问题：
 *
 * 1. 是否想知道此视图在屏幕上的什么位置？使用全局空间。
 * 2. 是否想知道此视图相对于其父视图的位置？使用本地空间。
 * 3. 要知道该视图相对于其他视图的位置？使用自定义空间。
 */
struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            GeometryReader { geo in
                Text("Center")
                    .background(Color.blue)
                    .onTapGesture {
                        print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                        print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                }
                // .contentShape(Rectangle())
            }
            .background(Color.orange)
            Text("Right")
        }
    }
}

