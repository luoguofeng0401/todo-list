//
//  TodoListViewModel.swift
//  TodoList
//
//  Created by Guofeng Luo on 2026/7/24.
//

import Foundation
import SwiftData

/// Handles all CRUD logic for `TodoItem` objects and exposes the current
/// list of todos to the views. Follows the MVVM pattern by owning the
/// `ModelContext` instead of letting the views query SwiftData directly.
@Observable
final class TodoListViewModel {
    /// The todos currently shown in the UI, newest first.
    private(set) var todos: [TodoItem] = []

    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchTodos()
    }

    /// Loads all todos from the store, sorted by creation date (newest first).
    func fetchTodos() {
        let descriptor = FetchDescriptor<TodoItem>(
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        do {
            todos = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to fetch todos: \(error)")
        }
    }

    /// Creates a new todo with the given title.
    func addTodo(title: String) {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else { return }

        let newTodo = TodoItem(title: trimmedTitle)
        modelContext.insert(newTodo)
        save()
        fetchTodos()
    }

    /// Updates the title of an existing todo.
    func updateTodo(_ todo: TodoItem, title: String) {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else { return }

        todo.title = trimmedTitle
        save()
        fetchTodos()
    }

    /// Toggles the completed state of a todo.
    func toggleCompletion(_ todo: TodoItem) {
        todo.isCompleted.toggle()
        save()
        fetchTodos()
    }

    /// Deletes a todo from the store.
    func deleteTodo(_ todo: TodoItem) {
        modelContext.delete(todo)
        save()
        fetchTodos()
    }

    private func save() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
