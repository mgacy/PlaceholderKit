//
//  PlaceholderClient.swift
//  
//
//  Created by Mathew Gacy on 6/29/21.
//

import Foundation

public protocol PlaceholderClientType {
//    typealias CompletionHandler<T> = (Result<T, NetworkClientError>) -> Void
//
//    func getAlbums(completionHandler: @escaping CompletionHandler<[Album]>)
//    func getAlbum(id: Int, completionHandler: @escaping CompletionHandler<Album>)
//    func getPhotos(completionHandler: @escaping CompletionHandler<[Photo]>)
//    func getPhoto(id: Int, completionHandler: @escaping CompletionHandler<Photo>)
//    func getPhotosFromAlbum(id: Int, completionHandler: @escaping CompletionHandler<[Photo]>)
//    func getTodos(completionHandler: @escaping CompletionHandler<[Todo]>)
//    func getTodo(id: Int, completionHandler: @escaping CompletionHandler<Todo>)
}

// MARK: - Implementation

public final class PlaceholderClient: PlaceholderClientType {

    private let session: URLSession

    private let baseURL = "https://jsonplaceholder.typicode.com"

    public init(session: URLSession) {
        self.session = session
    }

}
