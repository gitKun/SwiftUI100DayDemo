//
//  BlendModeDemo.swift
//  Drawing
//
//  Created by DR_Kun on 2020/3/6.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct BlendModeDemo: View {
    @State private var amount: CGFloat = 0.1
    
    var body: some View {
        
        VStack {
            ZStack {
                
                Image("Example")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .saturation(Double(amount))
                    .blur(radius: (1 - amount) * 20)
                    .offset(x: 0, y: 150)
                
                Circle()
                    .fill(Color(red: 1, green: 0, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: -50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    .fill(Color(red: 0, green: 1, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    .fill(Color(red: 0, green: 0, blue: 1))
                    .frame(width: 200 * amount)
                    .blendMode(.screen)
            }
            .frame(width: 300, height: 300)
            
            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("BlendMode Demo")
        
        /*
         // 图片作为 border
         Capsule()
         .strokeBorder(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.5), lineWidth: 30)
         .frame(width: 300, height: 200)
         */
    }
}

struct BlendModeDemo_Previews: PreviewProvider {
    static var previews: some View {
        BlendModeDemo()
    }
}
