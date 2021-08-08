//
//  PlaceholderClient.swift
//  
//
//  Created by Mathew Gacy on 6/29/21.
//

import Foundation
import MGNetworking

public protocol PlaceholderClientType {
    typealias CompletionHandler<T> = (Result<T, NetworkClientError>) -> Void

    // MARK: - Albums
    func getAlbums(pagination: Pagination?, completionHandler: @escaping CompletionHandler<[Album]>)
    func getUserAlbums(userID: User.ID, completionHandler: @escaping CompletionHandler<[Album]>)
    func getAlbum(id: Album.ID, completionHandler: @escaping CompletionHandler<Album>)
    func createAlbum(_ album: Album, completionHandler: @escaping CompletionHandler<Album>)
    func updateAlbum(_ album: Album, completionHandler: @escaping CompletionHandler<Album>)
    func deleteAlbum(id: Album.ID, completionHandler: @escaping CompletionHandler<Void>)

    // MARK: - Comments
    func getComments(filter: CommentFilter?, completionHandler: @escaping CompletionHandler<[Comment]>)
    func getPostComments(postID: Post.ID, completionHandler: @escaping CompletionHandler<[Comment]>)
    func getComment(id: Comment.ID, completionHandler: @escaping CompletionHandler<Comment>)
    func createComment(_ comment: Comment, completionHandler: @escaping CompletionHandler<Comment>)
    func updateComment(_ comment: Comment, completionHandler: @escaping CompletionHandler<Comment>)
    func deleteComment(id: Comment.ID, completionHandler: @escaping CompletionHandler<Void>)

    // MARK: - Photos
    func getPhotos(filter: PhotoFilter?, completionHandler: @escaping CompletionHandler<[Photo]>)
    func getAlbumPhotos(
        albumID: Album.ID,
        pagination: Pagination?,
        completionHandler: @escaping CompletionHandler<[Photo]>)
    func getPhoto(id: Photo.ID, completionHandler: @escaping CompletionHandler<Photo>)
    func createPhoto(_ photo: Photo, completionHandler: @escaping CompletionHandler<Photo>)
    func updatePhoto(_ photo: Photo, completionHandler: @escaping CompletionHandler<Photo>)
    func deletePhoto(id: Photo.ID, completionHandler: @escaping CompletionHandler<Void>)

    // MARK: - Posts
    func getPosts(filter: PostFilter?, completionHandler: @escaping CompletionHandler<[Post]>)
    func getUserPosts(userID: User.ID, completionHandler: @escaping CompletionHandler<[Post]>)
    func getPost(id: Post.ID, completionHandler: @escaping CompletionHandler<Post>)
    func createPost(_ post: Post, completionHandler: @escaping CompletionHandler<Post>)
    func updatePost(_ post: Post, completionHandler: @escaping CompletionHandler<Post>)
    func deletePost(id: Post.ID, completionHandler: @escaping CompletionHandler<Void>)

    // MARK: - Todos

    func getTodos(filter: TodoFilter?, completionHandler: @escaping CompletionHandler<[Todo]>)
    func getUserTodos(userID: User.ID, completionHandler: @escaping CompletionHandler<[Todo]>)
    func getTodo(id: Todo.ID, completionHandler: @escaping CompletionHandler<Todo>)
    func createTodo(_ todo: Todo, completionHandler: @escaping CompletionHandler<Todo>)
    func updateTodo(_ todo: Todo, completionHandler: @escaping CompletionHandler<Todo>)
    func deleteTodo(id: Todo.ID, completionHandler: @escaping CompletionHandler<Void>)

    // MARK: - Users

    func getUsers(filter: UserFilter?, completionHandler: @escaping CompletionHandler<[User]>)
    func getUser(id: User.ID, completionHandler: @escaping CompletionHandler<User>)
    func createUser(_ user: User, completionHandler: @escaping CompletionHandler<User>)
    func updateUser(_ user: User, completionHandler: @escaping CompletionHandler<User>)
    func deleteUser(id: User.ID, completionHandler: @escaping CompletionHandler<Void>)
}

// MARK: - Implementation

public final class PlaceholderClient: PlaceholderClientType {

