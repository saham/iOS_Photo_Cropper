import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

public struct RoomVUClient {
    let clinet:Client
    public init(apiKey: String) {
        self.clinet = Client(serverURL: try! Servers.server1(), transport: URLSessionTransport())
    }
    public func getImages() {
        let clinet = Client(serverURL: try! Servers.server1(), transport: URLSessionTransport())
    }
}
