//
//  AddTodoView.swift
//  Homework7
//
//  Created by Guofeng Luo on 2026/7/30.
//

import SwiftUI

/// A modal form for entering a new todo's title.
struct AddTodoView: View {
    let onAdd: (String) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var title = ""

    private var isTitleValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("New todo", text: $title)
                    .onSubmit(add)
            }
            .navigationTitle("New Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add", action: add)
                        .disabled(!isTitleValid)
                }
            }
        }
    }

    private func add() {
        guard isTitleValid else { return }
        onAdd(title)
        dismiss()
    }
}