    public struct Configuration {
        public let server: Server
        public let defaultHeaders: [HeaderField]

        public init(server: Server, defaultHeaders: [HeaderField]) {
            self.server = server
            self.defaultHeaders = defaultHeaders
        }

        public static var defaultConfiguration: Configuration {
            .init(server: Server(host: .placeholderHost), defaultHeaders: [.contentType(.json)])
        }
    }

    private let server: Server

    private let session: SessionProtocol

    private let defaultHeaders: [HeaderField]

    public init (server: Server, defaultHeaders: [HeaderField], session: SessionProtocol) {
        self.server = server
        self.session = session
        self.defaultHeaders = defaultHeaders
    }

    convenience init(configuration: Configuration, sessionConfiguration: URLSessionConfiguration = .default) {
        self.init(server: configuration.server,
                  defaultHeaders: configuration.defaultHeaders,
                  session: URLSession(configuration: sessionConfiguration))
    }

    // MARK: - Helpers

    private func build(endpoint: Endpoint<Void>) -> EndpointRequest<Void> {
        EndpointRequest(server: server, headers: defaultHeaders, endpoint: endpoint)
    }

    private func build<T: Decodable>(endpoint: Endpoint<T>) -> EndpointRequest<T> {
        EndpointRequest(server: server, headers: defaultHeaders, endpoint: endpoint)
    }

    private func build<T: Codable>(endpoint: Endpoint<T>, model: T) throws -> EndpointRequest<T> {
        try EndpointRequest(server: server, headers: defaultHeaders, endpoint: endpoint, model: model)
    }
}

// MARK: - Albums
extension PlaceholderClient {

    public func getAlbums(pagination: Pagination?, completionHandler: @escaping CompletionHandler<[Album]>) {
        let request = build(endpoint: JSONPlaceholder.Albums.get(pagination: pagination))
        session.perform(request, completionHandler: completionHandler).resume()
    }

    public func getUserAlbums(userID: User.ID, completionHandler: @escaping CompletionHandler<[Album]>) {
        let request = build(endpoint: JSONPlaceholder.User.getAlbums(id: userID))
        session.perform(request, completionHandler: completionHandler).resume()
    }

    public func getAlbum(id: Album.ID, completionHandler: @escaping CompletionHandler<Album>) {
        let request = build(endpoint: JSONPlaceholder.Album.get(id: id))
        session.perform(request, completionHandler: completionHandler).resume()
    }

    public func createAlbum(_ album: Album, completionHandler: @escaping CompletionHandler<Album>) {
        do {
            let request = try build(endpoint: JSONPlaceholder.Album.create(), model: album)
            session.perform(request, completionHandler: completionHandler).resume()
        } catch {
            completionHandler(.failure(.wrap(error)))
        }
    }

    public func updateAlbum(_ album: Album, completionHandler: @escaping CompletionHandler<Album>) {
        do {
            let request = try build(endpoint: JSONPlaceholder.Album.update(id: album.id), model: album)
            session.perform(request, completionHandler: completionHandler).resume()
        } catch {
            completionHandler(.failure(.wrap(error)))
        }
    }

    public func deleteAlbum(id: Album.ID, completionHandler: @escaping CompletionHandler<Void>) {
        let request = build(endpoint: JSONPlaceholder.Album.delete(id: id))
        session.perform(request, completionHandler: completionHandler).resume()
    }
}

// MARK: - Comments
extension PlaceholderClient {

    public func getComments(filter: CommentFilter?, completionHandler: @escaping CompletionHandler<[Comment]>) {
        // FIXME: handle parameters
        let request = build(endpoint: JSONPlaceholder.Comments.get(filters: []))
        session.perform(request, completionHandler: completionHandler).resume()
    }

    public func getPostComments(postID: Post.ID, completionHandler: @escaping CompletionHandler<[Comment]>) {
        let request = build(endpoint: JSONPlaceholder.Post.getComments(id: postID))
        session.perform(request, completionHandler: completionHandler).resume()
    }

    public func getComment(id: Comment.ID, completionHandler: @escaping CompletionHandler<Comment>) {
        let request = build(endpoint: JSONPlaceholder.Comment.get(id: id))
        session.perform(request, completionHandler: completionHandler).resume()
    }

