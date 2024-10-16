


import Foundation
import SwiftUI

class ProposalFormDataResponse: Decodable {
    let rcode: Int
    let rObj: ProposalFormDataValues
    let rmsg: [ProposalFormDataResponseMessage]
    let reqID: String
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool
    let outcomeMsgCode: String?
    let reDirectURL: String?
    
    class ProposalFormDataValues: Decodable {
        let formDataJson: String
        let fetchFormData: FetchFormData
        
        class FetchFormData: Decodable {
            let formsMappingID: String?
            let orgFormID: String?
            let formName: String?
            let formRefID: String?
            let versionNumber: Int?
            let versionCode: String?
            let isCurrentVersion: Bool?
            let upts: String?
            let upUser: String?
            let upUserName: String?
            let formTypeID: String?
            let formTypeText: String?
            let lobData: [LOBData]?
            let formData:[FormDataField]
            
            class LOBData: Decodable {
                let lobID: String?
                let lobName: String?
            }
            
            class FormDataField: Decodable {
                let fieldGroupClassName: String?
                let fieldGroup: [FieldGroup]
                
                class FieldGroup: Decodable {
                    let key: String?
                    let type: String?
                    let templateOptions: TemplateOptions?
                    let validation: Validation?
                    let fieldGroup: [FieldGroup]?
                    let expressionProperties: ExpressionProperties?
                    let className: String?
                    let wrappers: [String]?
                    var defaultValue: String?
                    let orderData: Int?
                    let readOnly: Bool?
                    let pattern: String?
                    let minLength: String?
                    let maxLength: String?
                    
                    class ExpressionProperties: Decodable {
                        let hide: String?
                    }
                    
                   
                    struct TemplateOptions: Decodable {
                        let label: String
                        let required: Bool
                        let options: [Option]?
                        let type: String?
                        let placeholder: String?
                        let minLength: AnyValue?
                        let maxLength: AnyValue?
                        let isDependency: Bool?
                        let dateParentControl: String?
                        let dateTypeMinDepent: String?
                        let countMinDepent: Int?
                        let dateTypeMaxDepent: String?
                        let countMaxDepent: Int?
                        let dateMinType: String?
                        let countMin: Int?
                        let dateMaxType: String?
                        let countMax: Int?
                        let multiple:Bool?
                        let isMultiple: Bool?
                        let fileslength: String?
                        let allowedFileTypes: [String]?
                        let maxSize: Int?
                        let blobUploadLocation: String?
                        let isOnloadAPICall: Bool?
                        let inputParameter: String?
                        let cascadingParentControl: String?
                        let rObjData: String?
                        let apiUrl: String?
                        let baseApiUrlType: String?
                        let categoryID: Int?
                        let valueProp: String?
                        let labelProp: String?
                        
                        
                       
                        class Option: Decodable {
                            let label: String
                            let value: String
                        }
                        
                      
                    }
                    
                    class Validation: Decodable {
                        let messages: Messages
                        
                        class Messages: Decodable {
                            let required: String?
                            let minLength: String?
                            let maxLength: String?
                            let pattern: String?
                        }
                    }
                }
            }
        }
    }
    
}


class ProposalFormDataResponseMessage: Decodable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}





struct FieldGroups: Codable {
    let fieldGroupClassName: String?
    let fieldGroup: [FormField]
}

struct FormFields: Codable {
    let type: String?
    let templateOptions: TemplateOption?
    let validation: Validation?
    let key: String?
    let className: String?
    let wrappers: [String]?
    let defaultValue: String?
}

struct TemplateOption: Codable {
    let label: String?
    let isAmount: Bool?
    let placeholder: String?
    let required: Bool?
    let readOnly: Bool?
    let minLength: Int?
    let maxLength: Int?
}

struct Validation: Codable {
    let messages: Messages
}

struct Messages: Codable {
    let required: String?
    let minLength: String?
    let maxLength: String?
}




enum AnyValue: Codable {
    case int(Int)
    case string(String)

    var intValue: Int? {
        switch self {
        case .int(let value):
            return value
        default:
            return nil
        }
    }

    init(from decoder: Decoder) throws {
        if let intValue = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(intValue)
            return
        }
        if let stringValue = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(stringValue)
            return
        }
        throw DecodingError.typeMismatch(AnyValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Could not decode AnyValue"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let intValue):
            try container.encode(intValue)
        case .string(let stringValue):
            try container.encode(stringValue)
        }
    }
}
