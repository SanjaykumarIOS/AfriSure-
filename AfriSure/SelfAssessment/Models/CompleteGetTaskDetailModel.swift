import Foundation


class GetTaskDetailResponseData: Codable {
    let rcode: Int
    let rObj: GetTaskDetailRObj
    let rmsg: [GetTaskDetailRmsg]
    let reqID: String
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool?
    let outcomeMsgCode: String?
    let reDirectURL: String?
    let isSuccess: Bool?
    
    class GetTaskDetailRObj: Codable {
        let emptyViewJson: String
        let screenConfig: String
        let taskDetails: TaskDetails
        //        let taskData: TaskData
        
        class TaskDetails: Codable {
            let id: String?
            let objectActionRequirementID: String?
            let viewJson: String?
            let information: Information?
            
            class Information: Codable {
                let logbook: Logbook?
                let comments: String?
                
                class Logbook: Codable {
                    let attachmentID: [Attachment]?
                    
                    class Attachment: Codable {
                        let attachmentID: String?
                        let fileName: String?
                        let blopUploadLocation: String?
                        let uploadedURL: String?
                    }
                }
            }
        }
    }
}





class TaskData: Codable {
    let requirement: String
    let requirementDesc: String
    let typeOfAssessment: String?
    let typeOfDocuments: String?
    let uniqueRefNum: String
    let isCompleted: Bool
    let objectActionRequirementID: String
    let objectRequirementID: String
    let objectTypeRequirementCategoryID: String?
    let riskID: String
    let sequenceNum: String?
    let isIndependent: Bool?
    let isMandatory: Bool?
    let completedAssessorTypeID: Int
    let completedAssessorTypeName: String
    let endDate: String
    let objectID: String
    let completedOn: String?
    let completedBy: String?
    let assignedOn: String?
    let assignedTo: String?
}



class GetTaskDetailRmsg: Codable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}



//class GetTaskDetailJSONModel: Codable {
//    let filed: [GetTaskDetailField]
//    
//    class GetTaskDetailField: Codable {
//        let key: String?
//        let defaultValue: String?
//        let type: String?
//        let templateOptions: GetTaskDetailTemplateOptions?
//        let wrappers: [String]?
//        let className: String?
//        
//        class GetTaskDetailTemplateOptions: Codable {
//            let label: String?
//            let disabled: Bool?
//            let files: [Attachment]?
//            
//            class Attachment: Codable {
//                let attachmentID: String?
//                let fileName: String?
//                let blopUploadLocation: String?
//                let uploadedURL: String?
//            }
//        }
//    }
//}



import Foundation

class GetTaskDetailJSONModel: Decodable {
    let filed: [GetTaskDetailField]
    
    class GetTaskDetailField: Decodable {
        let key: String?
        let defaultValue: DefaultValue?
        let type: String?
        let templateOptions: GetTaskDetailTemplateOptions?
        let wrappers: [String]?
        let className: String?
        
        class GetTaskDetailTemplateOptions: Decodable {
            let label: String?
            let disabled: Bool?
            let files: [File]?
            
            class File: Decodable {
                let fileName: String?
                let href: String?
            }
        }
    }
}

class Attachment: Decodable {
    let attachmentID: String?
    let fileName: String?
    let blopUploadLocation: String?
    let uploadedURL: String?
}


enum DefaultValue: Decodable {
    case string(String)
    case dictionary([String: String])
//    case attachments([Attachment])
    case other
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            let dictionaryValue = try container.decode([String: String].self)
            self = .dictionary(dictionaryValue)
            return
        } catch {
            // If decoding as a dictionary fails, attempt to decode as an array of attachments
        }
        
//        do {
//            let attachments = try container.decode([Attachment].self)
//            self = .attachments(attachments)
//            return
//        } catch {
//            // If decoding as attachments fails, attempt to decode as a string
//        }
        
        do {
            let stringValue = try container.decode(String.self)
            self = .string(stringValue)
        } catch {
            // If decoding as a string fails, set to .other
            self = .other
        }
    }
}
