import Foundation





class LobResponse: Decodable {
    let rcode: Int
    let rObj: LobData
    let rmsg: [LobResponseMessage]
    let reqID: String
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool
    let outcomeMsgCode: String
    let reDirectURL: String?
    
    class LobData: Decodable {
        let getAllLOB: [LOBValues]
        
        class LOBValues: Decodable {
            let pZLOBID: String
            let pZLOB: String
            let pZLOBDesc: String
            let parentMasterDataID: String?
            let parentMDCategoryID: String?
            let mSTGroupID: String
        }
    }
}





class LobResponseMessage: Decodable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}
