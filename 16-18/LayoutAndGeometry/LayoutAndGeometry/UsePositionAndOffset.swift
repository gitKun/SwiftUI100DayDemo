//
//  UsePositionAndOffset.swift
//  LayoutAndGeometry
//
//  Created by DR_Kun on 2020/3/16.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct UsePositionAndOffset: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct UsePositionAndOffset_Previews: PreviewProvider {
    static var previews: some View {
        UsePositionAndOffset()
    }
}

/**
 * 1. 使用position()时，我们会得到一个新视图，
 *      该视图占据了所有可用空间，因此可以将其子项（文本）放置在正确的位置。
 * 2. 当使用offset()修饰符时，我们将更改应渲染视图的位置，
 *      而无需实际更改其底层几何形状
 */
struct UsePositionDemo: View {
    var body: some View {
        Text("Hello, World!")
            .position(x: 100, y: 100)
            .background(Color.red)
        //.edgesIgnoringSafeArea(.all)
    }
}

/**
 * 1. 使用position()时，我们会得到一个新视图，
 *      该视图占据了所有可用空间，因此可以将其子项（文本）放置在正确的位置。
 * 2. 当使用offset()修饰符时，我们将更改应渲染视图的位置，
 *      而无需实际更改其底层几何形状
 */
struct UseOffsetDemo: View {
    var body: some View {
        Text("Hello, World!")
            .offset(x: 100, y: 100)
            .background(Color.red)
        //.edgesIgnoringSafeArea(.all)
    }
}




