
import SwiftNet

class AviWXMetarRequest: AviWXBaseRequest<[MetarDto]> {
    
    let icaoId: String
    
    init(icaoId: String) {
        self.icaoId = icaoId
    }
    
    override var path: String {
        "metar"
    }
    
    override var parameters: [SwiftNetRequestParameter] {
        return [
            .query(key: "ids", value: icaoId),
            .query(key: "format", value: "json"),
            .query(key: "taf", value: "false")
        ]
    }
}
