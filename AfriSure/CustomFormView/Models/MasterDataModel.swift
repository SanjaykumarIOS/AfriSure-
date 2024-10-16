import Foundation

struct MasterDataResponse: Codable {
    let rcode: Int
    let rObj: MasterDataRObj
    let rmsg: [MasterDataRmsg]
    let reqID: String?
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool?
    let outcomeMsgCode: String?
    let reDirectURL: String?
    
    struct MasterDataRObj: Codable {
        let fetchMasterData: [MasterData]
        
        
        struct MasterData: Codable {
            let masterDataID: String
            let parentMasterDataID: String?
            let mdCategoryID: Int
            let mdCategoryName: String?
            let mdTitle: String
            let mdDesc: String?
            let mdValue: String?
            let iconURL: String?
            let regExValidation: String?
            let mstGroupID: String?
            let displaySequence: Int?
            let customParam1: String?
            let isHavingChild: Bool?
        }
    }
}





struct MasterDataRmsg: Codable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}
