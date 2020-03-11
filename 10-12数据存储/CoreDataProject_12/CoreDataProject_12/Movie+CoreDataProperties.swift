//
//  Movie+CoreDataProperties.swift
//  CoreDataProject_12
//
//  Created by DR_Kun on 2020/3/10.
//  Copyright © 2020 kun. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16

}