    public func createComment(_ comment: Comment, completionHandler: @escaping CompletionHandler<Comment>) {
        do {
            let request = try build(endpoint: JSONPlaceholder.Comment.create(), model: comment)
            session.perform(request, completionHandler: completionHandler).resume()
        } catch {
            completionHandler(.failure(.wrap(error)))
        }
    }

    public func updateComment(_ comment: Comment, completionHandler: @escaping CompletionHandler<Comment>) {
        do {
            let request = try build(endpoint: JSONPlaceholder.Comment.update(id: comment.id), model: comment)
            session.perform(request, completionHandler: completionHandler).resume()
        } catch {
            completionHandler(.failure(.wrap(error)))
        }
    }

    public func deleteComment(id: Comment.ID, completionHandler: @escaping CompletionHandler<Void>) {
        let request = build(endpoint: JSONPlaceholder.Comment.delete(id: id))
        session.perform(request, completionHandler: completionHandler).resume()
    }
}

// MARK: - Photos
extension PlaceholderClient {

    public func getPhotos(filter: PhotoFilter?, completionHandler: @escaping CompletionHandler<[Photo]>) {
        let request = build(endpoint: JSONPlaceholder.Photos.get(filter: filter))
        session.perform(request, completionHandler: completionHandler).resume()
    }

    public func getAlbumPhotos(
        albumID: Album.ID,
        pagination: Pagination?,
        completionHandler: @escaping CompletionHandler<[Photo]>
    ) {
        let request = build(endpoint: JSONPlaceholder.Album.getPhotos(id: albumID, pagination: pagination))
        session.perform(request, completionHandler: completionHandler).resume()
    }

    public func getPhoto(id: Photo.ID, completionHandler: @escaping CompletionHandler<Photo>) {
        let request = build(endpoint: JSONPlaceholder.Photo.get(id: id))
        session.perform(request, completionHandler: completionHandler).resume()
    }

    public func createPhoto(_ photo: Photo, completionHandler: @escaping CompletionHandler<Photo>) {
        do {
            let request = try build(endpoint: JSONPlaceholder.Photo.create(), model: photo)
            session.perform(request, completionHandler: completionHandler).resume()
        } catch {
            completionHandler(.failure(.wrap(error)))
        }
    }

    public func updatePhoto(_ photo: Photo, completionHandler: @escaping CompletionHandler<Photo>) {
        do {
            let request = try build(endpoint: JSONPlaceholder.Photo.update(id: photo.id), model: photo)
            session.perform(request, completionHandler: completionHandler).resume()
        } catch {
            completionHandler(.failure(.wrap(error)))
        }
    }

    public func deletePhoto(id: Photo.ID, completionHandler: @escaping CompletionHandler<Void>) {
        let request = build(endpoint: JSONPlaceholder.Photo.delete(id: id))
        session.perform(request, completionHandler: completionHandler).resume()
    }
}

// MARK: - Posts
extension PlaceholderClient {

    public func getPosts(filter: PostFilter?, completionHandler: @escaping CompletionHandler<[Post]>) {
        // ...
    }

    public func getPosts(filter: [PostFilter]?, completionHandler: @escaping CompletionHandler<[Post]>) {
        let request = build(endpoint: JSONPlaceholder.Posts.get(filters: filter ?? []))
        session.perform(request, completionHandler: completionHandler).resume()
    }

    public func getUserPosts(userID: User.ID, completionHandler: @escaping CompletionHandler<[Post]>) {
        let request = build(endpoint: JSONPlaceholder.User.getPosts(id: userID))
        session.perform(request, completionHandler: completionHandler).resume()
    }

    public func getPost(id: Post.ID, completionHandler: @escaping CompletionHandler<Post>) {
        let request = build(endpoint: JSONPlaceholder.Post.get(id: id))
        session.perform(request, completionHandler: completionHandler).resume()
    }

    public func createPost(_ post: Post, completionHandler: @escaping CompletionHandler<Post>) {
        do {
            let request = try build(endpoint: JSONPlaceholder.Post.create(), model: post)
            session.perform(request, completionHandler: completionHandler).resume()
        } catch {
            completionHandler(.failure(.wrap(error)))
        }
    }

