

import SwiftUI



import Foundation

class GeneratePolicyResponseData: Decodable {
    let rcode: Int
    let rObj: GeneratePolicyRObject
    let rmsg: [GeneratePolicyRMessage]
    let reqID: String
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool
    let outcomeMsgCode: String
    let reDirectURL: String?
    
    class GeneratePolicyRObject: Decodable {
        let menuDetails: MenuDetails
        
        class MenuDetails: Decodable {
            let id: Int
            let objectID: Int
            let objectName: String
            let menuItems: [MenuItem]
            
            class MenuItem: Decodable {
                let menuTypeID: Int
                let label: String
                let iconClass: String
                let children: [ChildMenuItem]?
                let isCompleted: Bool
                let isCreate: Bool
                let id: String?
                let url: String?
                let onClickFunction: String?
                let isNew: Bool?
                let isIndependent: Bool?
                
                class ChildMenuItem: Decodable {
                    let id: String?
                    let label: String
                    let url: String?
                    let onClickFunction: String?
                    let isCreate: Bool?
                    let isNew: Bool?
                    let isCompleted: Bool
                    let isIndependent: Bool?
                }
            }
        }
    }
}

class GeneratePolicyRMessage: Decodable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}


