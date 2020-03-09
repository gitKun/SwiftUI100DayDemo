//
//  BindingDemo.swift
//  Bookworm_11
//
//  Created by DR_Kun on 2020/3/9.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct BindingDemo: View {
    @State private var rememberMe = false
    var body: some View {
        VStack {
            PushButton(title: "Tap me", isOn: $rememberMe)
            Text(rememberMe ? "On" : "Off")
        }
    }
}

struct BindingDemo_Previews: PreviewProvider {
    static var previews: some View {
        BindingDemo()
    }
}



struct PushButton: View {
    let title: String
    @Binding var isOn: Bool
    
    var  onColor = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]
    
    var body: some View {
        Button(title) {
            self.isOn.toggle()
        }
        .padding()
        .background(LinearGradient(
            gradient: Gradient(colors: isOn ? onColor : offColors),
            startPoint: .top,
            endPoint: .bottom)
        )
            .foregroundColor(.white)
            .clipShape(Capsule())
            .shadow(radius: isOn ? 0 : 5)
    }
}

