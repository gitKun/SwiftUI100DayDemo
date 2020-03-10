//
//  Singer+CoreDataProperties.swift
//  CoreDataProject_12
//
//  Created by DR_Kun on 2020/3/10.
//  Copyright © 2020 kun. All rights reserved.
//
//

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?

    // 便于 SwiftUI 中使用
    
    var wrappedFirstName: String {
        firstName ?? "Unknown"
    }

    var wrappedLastName: String {
        lastName ?? "Unknown"
    }
    
    
}
