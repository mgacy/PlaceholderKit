//
//  JSONPlaceholder.swift
//  
//
//  Created by Mathew Gacy on 7/23/21.
//

import Foundation
import MGNetworking

public typealias AlbumFilter = JSONPlaceholder.Albums.Filter
public typealias CommentFilter = JSONPlaceholder.Comments.Filter
public typealias PhotoFilter = JSONPlaceholder.Photos.Filter
public typealias PostFilter = JSONPlaceholder.Posts.Filter
public typealias TodoFilter = JSONPlaceholder.Todos.Filter
public typealias UserFilter = JSONPlaceholder.Users.Filter

public typealias AlbumModel = Album
public typealias CommentModel = Comment
public typealias PhotoModel = Photo
public typealias PostModel = Post
public typealias TodoModel = Todo
public typealias UserModel = User

public typealias Pagination = JSONPlaceholder.Pagination

public enum JSONPlaceholder {

    // MARK: - Albums

    public enum Albums {
        internal static let path = "/albums"

        public static func get(pagination: Pagination? = nil) -> Endpoint<[AlbumModel]> {
            let parameters: [URLQueryItem]? = pagination?.build() ?? nil
            return Endpoint<[AlbumModel]>(path: path, parameters: parameters)
        }

        // MARK: - Parameters

        public enum Filter: Parameter {
            case title(String)

            public var name: String {
                switch self {
                case .title: return "title"
                }
            }

            public var value: String? {
                switch self {
                case .title(let value): return value
                }
            }
        }
    }

    // MARK: - Album

    public enum Album {
        public typealias ID = AlbumModel.ID

        public static func get(id: ID) -> Endpoint<AlbumModel> {
            Endpoint(path: path(for: id))
        }

