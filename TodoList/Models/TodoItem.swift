//
//  TodoItem.swift
//  TodoList
//
//  Created by Guofeng Luo on 2026/7/24.
//

import Foundation
import SwiftData

/// A single to-do item persisted with SwiftData.
@Model
final class TodoItem {
    var id: UUID
    var title: String
    var isCompleted: Bool
    var createdAt: Date

    init(
        id: UUID = UUID(),
        title: String,
        isCompleted: Bool = false,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.createdAt = createdAt
    }
}
