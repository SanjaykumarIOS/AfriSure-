



import SwiftUI


class RiskAdjustmentResponse: Decodable {
    let rcode: Int
    let rObj: RiskAdjustmentObject
    let rmsg: [RiskAdjustmentResponseMessage]
    let reqID: String
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool
    let outcomeMsgCode: String
    let reDirectURL: String?
    
    class RiskAdjustmentObject: Decodable {
        let fetchAllPolicyRiskAdjustment: [RiskAdjustmentvalue]
        
        class RiskAdjustmentvalue: Decodable {
            let policyID: String
            let riskAdjustmentID: String
            let assessmentID: String?
            let adjustmentTypeID: Int
            let adjustmentAmount: Int
            let sAdjustmentAmount: String
            let underwriterComments: String
            let riskAdjustmentLimitID: String?
            let riskCategoryID: String?
            let riskCategoryTitle: String
            let assessmentTitle: String?
        }
    }
}

class RiskAdjustmentResponseMessage: Decodable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}