        public static func create() -> Endpoint<AlbumModel> {
            Endpoint(method: .post, path: Albums.path)
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

    // MARK: - Comments

    public enum Comments {
        internal static let path = "/comments"

        public static func get(filters: [Filter] = []) -> Endpoint<[CommentModel]> {
            Endpoint(path: path, parameters: filters)
        }

        // MARK: - Parameters

        public enum Filter: Parameter {
            case email(String)
            case name(String)

            public var name: String {
                switch self {
                case .email: return "email"
                case .name: return "name"
                }
            }

            public var value: String? {
                switch self {
                case .email(let value): return value
                case .name(let value): return value
                }
            }
        }
    }

    public enum Comment {
        public typealias ID = CommentModel.ID

        public static func get(id: ID) -> Endpoint<CommentModel> {
            Endpoint(path: path(for: id))
        }

        public static func create() -> Endpoint<CommentModel> {
            Endpoint(method: .post, path: Comments.path)
        }

        public static func update(id: ID) -> Endpoint<CommentModel> {
            Endpoint(method: .put, path: path(for: id))
        }

        public static func delete(id: ID) -> Endpoint<Void> {
            Endpoint(method: .delete, path: path(for: id))
        }

        // MARK: - Helpers

        internal static func path(for id: ID) -> String {
            Comments.path + "/\(id)"
        }
    }

    // MARK: - Photos

    public enum Photos {

        internal static let path = "/photos"

        public static func get(filter: Filter? = nil) -> Endpoint<[PhotoModel]> {
            let parameters: [Filter] = filter != nil ? [filter!] : []
            return Endpoint<[PhotoModel]>(path: path, parameters: parameters)
        }

        public func getAlbumPhotos(albumID: Album.ID, albumFilter: AlbumFilter? = nil) -> Endpoint<[PhotoModel]> {
            let parameters: [AlbumFilter] = albumFilter != nil ? [albumFilter!] : []
            let path = "/albums" + "/\(albumID)/photos"
            return Endpoint<[PhotoModel]>(path: path, parameters: parameters)
        }

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

    // MARK: - Photo

    public enum Photo {
        public typealias ID = PhotoModel.ID

        public static func get(id: ID) -> Endpoint<PhotoModel> {
            Endpoint(path: path(for: id))
        }

        public static func create() -> Endpoint<PhotoModel> {
            Endpoint(method: .post, path: Photos.path)
        }

        public static func update(id: ID) -> Endpoint<PhotoModel> {
            Endpoint(method: .put, path: path(for: id))
        }

        public static func delete(id: ID) -> Endpoint<Void> {
            Endpoint(method: .delete, path: path(for: id))
        }

        // MARK: - Helpers

        internal static func path(for id: ID) -> String {
            Photos.path + "/\(id)"
        }
    }

    // MARK: - Posts

    public enum Posts {
        internal static let path = "/posts"

        // TODO: handle parameters
        public static func get(filters: [Filter] = []) -> Endpoint<[PostModel]> {
            Endpoint<[PostModel]>(path: path, parameters: filters)
        }

        // MARK: - Parameters

        public enum Filter: Parameter {
            case body(String)
            case title(String)

            public var name: String {
                switch self {
                case .body: return "body"
                case .title: return "title"
                }
            }

            public var value: String? {
                switch self {
                case .body(let value): return value
                case .title(let value): return value
                }
            }
        }
    }

    public enum Post {
        public typealias ID = PostModel.ID

        public static func get(id: ID) -> Endpoint<PostModel> {
            Endpoint(path: path(for: id))
        }

        public static func create() -> Endpoint<PostModel> {
            Endpoint(method: .post, path: Posts.path)
        }

        public static func update(id: ID) -> Endpoint<PostModel> {
            Endpoint(method: .put, path: path(for: id))
        }

        public static func delete(id: ID) -> Endpoint<Void> {
            Endpoint(method: .delete, path: path(for: id))
        }

        // TODO: handle parameters
        public static func getComments(id: ID) -> Endpoint<[CommentModel]> {
            let path = Post.path(for: id) + "/comments"
            return Endpoint(path: path, parameters: [])
        }

        internal static func path(for id: ID) -> String {
            Posts.path + "/\(id)"
        }
    }

    // MARK: - Todos

    public enum Todos {
        internal static let path = "/todos"

        public static func get(filter: Filter? = nil) -> Endpoint<[TodoModel]> {
            let parameters: [Filter] = filter != nil ? [filter!] : []
            return Endpoint<[TodoModel]>(path: path, parameters: parameters)
        }

        // MARK: Parameters

        public enum Filter: Parameter {
            case user(id: Int) // Remove since we have User.getTodos(id:)?
            case completed(Bool)

            public var name: String {
                switch self {
                case .user: return "userId"
                case .completed: return "completed"
                }
            }

            public var value: String? {
                switch self {
                case .user(id: let id): return "\(id)"
                case .completed(let completed): return "\(completed)"
                }
            }
        }
    }

    // MARK: - Todo

    public enum Todo {
        public typealias ID = TodoModel.ID

        public static func get(id: ID) -> Endpoint<TodoModel> {
            Endpoint(path: path(for: id))
        }

        public static func create() -> Endpoint<TodoModel> {
            Endpoint(method: .post, path: Todos.path)
        }

        public static func update(id: ID) -> Endpoint<TodoModel> {
            Endpoint(method: .put, path: path(for: id))
        }

        public static func patch(id: ID) -> Endpoint<TodoModel> {
            Endpoint(method: .patch, path: path(for: id))
        }

        public static func delete(id: ID) -> Endpoint<Void> {
            return Endpoint(method: .delete, path: path(for: id))
        }

        // MARK: - Helpers

        internal static func path(for id: ID) -> String {
            Todos.path + "/\(id)"
        }
    }

    // MARK: - Users

    public enum Users {
        internal static let path = "/users"

        public static func get(filter: Filter? = nil) -> Endpoint<[UserModel]> {
            // TODO: handle parameters
            Endpoint<[UserModel]>(path: path, parameters: [])
        }

        // MARK: Parameters

        public enum Filter: Parameter {
            case name(String)
            case username(String)
            case email(String)
            //case address
            case phone(String)
            case website(String) // use URL?
            //case company(name: String)

            public var name: String {
                switch self {
                case .name: return "name"
                case .username: return "username"
                case .email: return "email"
                case .phone: return "phone"
                case .website: return "website"
                }
            }

            public var value: String? {
                switch self {
                case .name(let value): return value
                case .username(let value): return value
                case .email(let value): return value
                case .phone(let value): return value
                case .website(let value): return value
                }
            }
        }
    }

    // MARK: - User

    public enum User {
        public typealias ID = UserModel.ID

        public static func get(id: ID) -> Endpoint<UserModel> {
            Endpoint(path: path(for: id))
        }

        public static func create() -> Endpoint<UserModel> {
            Endpoint(method: .post, path: Users.path)
        }

        public static func update(id: ID) -> Endpoint<UserModel> {
            Endpoint(method: .put, path: path(for: id))
        }

        public static func patch(id: ID) -> Endpoint<UserModel> {
            Endpoint(method: .patch, path: path(for: id))
        }

        public static func delete(id: ID) -> Endpoint<Void> {
            return Endpoint(method: .delete, path: path(for: id))
        }

        // TODO: handle parameters
        public static func getAlbums(id: ID) -> Endpoint<[AlbumModel]> {
            let path = User.path(for: id) + "/albums"
            return Endpoint<[AlbumModel]>(path: path, parameters: [])
        }

        // TODO: handle parameters
        public static func getPosts(id: ID) -> Endpoint<[PostModel]> {
            let path = User.path(for: id) + "/posts"
            return Endpoint<[PostModel]>(path: path, parameters: [])
        }

        // TODO: handle parameters
        public static func getTodos(id: ID) -> Endpoint<[TodoModel]> {
            let path = User.path(for: id) + "/todos"
            return Endpoint<[TodoModel]>(path: path)
        }

        // MARK: - Helpers

        internal static func path(for id: ID) -> String {
            Users.path + "/\(id)"
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
