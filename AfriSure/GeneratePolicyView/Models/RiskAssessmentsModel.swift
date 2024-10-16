import SwiftUI




class RiskAssessmentsResponse: Decodable {
    let rcode: Int
    let rObj: RiskAssessmentsObject
    let rmsg: [RiskAssessmentsResponseMessage]
    let reqID: String
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool
    let outcomeMsgCode: String
    let reDirectURL: String?
    
    class RiskAssessmentsObject: Decodable {
        let objectRequirement: [RiskAssessmentsObjectRequirement]
        let uniqueCode: String?
        
        class RiskAssessmentsObjectRequirement: Decodable {
            let requirement: String
            let requirementDesc: String
            let typeOfAssessment: String?
            let typeOfDocuments: String?
            let uniqueRefNum: String
            let isCompleted: Bool
            let objectActionRequirementID: String
            let objectRequirementID: String?
            let objectTypeRequirementCategoryID: String
            let riskID: String
            let sequenceNum: Int
            let isIndependent: Bool
            let isMandatory: Bool?
            let completedAssessorTypeID: Int?
            let completedAssessorTypeName: String?
            let endDate: String?
        }
    }
}

class RiskAssessmentsResponseMessage: Decodable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}
