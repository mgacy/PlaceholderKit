import XCTest
@testable import PlaceholderKit
import MGNetworking

final class PlaceholderKitTests: XCTestCase {

    var server: Server!

    // MARK: - Configuration

    override func setUpWithError() throws {
        server = Server(host: .placeholderHost)
    }

    override func tearDownWithError() throws {
        server = nil
    }

    func testAlbumsEndpointAsURLRequest() throws {
        let headers: [HeaderField]? = [.contentType(.json)]
        let endpoint = JSONPlaceholder.Albums.get(pagination: .page(1))
        let endpointRequest = EndpointRequest(server: server, headers: headers, endpoint: endpoint)

        let request = try endpointRequest.asURLRequest()

        let expectedMethod = "GET"
        let expectedURLString = "https://jsonplaceholder.typicode.com/albums?_page=1&limit=50&rel=first"
        let expectedHeaders = ["Content-Type": "application/json"]

        XCTAssertEqual(request.httpMethod, expectedMethod)
        XCTAssertEqual(request.url, URL(string: expectedURLString))
        XCTAssertEqual(request.allHTTPHeaderFields, expectedHeaders)
    }

    func testAlbumPhotosEndpointAsURLRequest() throws {
        let headers: [HeaderField]? = [.contentType(.json)]
        let albumID: Album.ID = 1
        let endpoint = JSONPlaceholder.Album.getPhotos(id: albumID)

        let endpointRequest = EndpointRequest(server: server, headers: headers, endpoint: endpoint)

        let request = try endpointRequest.asURLRequest()

        let expectedMethod = "GET"
        let expectedURLString = "https://jsonplaceholder.typicode.com/albums/1/photos"
        let expectedHeaders = ["Content-Type": "application/json"]

        XCTAssertEqual(request.httpMethod, expectedMethod)
        XCTAssertEqual(request.url, URL(string: expectedURLString))
        XCTAssertEqual(request.allHTTPHeaderFields, expectedHeaders)
    }
}

// MARK: - Support
extension PlaceholderKitTests {

    static func makeSession() -> URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]

        return URLSession(configuration: config)
    }
}
