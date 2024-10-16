


import SwiftUI
import Foundation

class TaskResponse: Decodable {
    let rcode: Int
    let rObj: TaskData
    let rmsg: [TaskMessage]
    let reqID: String
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool?
    let outcomeMsgCode: String?
    let reDirectURL: String?
    let isSuccess: Bool?
    
    class TaskData: Decodable {
        let taskData: TaskDetail
        let assignedAssessor: String?
        let screenConfig: String?
        let allowedAssessors: [String]?
        let emptyViewJson: String?
        
        class TaskDetail: Decodable {
            let requirement: String?
            let requirementDesc: String?
            let typeOfAssessment: String?
            let typeOfDocuments: String?
            let uniqueRefNum: String?
            let isCompleted: Bool?
            let objectActionRequirementID: String?
            let objectRequirementID: String?
            let objectTypeRequirementCategoryID: String?
            let riskID: String?
            let sequenceNum: Int?
            let isIndependent: Bool?
            let isMandatory: Bool?
//            let completedAssessorTypeID: String?
//            let completedAssessorTypeName: String?
            let endDate: String?
            let objectID: String?
            let completedOn: String?
            let completedBy: String?
            let assignedOn: String?
            let assignedTo: String?
        }
    }
}


class TaskMessage: Decodable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}










class ScreenConfig: Decodable {
    let id: String?
    let objectRequirementID: String?
    let fieldGroup: [FieldGroup]
//    let emptyViewJson: [String]? 
    
    class FieldGroup: Decodable {
        let key: String?
        let type: String?
        let templateOptions: TemplateOptions?
        let validation: Validation?
        let wrappers: [String]?
        let apiUrl: String?
        let expressionProperties: ExpressionProperties?
        let className: String?
        var defaultValue: String?
        
        class TemplateOptions: Decodable {
            let label: String?
            let allowedFileTypes: [String]?
            let required: Bool
            let disabled: Bool?
            let IsMultiple: Bool?
            let fileslength: Int?
            let maxSize: Int?
            let blopUploadLocation: String?
            //        let datepickerOptions: [String: Any]  Assuming datepickerOptions can contain any JSON structure
            let placeholder: String?
            let minLength: Int?
            let maxLength: Int?
            let rows: Int?
            let readOnly: Bool?
            let isOnloadAPICall: Bool?
            let multiple: Bool?
        }
        
        class Validation: Decodable {
            let messages: Messages?
            
            struct Messages: Decodable {
                let required: String?
                let minLength: String?
                let maxLength: String?
            }
        }
        
        class ExpressionProperties: Decodable {
            let hide: String?
        }
    }
}
