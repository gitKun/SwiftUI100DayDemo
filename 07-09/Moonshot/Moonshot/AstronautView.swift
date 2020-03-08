//
//  AstronautView.swift
//  Moonshot
//
//  Created by DR_Kun on 2020/3/5.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    Text(self.astronaut.description)
                        .font(.body)
                        .padding()
                        .layoutPriority(1)
                }
            }
        }
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts_zh.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
