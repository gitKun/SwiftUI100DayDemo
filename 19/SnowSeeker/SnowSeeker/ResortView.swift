//
//  ResortView.swift
//  SnowSeeker
//
//  Created by DR_Kun on 2020/3/17.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @State private var selectedFacility: Facility?
    
    @EnvironmentObject var favorites: Favorites
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                
                HStack {
                    if sizeClass == .compact {
                        Spacer()
                        VStack(alignment: .leading) { ResortDetailsView(resort: resort) }
                        VStack(alignment: .leading) { SkiDetailsView(resort: resort) }
                        Spacer()
                    } else {
                        ResortDetailsView(resort: resort)
                        Spacer()
                            .frame(height: 0)
                        SkiDetailsView(resort: resort)
                    }
                }
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.top)
                
                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    Text("Facilities")
                        .font(.headline)
                        //Text(ListFormatter.localizedString(byJoining: resort.facilities)).padding(.vertical)
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            facility.icon
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                                }
                        }
                    }
                    .padding(.vertical)
                }
                .padding()
            }
            Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                if self.favorites.contains(self.resort) {
                    self.favorites.remove(self.resort)
                } else {
                    self.favorites.add(self.resort)
                }
            }
            .padding()
        }
        .navigationBarTitle(Text("\(resort.name)"))
        .alert(item: $selectedFacility) { facility in
            facility.alert
        }
    }
    
}

struct ResortView_Previews: PreviewProvider {
    
    static var previews: some View {
        ResortView(resort: Resort.example).environmentObject(Favorites())
    }
}
