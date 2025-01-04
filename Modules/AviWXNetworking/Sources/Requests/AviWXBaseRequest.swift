
import SwiftNet

class AviWXBaseRequest<Response: Decodable>: SwiftNetRequest {
    
    var baseUrl: String {
        "https://aviationweather.gov/api/data"
    }
    
    var path: String {
        fatalError("path must be implemented by subclass")
    }
    
    var method: SwiftNetRequestMethod {
        .get
    }
    
    var headers: [SwiftNetRequestHeader] {
        [
            .contentType(value: .json),
            .accept(value: .json)
        ]
    }
    
    var additionalHeaders: [SwiftNetRequestHeader] { [] }
    
    var parameters: [SwiftNetRequestParameter] {
        fatalError("parameters must be implemented by subclass")
    }
    
    func decode(data: Data) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
}
