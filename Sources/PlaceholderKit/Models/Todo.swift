//
//  Todo.swift
//  
//
//  Created by Mathew Gacy on 6/29/21.
//

import Foundation

public struct Todo: Codable, Identifiable, Equatable, Hashable {
    public let id: Int
    public var userId: Int
    public var title: String
    public var completed: Bool

    public init(id: Int, userId: Int, title: String, completed: Bool) {
        self.id = id
        self.userId = userId
        self.title = title
        self.completed = completed
    }
}
