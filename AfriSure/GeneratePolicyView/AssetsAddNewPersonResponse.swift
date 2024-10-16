

import SwiftUI

class AssetsAddNewPersonResponse: Decodable {
    let rcode: Int
    let rObj: GetAddNewPerson
    let rmsg: [AssetsAddNewPersonResponseMessage]
    let reqID: String
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool
    let outcomeMsgCode: String?
    let reDirectURL: String?
    
    class GetAddNewPerson: Decodable {
        let formFieldList: FormField
        let getForm: GetFormValue
        
        
        class FormField: Decodable {
            let fieldGroup: [FieldGroup]
            
            class FieldGroup: Decodable {
                let key: String?
                let type: String?
                let templateOptions: TemplateOptions?
                let validation: Validation?
                let fieldGroup: [FieldGroup]?
                var defaultValue: String?
                
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
            }
            
        }
        
        
        class GetFormValue: Decodable {
            let orgFormID: Int
            let assetTypeID: String
            let formRefID: String
            let formName: String
        }
    }
}


class AssetsAddNewPersonResponseMessage: Decodable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}
 
 
 
