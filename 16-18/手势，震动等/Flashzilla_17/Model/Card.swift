//
//  Card.swift
//  Flashzilla_17
//
//  Created by DR_Kun on 2020/3/14.
//  Copyright © 2020 kun. All rights reserved.
//

import Foundation

struct Card: Codable {
    let prompt: String
    let answer: String
    
    static var example: Card {
        Card(prompt: "Who played the 13th Deoctor who?", answer: "Jodie Whittaker")
    }
}
