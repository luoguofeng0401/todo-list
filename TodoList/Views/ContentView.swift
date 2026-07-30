//
//  ContentView.swift
//  Homework7
//
//  Created by Guofeng Luo on 2026/7/29.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        TodoListView(modelContext: modelContext)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: TodoItem.self, inMemory: true)
}
