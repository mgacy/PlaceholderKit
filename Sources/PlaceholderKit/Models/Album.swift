//
//  Album.swift
//  
//
//  Created by Mathew Gacy on 6/29/21.
//

import Foundation

public struct Album: Codable, Equatable, Hashable {
    public let id: Int
    public let userId: Int
    public let title: String

    public init(id: Int, userId: Int, title: String) {
        self.id = id
        self.userId = userId
        self.title = title
    }
}

//extension Album: Hashable {
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//}

// MARK: - Temp
extension Album {
    public static var temp: Album {
        return Album(id: 1, userId: 1, title: "Testing")
    }
}
