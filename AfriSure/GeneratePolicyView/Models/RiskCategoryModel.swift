

import SwiftUI


class RiskAdjustmentLimitResponse: Decodable {
    let rcode: Int
    let rObj: ResponseObjectRiskAdjustmentLimit
    let rmsg: [RiskAdjustmentLimitResponseMessage]
    let reqID: String
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool
    let outcomeMsgCode: String
    let reDirectURL: String?
    
    class ResponseObjectRiskAdjustmentLimit: Decodable {
        let fetchProductRiskAdjustmentLimit: [RiskAdjustmentLimit]
        
        class RiskAdjustmentLimit: Decodable {
            let riskAdjustmentLimitId: Int
            let productID: Int
            let riskCategoryID: String
            let riskCategoryTitle: String
            let riskCategoryCustomText: String
            let isDiscountAllowed: Bool
            let maxDiscountAllowed: Int
            let maxDiscountPercent: Int
            let isRiskLoading: Bool
            let maxLoadingAllowed: Int
            let maxLoadingPercent: Int
        }
    }
}





class RiskAdjustmentLimitResponseMessage: Decodable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}


