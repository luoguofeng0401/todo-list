//
//  TodoItem.swift
//  Homework7
//
//  Created by Guofeng Luo on 2026/7/30.
//

import Foundation
import SwiftData

/// A single todo entry persisted by SwiftData.
@Model
final class TodoItem {
    /// A stable, unique identifier for the todo.
    var id: UUID
    /// The user-facing description of the task.
    var title: String
    /// Whether the task has been completed.
    var isCompleted: Bool
    /// The moment the todo was created, used for sorting.
    var createdAt: Date

    init(title: String, isCompleted: Bool = false, createdAt: Date = .now) {
        self.id = UUID()
        self.title = title
        self.isCompleted = isCompleted
        self.createdAt = createdAt
    }
}
