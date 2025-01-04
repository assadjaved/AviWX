
import SwiftNet

class AviWXAirportInfoRequest: AviWXBaseRequest<[AirportDto]> {
    
    let icaoId: String
    
    init(icaoId: String) {
        self.icaoId = icaoId
    }
    
    override var path: String {
        "airport"
    }
    
    override var parameters: [SwiftNetRequestParameter] {
        return [
            .query(key: "ids", value: icaoId),
            .query(key: "format", value: "json")
        ]
    }
}

