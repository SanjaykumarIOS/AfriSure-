
import SwiftUI
import Foundation

class ProposalInfoResponse: Decodable {
    let rcode: Int
    let rObj: ProposalInfoObject
    let rmsg: [ProposalInfoResponseMessage]
    let reqID: String
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool
    let outcomeMsgCode: String?
    let reDirectURL: String?
    
    class ProposalInfoObject: Decodable {
        let viewJson: String
//        let information: InformationDetails
        
      
        class InformationDetails: Decodable {
            let Gender: String
            let SumInsured: String
            let Occupation: String
            let IsSmoker: String
            let PaymentPeriodID: String
            let Term: String
            let DateOfBirth: String
            let ADDON_a0a3c364110849288b87fc90fef1e5a1: Bool
            let ADDON_a0a3c364110849288b87fc90fef1e5a2: Bool
            let ADDON_a0a3c364110849288b87fc90fef1e5a3: Bool
            let productIDs: [Int]
            let quotationSearchID: String
            let quotationRefID: String
            let viewJson: String
        }
    }
}


class ProposalInfoResponseMessage: Decodable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}
