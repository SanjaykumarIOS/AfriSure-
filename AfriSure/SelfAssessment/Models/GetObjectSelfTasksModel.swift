
import SwiftUI
import Foundation



class GetObjectSelfTasksResponse: Decodable {
    let rcode: Int
    let rObj: GetObjectSelfTasksRObj?
    let rmsg: [GetObjectSelfTasksRmsg]
    let reqID: String?
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool?
    let outcomeMsgCode: String?
    let reDirectURL: String?
    
    class GetObjectSelfTasksRObj: Decodable {
        let getObjectSelfTasks: [ObjectData]
       
        class ObjectData: Decodable {
            let requirement: String?
            let requirementDesc: String?
            let typeOfAssessment: String?
            let typeOfDocuments: String?
            let uniqueRefNum: String?
            let isCompleted: Bool?
            let objectActionRequirementID: String?
            let objectTypeRequirementCategoryID: String?
            let riskID: String?
            let sequenceNum: Int?
            let isIndependent: Bool?
            let isMandatory: Bool?
            let completedAssessorTypeID: String?
            let completedAssessorTypeName: String?
            let endDate: String?
            let objectID: String?
            let completedOn: String?
            let completedBy: String?
            let assignedOn: String?
            let assignedTo: String?
        }
    }
}



class GetObjectSelfTasksRmsg: Decodable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}
