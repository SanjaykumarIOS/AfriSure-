class GetProposalResponse: Decodable {
    let rcode: Int
    let rObj: GetProposalValues
    let rmsg: [GetProposalResponseMessage]
    let reqID: String
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool
    let outcomeMsgCode: String?
    let reDirectURL: String?
    
    class GetProposalValues: Decodable {
        let getProposalForm: FormField
        let getProposalFormJson: String
        let ProposalFormID : String
 
        class FormField: Decodable {
            let fieldGroup: [FieldGroup]
            let id : String?
            let documentId : String?
            let premiumLogicID : String?
            let formlyValidations : String?
           
            class FieldGroup: Decodable {
                let key: String?
                let type: String?
                let templateOptions: TemplateOptions?
                let validation: Validation?
                let fieldGroup: [FieldGroup]?
                let className: String?
                let wrappers: [String]?
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
    }
}
 
 
class GetProposalResponseMessage: Decodable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}
