//
//  Album.swift
//  
//
//  Created by Mathew Gacy on 6/29/21.
//

import Foundation

public struct Album: Codable, Identifiable, Equatable, Hashable {
    public let id: Int
    public var userId: Int
    public var title: String

    public init(id: Int, userId: Int, title: String) {
        self.id = id
        self.userId = userId
        self.title = title
    }
}
