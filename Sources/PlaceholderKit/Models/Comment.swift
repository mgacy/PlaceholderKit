//
//  Comment.swift
//  
//
//  Created by Mathew Gacy on 6/29/21.
//

import Foundation

public struct Comment: Codable, Identifiable, Equatable, Hashable {
    public let id: Int
    public var postId: Int
    public var name: String
    public var email: String
    public var body: String

    public init(id: Int, postId: Int, name: String, email: String, body: String) {
        self.id = id
        self.postId = postId
        self.name = name
        self.email = email
        self.body = body
    }
}
