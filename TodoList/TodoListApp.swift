//
//  TodoListApp.swift
//  TodoList
//
//  Created by Guofeng Luo on 2026/7/24.
//

import SwiftData
import SwiftUI

@main
struct TodoListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: TodoItem.self)
    }
}
