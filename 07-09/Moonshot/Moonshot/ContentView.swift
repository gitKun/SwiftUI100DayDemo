//
//  ContentView.swift
//  Moonshot
//
//  Created by DR_Kun on 2020/3/4.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts_zh.json")
    let missions: [Mission] = Bundle.main.decode("missions_zh.json")
    
    @State private var showingTime = true
    
    private func subTitle(for mission: Mission) -> String {
        
        guard showingTime else {
            var crewDes = ""
            mission.crew.forEach { crewRole in
                crewDes += "\(crewRole.name) "
            }
            return crewDes.trimmingCharacters(in: .whitespaces)
        }
        return mission.formattedLaunchDate
    }
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(self.subTitle(for: mission))
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button(showingTime ? "人员" : "时间") {
                self.showingTime.toggle()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