    public func updatePost(_ post: Post, completionHandler: @escaping CompletionHandler<Post>) {
        do {
            let request = try build(endpoint: JSONPlaceholder.Post.update(id: post.id), model: post)
            session.perform(request, completionHandler: completionHandler).resume()
        } catch {
            completionHandler(.failure(.wrap(error)))
        }
    }

    public func deletePost(id: Post.ID, completionHandler: @escaping CompletionHandler<Void>) {
        let request = build(endpoint: JSONPlaceholder.Post.delete(id: id))
        session.perform(request, completionHandler: completionHandler).resume()
    }
}

// MARK: - Todos
extension PlaceholderClient {

    public func getTodos(filter: TodoFilter?, completionHandler: @escaping CompletionHandler<[Todo]>) {
        let request = build(endpoint: JSONPlaceholder.Todos.get(filter: filter))
        session.perform(request, completionHandler: completionHandler).resume()
    }

    public func getUserTodos(userID: User.ID, completionHandler: @escaping CompletionHandler<[Todo]>) {
        let request = build(endpoint: JSONPlaceholder.User.getTodos(id: userID))
        session.perform(request, completionHandler: completionHandler).resume()
    }

    public func getTodo(id: Todo.ID, completionHandler: @escaping CompletionHandler<Todo>) {
        let request = build(endpoint: JSONPlaceholder.Todo.get(id: id))
        session.perform(request, completionHandler: completionHandler).resume()
    }

    public func createTodo(_ todo: Todo, completionHandler: @escaping CompletionHandler<Todo>) {
        do {
            let request = try build(endpoint: JSONPlaceholder.Todo.create(), model: todo)
            session.perform(request, completionHandler: completionHandler).resume()
        } catch {
            completionHandler(.failure(.wrap(error)))
        }
    }

    public func updateTodo(_ todo: Todo, completionHandler: @escaping CompletionHandler<Todo>) {
        do {
            let request = try build(endpoint: JSONPlaceholder.Todo.update(id: todo.id), model: todo)
            session.perform(request, completionHandler: completionHandler).resume()
        } catch {
            completionHandler(.failure(.wrap(error)))
        }
    }

    public func deleteTodo(id: Todo.ID, completionHandler: @escaping CompletionHandler<Void>) {
        let request = build(endpoint: JSONPlaceholder.Todo.delete(id: id))
        session.perform(request, completionHandler: completionHandler).resume()
    }
}

// MARK: - Users
extension PlaceholderClient {

    public func getUsers(filter: UserFilter?, completionHandler: @escaping CompletionHandler<[User]>) {
        let request = build(endpoint: JSONPlaceholder.Users.get(filter: filter))
        session.perform(request, completionHandler: completionHandler).resume()
    }

    public func getUser(id: User.ID, completionHandler: @escaping CompletionHandler<User>) {
        let request = build(endpoint: JSONPlaceholder.User.get(id: id))
        session.perform(request, completionHandler: completionHandler).resume()
    }

    public func createUser(_ user: User, completionHandler: @escaping CompletionHandler<User>) {
        do {
            let request = try build(endpoint: JSONPlaceholder.User.create(), model: user)
            session.perform(request, completionHandler: completionHandler).resume()
        } catch {
            completionHandler(.failure(.wrap(error)))
        }
    }

    public func updateUser(_ user: User, completionHandler: @escaping CompletionHandler<User>) {
        do {
            let request = try build(endpoint: JSONPlaceholder.User.update(id: user.id), model: user)
            session.perform(request, completionHandler: completionHandler).resume()
        } catch {
            completionHandler(.failure(.wrap(error)))
        }
    }

    public func deleteUser(id: User.ID, completionHandler: @escaping CompletionHandler<Void>) {
        let request = build(endpoint: JSONPlaceholder.User.delete(id: id))
        session.perform(request, completionHandler: completionHandler).resume()
    }
}

// MARK: - String + Ext
extension String {
    public static let placeholderHost = "jsonplaceholder.typicode.com"
}
