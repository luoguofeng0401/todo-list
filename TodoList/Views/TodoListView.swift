//
//  TodoListView.swift
//  Homework7
//
//  Created by Guofeng Luo on 2026/7/30.
//

import SwiftData
import SwiftUI

/// The main screen: a list of todos with a toolbar button for adding new ones.
struct TodoListView: View {
    @State private var viewModel: TodoListViewModel
    @State private var isAddingTodo = false
    @State private var todoToEdit: TodoItem?

    init(modelContext: ModelContext) {
        _viewModel = State(initialValue: TodoListViewModel(modelContext: modelContext))
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.todos) { todo in
                    TodoRowView(todo: todo) {
                        viewModel.toggleCompletion(for: todo)
                    } onEdit: {
                        todoToEdit = todo
                    }
                }
                .onDelete(perform: viewModel.deleteTodos(at:))
            }
            .navigationTitle("Todos")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isAddingTodo = true
                    } label: {
                        Label("Add Todo", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingTodo) {
                AddTodoView { title in
                    viewModel.addTodo(title: title)
                }
            }
            .sheet(item: $todoToEdit) { todo in
                EditTodoView(initialTitle: todo.title) { newTitle in
                    viewModel.updateTodo(todo, title: newTitle)
                }
            }
        }
    }
}
