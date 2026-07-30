//
//  TodoListViewModel.swift
//  Homework7
//
//  Created by Guofeng Luo on 2026/7/30.
//

import Foundation
import Observation
import SwiftData

/// Owns the SwiftData `ModelContext` and exposes all todo operations to the views.
///
/// Following an MVVM separation, the views never touch SwiftData directly: they
/// read the published `todos` array and call the mutating methods below. The
/// view model re-fetches after each change so `todos` always reflects the store.
@Observable
@MainActor
final class TodoListViewModel {
    /// The current todos, sorted by creation date (oldest first).
    private(set) var todos: [TodoItem] = []

    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchTodos()
    }

    /// Loads all todos from the store, sorted by `createdAt` ascending.
    func fetchTodos() {
        let descriptor = FetchDescriptor<TodoItem>(
            sortBy: [SortDescriptor(\.createdAt, order: .forward)]
        )
        do {
            todos = try modelContext.fetch(descriptor)
        } catch {
            todos = []
        }
    }

    /// Inserts a new todo with the given title, ignoring blank input.
    func addTodo(title: String) {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else { return }

        modelContext.insert(TodoItem(title: trimmedTitle))
        save()
        fetchTodos()
    }

    /// Replaces the given todo's title with a new value, ignoring blank input.
    func updateTodo(_ todo: TodoItem, title: String) {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else { return }

        todo.title = trimmedTitle
        save()
        fetchTodos()
    }

    /// Flips the completion state of the given todo.
    func toggleCompletion(for todo: TodoItem) {
        todo.isCompleted.toggle()
        save()
        fetchTodos()
    }

    /// Deletes the todos at the given offsets in the `todos` array.
    func deleteTodos(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(todos[index])
        }
        save()
        fetchTodos()
    }

    private func save() {
        do {
            try modelContext.save()
        } catch {
            // A save failure leaves the in-memory objects intact; the next
            // fetch will simply reflect the last successfully persisted state.
        }
    }
}
