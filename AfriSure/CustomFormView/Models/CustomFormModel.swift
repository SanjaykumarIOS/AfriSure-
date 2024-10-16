

import SwiftUI

//class GetProductsResponse: Decodable {
//    let rcode: Int
//    let rObj: GetProductValues
//    let rmsg: [GetProductResponseMessage]
//    let reqID: String
//    let objectDBID: String?
//    let transactionRef: String?
//    let outcome: Bool
//    let outcomeMsgCode: String?
//    let reDirectURL: String?
//
//    class GetProductValues: Decodable {
////        let getAllAPIFormalyJson: [FormField]
//        let getAllAPIFormaly: [FormField]
//        let productIDs: [Int]
//
//        class FormField: Decodable {
//            let fieldGroup: [FieldGroup]
//
//            class FieldGroup: Decodable {
//                let key: String?
////                let apiUrl: String?
//                let type: String?
//                let templateOptions: TemplateOptions?
//                let validation: Validation?
//                let expressionProperties: ExpressionProperties?
//                let fieldGroup: [FieldGroup]?
//                var defaultValue: String?
//
//
////                let hideExpression: String?
////                let className: String?
////                let wrappers: String?
////                let orderData: Int?
////                let props: String?
////                let fieldGroupClassName: String?
////                let template: String?
////
//                class TemplateOptions: Decodable {
//                    let label: String
//                    let required: Bool
//                    let options: [Option]?
//                    let type: String?
//                    let placeholder: String?
//
////                    let allowedFileTypes: String?
////                    let rows: Int
////                    let indeterminate: Bool?
////                    let disabled: Bool?
////                    let readOnly: Bool?
////                    let pattern: String?
////                    let isOnloadAPICall: Bool?
////                    let placeholder: String?
////                    let valueProp: String?
////                    let labelProp: String?
////                    let multiple: Bool?
////                    let selectAllOption: Bool?
////                    let cascadingParentControl: String?
////                    let apiUrl: String?
////                    let rObjData: String?
////                    let inputParameter: String?
////                    let minLength: Int?
////                    let maxLength: Int?
////                    let isMultiple: Bool?
////                    let fileslength: Int?
////                    let maxSize: Int?
////                    let isDependency: Bool?
////                    let dateMinType: String?
////                    let countMin: Int?
////                    let dateMaxType: String?
////                    let countMax: Int?
////                    let datepickerOptions: String?
//
//                    class Option: Decodable {
//                        let label: String
//                        let value: String
//                    }
//
//
//                }
//
//                class Validation: Decodable {
//                    let messages: Messages
//
//                    class Messages: Decodable {
//                        let required: String
//                        let minLength: String?
//                        let maxLength: String?
//                        let pattern: String?
//                    }
//                }
//
//                class ExpressionProperties: Decodable {
//                    let hide: String?
//                    let className: String?
//                    let wrappers: [String]?
//                }
//            }
//        }
//    }
//}
//
//
//class GetProductResponseMessage: Decodable {
//    let errorText: String
//    let errorCode: String
//    let fieldName: String?
//    let fieldValue: String?
//}
//



import Foundation

class GetCustomFormResponse: Decodable {
    let rcode: Int
    let rObj: CustomFormRObj
    let rmsg: [CustomFormRmsg]
    let reqID: String
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool
    let outcomeMsgCode: String
    let reDirectURL: String?
    
    class CustomFormRObj: Decodable {
        let getAllAPIFormalyJson: String
        let getQuotationSearch: GetQuotationSearch
        
        class GetQuotationSearch: Decodable {
            let customer: Customer?
            let product: [Product]?
            let productIDs: String?
            let pZLOB: String?
            let pZLOBID: String?
            let quotationRequestID: String?
            let pZSourceOfBusinessID: String?
            let pZSourceOfBusiness: String?
            
            class Customer: Decodable {
                let accountID: String?
                let accountNum: String?
                let accountTypeID: Int?
                let accountType: String?
                let customerStatus: String?
                let fullName: String?
                let phoneNo: String?
                let countryCode: String?
                let email: String?
            }

            class Product: Decodable {
                let productID: String?
                let productCode: String?
                let productName: String?
                let productDescription: String?
                let pZCategory: String?
                let pZCategoryID: String?
            }
        }
    }
}

class CustomFormRmsg: Decodable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}



class GetAllAPIFormalyJsonResponse: Codable {
//    let fieldGroupClassName: String?
    let fieldGroup: [FieldGroup]
    
    class FieldGroup: Codable {
        let key: String?
        let type: String?
        let templateOptions: TemplateOptions?
        let validation: Validation?
        let orderData: Int?
        let template: String?
//        //        let fieldArray: Any?
        let expressionProperties: ExpressionProperties?
        let wrappers: [String]?
        let fieldGroup:[FieldGroup]?
        var defaultValue: String?
        let props: Props?
        let fieldGroupClassName: String?
        
        
        class Props: Codable {
            let label: String
        }
        
        class ExpressionProperties: Codable {
            let hide: String?
        }
        
        class TemplateOptions: Codable {
            let label: String?
            let rows: Int?
            let required: Bool
            let options: [Option]?
            let isOnloadAPICall: Bool?
            let placeholder: String?
            let valueProp: String?
            let labelProp: String?
            let cascadingParentControl: String?
            let apiUrl: String?
            let rObjData: String?
            let inputParameter: String?
            let maxLength: Int?
            let min: Int?
            let max: Int?
            let isMultiple: Bool?
            let isAmount: Bool?
            let filesLength: Int?
            let maxSize: Int?
            let isDependency: Bool?
            let dateMinType: String?
            let countMin: Int?
            let dateMaxType: String?
            let blobUploadLocation: String?
            let dateParentControl: String?
            let dateTypeMinDependent: String?
            let countMinDependent: Int?
            let categoryID: String?
            let dateTypeMaxDependent: String?
            let countMaxDependent: Int?
            let countMax: Int?
            let datepickerOptions: DatepickerOptions?
            
            class DatepickerOptions: Codable {
                let min: String?
                let max: String?
            }
            
            class Option: Codable {
                let label: String
                let value: String
            }
        }
        
        class Validation: Codable {
            let messages: ValidationMessages
            
            class ValidationMessages: Codable {
                let required: String?
                let pattern: String?
                let min: String?
                let max: String?
            }
        }
    }
}











struct FormData: Codable {
//    let fieldGroupClassName: String?
    let fieldGroup: [FormField]
}

struct FormField: Codable {
    let key: String? // Make it optional to handle cases where it might be missing
    let type: String?
    let templateOptions: TemplateOptions?
}

struct TemplateOptions: Codable {
    let label: String?
    // Add other properties as needed
}
