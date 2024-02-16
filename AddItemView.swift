//
//  AddItemView.swift
//  test
//
//  Created by Mohammad Shaikh on 2/15/24.
//

import SwiftUI

struct AddItemView: View {
    @Binding var items: [Item]
    @Binding var isPresented: Bool
    @State private var name = ""
    @State private var description = ""
    @State private var date = Date()

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
                DatePicker("Date", selection: $date, displayedComponents: .date)
                Button("Save") {
                    let newItem = Item(name: name, description: description, date: date)
                    items.append(newItem)
                    isPresented = false
                }
            }
            .navigationTitle("Add Item")
            .navigationBarItems(trailing: Button("Cancel") {
                isPresented = false
            })
        }
    }
}

