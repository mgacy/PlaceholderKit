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
    func getAlbum(id: Album.ID, completionHandler: @escaping CompletionHandler<Album>)
    func createAlbum(_ album: Album, completionHandler: @escaping CompletionHandler<Album>)
    func updateAlbum(_ album: Album, completionHandler: @escaping CompletionHandler<Album>)
    func deleteAlbum(id: Album.ID, completionHandler: @escaping CompletionHandler<Void>)

    func getAlbumPhotos(
        albumID: Album.ID,
        pagination: Pagination?,
        completionHandler: @escaping CompletionHandler<[Photo]>)

//    func getPhotos(completionHandler: @escaping CompletionHandler<[Photo]>)
//    func getPhoto(id: Int, completionHandler: @escaping CompletionHandler<Photo>)
//    func getPhotosFromAlbum(id: Int, completionHandler: @escaping CompletionHandler<[Photo]>)

//    func getTodos(completionHandler: @escaping CompletionHandler<[Todo]>)
//    func getTodo(id: Int, completionHandler: @escaping CompletionHandler<Todo>)
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

    public func getAlbum(id: Album.ID, completionHandler: @escaping CompletionHandler<Album>) {
        let request = build(endpoint: JSONPlaceholder.Album.get(id: id))
        session.perform(request, completionHandler: completionHandler).resume()
    }

    public func createAlbum(_ album: Album, completionHandler: @escaping CompletionHandler<Album>) {
        do {
            let request = try build(endpoint: JSONPlaceholder.Album.create(id: album.id), model: album)
            session.perform(request, completionHandler: completionHandler).resume()
        } catch {
            completionHandler(.failure(.wrap(error)))
        }
    }

    public func updateAlbum(_ album: Album, completionHandler: @escaping CompletionHandler<Album>) {
        let request = build(endpoint: JSONPlaceholder.Album.update(id: album.id))
        session.perform(request, completionHandler: completionHandler).resume()
    }

    public func deleteAlbum(id: Album.ID, completionHandler: @escaping CompletionHandler<Void>) {
        let request = build(endpoint: JSONPlaceholder.Album.delete(id: id))
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
}

extension String {
    public static let placeholderHost = "jsonplaceholder.typicode.com"
}
