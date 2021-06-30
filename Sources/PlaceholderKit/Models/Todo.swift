//
//  Todo.swift
//  
//
//  Created by Mathew Gacy on 6/29/21.
//

import Foundation

public struct Todo: Codable, Equatable, Hashable {
    public let id: Int
    public let userId: Int
    public let title: String
    public let completed: Bool

    public init(id: Int, userId: Int, title: String, completed: Bool) {
        self.id = id
        self.userId = userId
        self.title = title
        self.completed = completed
    }
}
