//
//  TestData.swift
//  
//
//  Created by Mathew Gacy on 7/23/21.
//

import Foundation
import MGNetworking

public struct TestData {

    public static var address = Address(
        street: "Victor Plains",
        suite: "Suite 879",
        city: "Wisokyburgh",
        zipcode: "90566-7771",
        geo: Address.Geo(lat: "-43.9509", lng: "-34.4618")
    )

    public static var album = Album(id: 1, userId: 1, title: "quidem molestiae enim")

    public static var comment = Comment(
        id: 1,
        postId: 1,
        name: "id labore ex et quam laborum",
        email: "Eliseo@gardner.biz",
        body: "laudantium enim quasi est quidem magnam voluptate ipsam eos"
    )

    public static var company = Company(
        name: "Deckow-Crist",
        catchPhrase: "Proactive didactic contingency",
        bs: "synergize scalable supply-chains"
    )

    public static var photo = Photo(
        id: 1,
        albumId: 1,
        title: "accusamus beatae ad facilis cum similique qui sunt",
        url: "https://via.placeholder.com/600/92c952",
        thumbnailUrl: "https://via.placeholder.com/150/92c952"
    )

    public static var post = Post(
        id: 1,
        userId: 1,
        title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
        body: """
        quia et suscipit
        suscipit recusandae consequuntur expedita et cum
        reprehenderit molestiae ut ut quas totam
        nostrum rerum est autem sunt rem eveniet architecto
        """
    )

    public static var todo = Todo(
        id: 1,
        userId: 1,
        title: "delectus aut autem",
        completed: false
    )

    public static var user = User(
        id: 1,
        name: "Leanne Graham",
        username: "Bret",
        email: "Sincere@april.biz",
        address: TestData.address,
        phone: "1-770-736-8031 x56442",
        website: "hildegard.org",
        company: TestData.company
    )

    // MARK: - Collections

    public static func makeAlbums(count: Int, userId: User.ID? = 1) -> [Album] {
        (1...count).map { idx in
            Album(id: idx, userId: userId ?? Int.random(in: 1..<100), title: "Album \(idx)")
        }
    }

    public static func makeComments(count: Int, postId: Post.ID? = 1) -> [Comment] {
        (1...count).map { idx in
            Comment(id: idx, postId: postId ?? Int.random(in: 1..<100), name: "Comment \(idx)", email: comment.email, body: comment.body)
        }
    }

    public static func makePosts(count: Int, userId: User.ID = 1) -> [Post] {
        (1...count).map { idx in
            Post(id: idx, userId: userId, title: "Post \(idx)", body: "Body for post \(idx)")
        }
    }

    public static func makeTodos(count: Int, userId: User.ID = 1) -> [Todo] {
        (1...count).map { idx in
            let completed: Bool = idx % 3 == 0 ? true : false
            return Todo(id: idx, userId: userId, title: "Todo \(idx)", completed: completed)
        }
    }

    public static func makeUsers(count: Int) -> [User] {
        (1...count).map { idx in
            makeUser(id: idx)
        }
    }

    public static func makeUser(id: User.ID) -> User {
        User(
            id: id,
            name: "User \(id)",
            username: "user\(id)",
            email: user.email,
            address: user.address,
            phone: user.phone,
            website: user.website,
            company: user.company
        )
    }

    // MARK: - Images

    internal static let imageServer: Server = Server(host: "via.placeholder.com")

    public typealias ColorHex = String
    public typealias ColorProvider = (Int) -> ColorHex

    public static func makePhotos(
        count: Int,
        albumId: Album.ID = 1,
        imageSize: Int = 600,
        thumbnailSize: Int = 150,
        colorProvider: ColorProvider = { id in "92c952" }
    ) -> [Photo] {
        (1...count).map { idx in
            makePhoto(
                id: idx, albumId: albumId, color: colorProvider(idx), thumbnailSize: thumbnailSize, imageSize: imageSize
            )
        }
    }

    public static func makePhoto(
        id: Photo.ID = 1,
        albumId: Album.ID = 1,
        color: ColorHex = "92c952",
        thumbnailSize: Int = 150,
        imageSize: Int = 600
    ) -> Photo {
        Photo(
            id: id, albumId: albumId, title: "Photo number \(id)",
            url: makeImageURL(color: color, size: imageSize),
            thumbnailUrl: makeImageURL(color: color, size: thumbnailSize))
    }

    public static func makeImageURL(color: ColorHex = "92c952", size: Int = 600) -> URL {
        let urlString = imageServer.baseURLString + "/\(size)/\(color)"
        return URL(string: urlString)!
    }
}
