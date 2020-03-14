//
//  Prospect.swift
//  HotProspects_16
//
//  Created by DR_Kun on 2020/3/13.
//  Copyright © 2020 kun. All rights reserved.
//

import Foundation

class Prospect: Identifiable, Codable {
    
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    // fileprivate(set) 限制智能在文件内进行 set 操作!
    fileprivate(set) var isContacted = false
    
    
}

class Prospects: ObservableObject {
    
    private static let saveKey = "SavedData"
    
    // 不暴露给外部 set 方法
    @Published private(set) var people: [Prospect]
    
    init() {
        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
            // 从本地加载数据
            if let decode = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decode
                return
            }
        }
        self.people = []
    }
    
    // 重要提示：您应该objectWillChange.send() 在更改属性之前先进行调用，以确保SwiftUI正确获得其动画。
    func  toggle(_ prospect: Prospect)  {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    private func save() {
        // 保存到 userDefault
        if let encode = try? JSONEncoder().encode(people) {
            UserDefaults.standard.set(encode, forKey: Self.saveKey)
        }
    }
    
    // 包装方法 不暴露内部属性
    func add(_ prospects: Prospect) {
        people.append(prospects)
        save()
    }
}


