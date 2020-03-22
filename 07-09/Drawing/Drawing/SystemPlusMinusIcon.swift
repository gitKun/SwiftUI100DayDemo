//
//  SystemPlusMinusIcon.swift
//  Drawing
//
//  Created by DR_Kun on 2020/3/22.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct SystemPlusMinusIcon: View {
    
    @State private var isPlus = true
    
    var body: some View {
        
        VStack {
            Button(action: {
                withAnimation(Animation.easeInOut(duration: 1.5)) {
                    self.isPlus.toggle()
                }
            }) {
                Image(systemName: self.isPlus ? "plus" : "minus")
                    .font(.title)
            }
        }
        
    }
}

struct SystemPlusMinusIcon_Previews: PreviewProvider {
    static var previews: some View {
        SystemPlusMinusIcon()
    }
}
