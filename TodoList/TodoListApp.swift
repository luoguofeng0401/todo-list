//
//  TodoListApp.swift
//  TodoList
//
//  Created by Guofeng Luo on 2026/7/24.
//

import SwiftUI
import SwiftData

@main
struct TodoListApp: App {
    let container = try! ModelContainer(for: TodoItem.self)

    var body: some Scene {
        WindowGroup {
            TodoListView(modelContext: container.mainContext)
        }
        .modelContainer(container)
    }
}
