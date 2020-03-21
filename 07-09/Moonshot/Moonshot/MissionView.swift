//
//  MissionView.swift
//  Moonshot
//
//  Created by DR_Kun on 2020/3/4.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    
    let astronauts: [CrewMember]
    let mission: Mission
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        var matches = [CrewMember]()
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        self.astronauts = matches
    }
    
    
    func scaleForImage(localMidY: CGFloat, globalMidY: CGFloat, safeSpace: CGFloat) -> CGFloat {
        var scale: CGFloat = 1.0
        
        let fixedMidY = localMidY + safeSpace
        
        guard globalMidY < fixedMidY else {
            return scale
        }
        
        scale = globalMidY / fixedMidY
        
        guard scale > 0.8 else {
            return 0.8
        }
        
        return scale
    }
    
    
    var body: some View {
        return GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    GeometryReader { innerGeo in
                        Image(self.mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: innerGeo.size.width)
                            .padding(.top)
                            .contentShape(Rectangle())
                            .scaleEffect(self.scaleForImage(localMidY: innerGeo.frame(in: .local).midY, globalMidY: innerGeo.frame(in: .global).midY, safeSpace: geometry.safeAreaInsets.top))
                            .onTapGesture {
                                print("innerGeo.global.midY = \(innerGeo.frame(in: .global).midY)")
                                print("innerGeo.local.midY = \(innerGeo.frame(in: .local).midY)")
                                print("geometry.safeAreaInsets = \(geometry.safeAreaInsets)")
                        }
                    }
                    .frame(height: geometry.size.width * 0.7)
                    
                    Text(self.mission.formattedLaunchDate)
                        .font(.headline)
                        .padding()
                    Text(self.mission.description)
                        .padding()
                        .layoutPriority(1)

                    Text(self.mission.description)
                    .padding()
                    .layoutPriority(1)

                    Spacer(minLength: 25)

                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            CrewMemberCell(crewMember: crewMember)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions_zh.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts_zh.json")
    static var previews: some View {
        MissionView(mission: missions[1], astronauts: astronauts)
    }
}

struct CrewMemberCell: View {
    let crewMember: MissionView.CrewMember
    var body: some View {
        HStack {
            Image(crewMember.astronaut.id)
                .resizable()
                .frame(width: 83, height: 60)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
            VStack(alignment: .leading) {
                Text(crewMember.astronaut.name)
                    .font(.headline)
                Text(crewMember.role)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}
