//
//  Favorites.swift
//  SnowSeeker
//
//  Created by DR_Kun on 2020/3/22.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

class Favorites: ObservableObject {
    private var resorts: Set<String>
    
    private let saveKey = "Favorites"

    init() {
        if let data = UserDefaults.standard.data(forKey: self.saveKey) {
            // 从本地加载数据
            if let decode = try? JSONDecoder().decode(Set<String>.self, from: data) {
                self.resorts = decode
                return
            }
        }
        self.resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    private func save() {
        if let encode = try? JSONEncoder().encode(self.resorts) {
            UserDefaults.standard.set(encode, forKey: self.saveKey)
        }
    }
}


