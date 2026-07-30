//
//  EditTodoView.swift
//  Homework7
//
//  Created by Guofeng Luo on 2026/7/30.
//

import SwiftUI

/// A modal form for editing an existing todo's title.
struct EditTodoView: View {
    let onSave: (String) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var title: String

    init(initialTitle: String, onSave: @escaping (String) -> Void) {
        self.onSave = onSave
        _title = State(initialValue: initialTitle)
    }

    private var isTitleValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Todo", text: $title)
                    .onSubmit(save)
            }
            .navigationTitle("Edit Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: save)
                        .disabled(!isTitleValid)
                }
            }
        }
    }

    private func save() {
        guard isTitleValid else { return }
        onSave(title)
        dismiss()
    }
}
