//
//  ContentView.swift
//  Drawing
//
//  Created by DR_Kun on 2020/3/5.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI


// @inlinable public init<I>(_ base: I) where Element == I.Element, I : IteratorProtocol

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: SpirographShap()) {
                    Text("SpirographShape")
                        .padding(.vertical)
                }
                NavigationLink(destination:  CheckerborderShape()) {
                    Text("CheckerborderShape")
                        .padding(.vertical)
                }
                NavigationLink(destination: TrapezoidShap()) {
                    Text("TrapezoidShape")
                        .padding(.vertical)
                }
                NavigationLink(destination: FlowerShap()) {
                    Text("FlowerShape")
                        .padding(.vertical)
                }
                NavigationLink(destination: ArcShape()) {
                    Text("ArcShape")
                        .padding(.vertical)
                }
                NavigationLink(destination: PathAndShapeContent()) {
                    Text("PathAndShape")
                        .padding(.vertical)
                }
                NavigationLink(destination: DrawingGroupDemo()) {
                    Text("DrawingGroupDemo")
                        .padding(.vertical)
                }
                NavigationLink(destination: BlendModeDemo()) {
                    Text("BlendModelDemo")
                        .padding(.vertical)
                }
                NavigationLink(destination: PlusMinusAnimationIcon()) {
                    Text("AnimationIcon-PlusMinus")
                        .padding(.vertical)
                }
                NavigationLink(destination: SystemPlusMinusIcon()) {
                    Text("SystemPlusMinusIcon")
                        .padding(.vertical)
                }
                
                
                
            }
            .navigationBarTitle("Drawing Demo")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
