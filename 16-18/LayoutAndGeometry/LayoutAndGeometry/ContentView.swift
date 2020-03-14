//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by DR_Kun on 2020/3/14.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        AlignmentGuideDemo0()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




struct AlignmentGuideDemo0: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello, world!")
                .alignmentGuide(.leading) { vd in
                    vd[.trailing]
            }
            Text("This is a longer line of text")
        }
        .background(Color.red)
        .frame(width: 300, height: 300)
        .background(Color.blue)
    }
}


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
