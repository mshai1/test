//
//  ContentView.swift
//  test
//
//  Created by Mohammad Shaikh on 2/15/24.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    var name: String
    var description: String
    var date: Date
}

enum SortingCriteria {
    case name
    case date
}

struct ContentView: View {
    @State private var items = [Item]()
    @State private var showingAddItemView = false
    @State private var isSortingSheetPresented = false
    @State private var sortingCriteria: SortingCriteria?

    var sortedItems: [Item] {
        switch sortingCriteria {
        case .name?:
            return items.sorted(by: { $0.name < $1.name })
        case .date?:
            return items.sorted(by: { $0.date < $1.date })
        default:
            return items
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(sortedItems) { item in
                        Text(item.name)
                    }
                }
                .navigationTitle("Items")
                .navigationBarItems(
                    leading: Button("Sort") {
                        isSortingSheetPresented = true
                    },
                    trailing: Button(action: {
                        showingAddItemView = true
                    }) {
                        Image(systemName: "plus")
                    }
                )
            }
        }
        .sheet(isPresented: $showingAddItemView, content: {
            AddItemView(items: $items, isPresented: $showingAddItemView)
        })
        .actionSheet(isPresented: $isSortingSheetPresented, content: {
            ActionSheet(
                title: Text("Sort By"),
                buttons: [
                    .default(Text("Name")) { sortingCriteria = .name },
                    .default(Text("Date")) { sortingCriteria = .date },
                    .cancel()
                ]
            )
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
