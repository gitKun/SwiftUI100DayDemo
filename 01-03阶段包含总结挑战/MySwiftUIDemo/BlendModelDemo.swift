//
//  BlendModelDemo.swift
//  MySwiftUIDemo
//
//  Created by DR_Kun on 2020/4/5.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct BlendModelDemo: View {
    @State private var size: CGFloat = 200
    var body: some View {
        ZStack {
            
            Color(red: 0.3, green: 0.6, blue: 0.1).frame(width: size, height: size)
                
            Image("touxiang_8")
                .resizable()
                .frame(width: size, height: size)
                .onTapGesture {
                    self.size = CGFloat.random(in: 50...200)
            }
            
            
                
            
        }
    }
}

struct BlendModelDemo_Previews: PreviewProvider {
    static var previews: some View {
        BlendModelDemo()
    }
}
