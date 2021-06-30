//
//  Photo.swift
//  
//
//  Created by Mathew Gacy on 6/29/21.
//

import Foundation

public struct Photo: Codable, Equatable, Hashable {
    public let id: Int
    public let albumId: Int
    public let title: String
    public let url: URL
    public let thumbnailUrl: URL

    public init(id: Int, albumId: Int, title: String, url: URL, thumbnailUrl: URL) {
        self.id = id
        self.albumId = albumId
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
}
