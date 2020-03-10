//
//  Candy+CoreDataProperties.swift
//  CoreDataProject_12
//
//  Created by DR_Kun on 2020/3/10.
//  Copyright © 2020 kun. All rights reserved.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?

    public var wrappedName: String {
        name ?? "Unknown Candy"
    }
    
}
