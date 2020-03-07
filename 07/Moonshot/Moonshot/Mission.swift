//
//  Mission.swift
//  Moonshot
//
//  Created by DR_Kun on 2020/3/4.
//  Copyright © 2020 kun. All rights reserved.
//

import Foundation


struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "y年MM月dd日" // 格式为: 2020年03月04日
//            formatter.dateStyle = .long   // 格式为: March 4, 2020
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
}


