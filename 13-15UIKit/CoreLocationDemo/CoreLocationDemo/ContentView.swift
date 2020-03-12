//
//  ContentView.swift
//  CoreLocationDemo
//
//  Created by DR_Kun on 2020/3/12.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let locationFetcher = LocationFetcher()
    
    @State private var showingLocationInfo = false
    @State private var locationInfoString = ""
    
    var body: some View {
        
        NavigationView {
            VStack {
                Button("Start Tracking Location") {
                    self.locationFetcher.start()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .padding()
                
                Button("Read Location") {
                    if let location = self.locationFetcher.lastKnownLocation {
                        self.showingLocationInfo = true
                        self.locationInfoString = "经纬度:\(location.longitude), \(location.latitude)"
                    } else {
                        self.showingLocationInfo = false
                        self.locationInfoString = ""
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
            .navigationBarTitle("经纬度信息")
            .alert(isPresented: $showingLocationInfo) {
                Alert(title: Text("您在"), message: Text(self.locationInfoString), dismissButton: .default(Text("好的")))
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
