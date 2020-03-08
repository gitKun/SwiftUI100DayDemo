//
//  ContentView.swift
//  iExpense
//
//  Created by DR_Kun on 2020/3/3.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var expense = Expense()
    @State private var showingAddExpense = false
    
    private func removeItems(at offsets: IndexSet) {
        expense.items.remove(atOffsets: offsets)
    }
    
    var body: some View {
        return NavigationView {
            List {
                ForEach(expense.items) { item in
                    HStack {
                        VStack {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        
                        Text("\(item.amount)")
                            .foregroundColor(item.amount > 30 ? .red : .black)
                            .font(.subheadline)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing:
                HStack {
                    Button(action: {
                        self.showingAddExpense.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                    
                    EditButton()
                }
            )
                .sheet(isPresented: $showingAddExpense) {
                    AddView(expenses: self.expense)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expense: ObservableObject {
    @Published var items: [ExpenseItem] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}


