

import Foundation

struct SelfAssessmentSubmitResponseModel: Codable {
    let isSuccess: Bool?
    let objectDBID: String?
    let outcome: Bool?
    let outcomeMsgCode: String?
//    let rObj: [String: Any]?
    let rcode: Int
    let reDirectURL: String?
    let reqID: String?
    let rmsg: [SelfAssessmentSubmitRMessage]
    let transactionRef: String?
}

struct SelfAssessmentSubmitRMessage: Codable {
    let errorCode: String
    let errorText: String
    let fieldName: String?
    let fieldValue: String?
}
