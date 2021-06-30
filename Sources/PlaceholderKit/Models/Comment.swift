//
//  Comment.swift
//  
//
//  Created by Mathew Gacy on 6/29/21.
//

import Foundation

public struct Comment: Codable, Equatable, Hashable {
    public let id: Int
    public let postId: Int
    public let name: String
    public let email: String
    public let body: String

    public init(id: Int, postId: Int, name: String, email: String, body: String) {
        self.id = id
        self.postId = postId
        self.name = name
        self.email = email
        self.body = body
    }
}
