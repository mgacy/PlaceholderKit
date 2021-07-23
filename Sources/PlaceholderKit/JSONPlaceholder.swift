//
//  JSONPlaceholder.swift
//  
//
//  Created by Mathew Gacy on 7/23/21.
//

import Foundation
import MGNetworking

public typealias AlbumModel = Album
public typealias PhotoModel = Photo

public typealias Pagination = JSONPlaceholder.Pagination

public enum JSONPlaceholder {

    // MARK: - Albums

    public enum Albums {
        internal static let path = "/albums"

        public static func get(pagination: Pagination? = nil) -> Endpoint<[AlbumModel]> {
            let parameters: [URLQueryItem]? = pagination?.build() ?? nil
            return Endpoint<[AlbumModel]>(path: path, parameters: parameters)
        }
    }

    // MARK: - Album

    public enum Album {
        public typealias ID = AlbumModel.ID

        public static func get(id: ID) -> Endpoint<AlbumModel> {
            Endpoint(path: path(for: id))
        }

        public static func create(id: ID) -> Endpoint<AlbumModel> {
            Endpoint(method: .post, path: path(for: id))
        }

        public static func update(id: ID) -> Endpoint<AlbumModel> {
            Endpoint(method: .put, path: path(for: id))
        }

        public static func delete(id: ID) -> Endpoint<Void> {
            Endpoint(method: .delete, path: path(for: id))
        }

        public static func getPhotos(id: ID, pagination: Pagination? = nil) -> Endpoint<[PhotoModel]> {
            let parameters: [URLQueryItem]? = pagination?.build() ?? nil
            let path = path(for: id) + "/photos"
            return Endpoint(path: path, parameters: parameters)
        }

        // MARK: - Helpers

        internal static func path(for id: ID) -> String {
            Albums.path + "/\(id)"
        }
    }

    // MARK: - Photos

    public enum Photos {

        // MARK: - Parameters

        public enum Filter: Parameter {
            case title(String)
            case url(String)
            case thumbnailUrl(String)

            public var name: String {
                switch self {
                case .title: return "title"
                case .url: return "url"
                case .thumbnailUrl: return "thumbnailUrl"
                }
            }

            public var value: String? {
                switch self {
                case .title(let value): return value
                case .url(let value): return value
                case .thumbnailUrl(let value): return value
                }
            }
        }
    }
}

// MARK: - Pagination
extension JSONPlaceholder {

    public struct Pagination {

        public enum Relation: String {
            case first
            case next
            case last
        }

        public let page: Int
        public let limit: Int
        public let relation: Relation

        public init(page: Int = 1, limit: Int = 50, relation: Relation = .first) {
            self.page = page
            self.limit = limit
            self.relation = relation
        }

        public func build() -> [URLQueryItem] {
            [
                URLQueryItem(name: "_page", value: "\(page)"),
                URLQueryItem(name: "limit", value: "\(limit)"),
                URLQueryItem(name: "rel", value: relation.rawValue)
            ]
        }

        public static func page(_ page: Int) -> Self {
            .init(page: page)
        }
    }
}
