//
//  FilteredList.swift
//  CoreDataProject_12
//
//  Created by DR_Kun on 2020/3/10.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI
import CoreData

struct FilteredList<Content, T>: View where Content: View, T: NSManagedObject {
    
    var fetchRequest: FetchRequest<T>
    let content: (T) -> Content
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self, rowContent: content)
    }
    
    public init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        let predicateStatement = "\(filterKey) \("BEGINSWITH") \'\(filterValue)\'"
        fetchRequest = FetchRequest<T>(
            entity: T.entity(),
            sortDescriptors: [],
//            predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue)
            predicate: NSPredicate(format: predicateStatement)
        )
        self.content = content
    }
}

struct FilteredList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredList(filterKey: "lastName", filterValue: "A") { _ in
            Text("xxx")
        }
    }
}
