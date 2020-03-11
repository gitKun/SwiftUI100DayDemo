//
//  ContentView.swift
//  CoreDataProject_12
//
//  Created by DR_Kun on 2020/3/10.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI
import CoreData



struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Country.entity(), sortDescriptors: []) var countries: FetchedResults<Country>
    var body: some View {
        VStack {
            List {
                ForEach(countries, id: \.self) { country in
                    Section(header: Text(country.wrappedFullName)) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            Button("Add") {
                let candy1 = Candy(context: self.moc)
                candy1.name = "Mars"
                candy1.origin = Country(context: self.moc)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"
                
                let candy2 = Candy(context: self.moc)
                candy2.name = "KitKat"
                candy2.origin = Country(context: self.moc)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"
                
                let candy3 = Candy(context: self.moc)
                candy3.name = "Twix"
                candy3.origin = Country(context: self.moc)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"
                
                let candy4 = Candy(context: self.moc)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: self.moc)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Switzerland"
                
                try? self.moc.save()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/**
 * 动态 使用 NSPredicate
 */
struct CoreData: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    
    var body: some View {
        VStack {
            FilteredList(filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            Button("Add Examples") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? self.moc.save()
            }
            
            Button("Show A") {
                self.lastNameFilter = "A"
            }
            
            Button("Show S") {
                self.lastNameFilter = "S"
            }
        }
    }
}


/**
 * CoreData 中使用 NSPredicate 来过滤想要的数据
 */
struct CodeDataTest2: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: nil) var ships: FetchedResults<Ship>
    
    /*
     // 只保读取 universe 为 Star Wars 的 ship
     @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "universe == 'Star Wars'")) var ships: FetchedResults<Ship>
     
     // 如果您的数据包含 " ，那将变得很复杂，因此更常见的是使用特殊语法：“％@”表示“在此处插入一些数据”
     NSPredicate(format: "universe == %@", "Star Wars"))
     
     // 以及==，我们还可以使用比较，例如<和>过滤对象
     NSPredicate(format: "name < %@", "F")) var ships: FetchedResults<Ship>
     
     //我们可以使用IN谓词来检查Universe是否是数组中三个选项之一，如下所示
     NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])
     
     // 我们还可以使用谓词，通过诸如BEGINSWITH和的运算符来检查字符串的一部分
     NSPredicate(format: "name BEGINSWITH %@", "E"))
     // 该谓词区分大小写；如果要忽略大小写，则需要对此进行修改：
     NSPredicate(format: "name BEGINSWITH[c] %@", "e"))
     // CONTAINS[c] 工作原理类似，除了可以从子字符串开始，它可以位于属性内的任何位置
     
     // 最后，您可以使用来翻转谓词NOT，以获得其常规行为的逆函数。例如，这将查找所有不以E开头的飞船：
     NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e"))
     
     */
    
    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown name")
            }
            
            Button("Add Examples") {
                let ship1 = Ship(context: self.moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"
                
                let ship2 = Ship(context: self.moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"
                
                let ship3 = Ship(context: self.moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"
                
                let ship4 = Ship(context: self.moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"
                
                try? self.moc.save()
            }
        }
    }
    
}



/**
 * `唯一性`存储测试,
 * `CoreDataProject_12.xcdatamodeld` 中的 `Wizard` 实体,
 * 将 `name` 属性设置为了 `Constraints` (存储的`值`唯一)
 */
struct CoreDataTest1: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
    var body: some View {
        VStack {
            List(wizards, id: \Wizard.name) { wizard in
                Text(wizard.name ?? "Unknown")
            }
            
            Button("Add") {
                let wizard = Wizard(context: self.moc)
                wizard.name = "Harry Potter"
            }
            Button("Save") {
                do {
                    try self.moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
