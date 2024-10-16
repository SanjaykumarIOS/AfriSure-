import Foundation


class QuotationHistoryResponse: Decodable {
    let rcode: Int
    let rObj: QuotationHistoryrObj
    let rmsg: [QuotationHistoryResponseMessage]
    let reqID: String
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool
    let outcomeMsgCode: String
    let reDirectURL: String?
    
    class QuotationHistoryrObj: Decodable {
        let getAllQuotationDeatails: [QuotationHistoryDetail]
        let totalRecords: Int?
        
        class QuotationHistoryDetail: Decodable {
            let quotationRequestID: String?
            let pZLOB: String?
            let pZLOBID: String?
            let customerAccountID: String?
            let customerAccountNum: String?
            let customerFullName: String?
            let customerPhoneNo: String?
            let customerAccountTypeID: Int?
            let customerEmail: String?
            let customerCountryCode: String?
            let pZChannelTypeID: String?
            let pZChannelType: String?
            let productIDsJSON: String?
            let policyGroupID: String?
            let isGroupPolicy: Bool?
            let quotationCreationDate: String?
            let quotationExpirationDate: String?
            let cRTS: String?
            let quotationID: String?
        }
    }
}

class QuotationHistoryResponseMessage: Decodable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}
