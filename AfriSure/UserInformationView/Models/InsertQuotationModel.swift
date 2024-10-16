

import SwiftUI

//class InsertQuotationResponse: Decodable {
//    let rcode: Int
//    let rObj: InsertQuotationObject
//    let rmsg: [InsertQuotationResponseMessage]
//    let reqID: String
//    let objectDBID: String?
//    let transactionRef: String?
//    let outcome: Bool
//    let outcomeMsgCode: String?
//    let reDirectURL: String?
//    
//    class InsertQuotationObject: Decodable {
//        let quotationID: String
//        let quotationRefID: String
//        let quotationSearchID: String
//        let getAccountInformation: AccountInformation
//        
//        class AccountInformation: Decodable {
//            let accountID: String
//            let accountNum: String
//            let fullName: String
//        }
//    }
//}



class InsertQuotationResponse: Decodable {
    let rcode: Int
    let rObj: InsertQuotationObject
    let rmsg: [InsertQuotationResponseMessage]
    let reqID: String
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool
    let outcomeMsgCode: String?
    let reDirectURL: String?
    
    class InsertQuotationObject: Decodable {
        let QuotationID: String
        let QuotationRequestID: String
        
    }
}

class InsertQuotationResponseMessage: Decodable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}
