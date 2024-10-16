
import SwiftUI

class AddonsExcessResponse: Decodable {
    let rcode: Int
    let rObj: AddonsExcessValues
    let rmsg: [AddonsExcessResponseMessage]
    let reqID: String
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool
    let outcomeMsgCode: String?
    let reDirectURL: String?
    
    class AddonsExcessValues: Decodable {
        let getAllAPIFormaly1: [FormField]
//            let fetchAllPolicyExtras: [String]
            let getAllAPIFormaly: String
 
        class FormField: Decodable {
            let fieldGroup: [FieldGroup]
           
            class FieldGroup: Decodable {
                let key: String?
                let type: String?
                let templateOptions: TemplateOptions?
                let validation: Validation?
                let expressionProperties: ExpressionProperties?
                let fieldGroup: [FieldGroups]?
                let className: String?
                let wrappers: [String]?
                var defaultValue: Bool?
                let orderData: Int?
                
                class TemplateOptions: Decodable {
                    let label: String
                    let required: Bool
                    let options: [Option]?
                    let type: String?
                    let placeholder: String?
                    
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
                
                class ExpressionProperties: Decodable {
                    let hide: String?
                    let className: String?
                    let wrappers: [String]?
                }
            }
            
            class FieldGroups: Decodable {
                let key: String?
                let type: String?
                let templateOptions: TemplateOptions?
                let validation: Validation?
                let expressionProperties: ExpressionProperties?
                let fieldGroup: [FieldGroup]?
                let className: String?
                let wrappers: [String]?
                var defaultValue: String?
                let orderData: Int?
                
                class TemplateOptions: Decodable {
                    let label: String
                    let required: Bool
                    let options: [Option]?
                    let type: String?
                    let placeholder: String?
                    
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
                
                class ExpressionProperties: Decodable {
                    let hide: String?
                    let className: String?
                    let wrappers: [String]?
                }
            }
        }
    }
}
 
 
class AddonsExcessResponseMessage: Decodable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}
