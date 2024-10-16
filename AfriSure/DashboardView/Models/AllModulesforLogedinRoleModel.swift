

import SwiftUI

class FetchAllModulesforLogedinRoleResponse: Decodable {
    let rcode: Int
    let rObj: ModulesforLogedinRole
    let rmsg: [LogedinRoleRMsg]
    let reqID: String
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool
    let outcomeMsgCode: String?
    let reDirectURL: String?
    let isSuccess: String?
    
    class ModulesforLogedinRole: Decodable {
        let modulesforRole: [SWAModule]
        let userDetails: UserDetails
        
        class SWAModule: Decodable {
            let sWAModuleID: String?
            let moduleCode: String?
            let isFunctionality: Bool
            let parentModuleID: String?
            let iconClass: String?
            let toolTip: String?
            let url: String?
            let sequenceID: Int?
            let isEnabled: Bool?
            let moduleDetailID: String?
            let moduleName: String?
            let moduleDescription: String?
            let orgAppID: String?
            let orgTypesRolesID: String?
            let languageID: String?
        }
        
        class UserDetails: Decodable {
            let emailID: String
            let fullName: String
            let orgAppID: Int
            let orgAppLogoURL: String
            let orgGroupID: String
            let orgGroupName: String
            let orgGroupRelationshipTypeID: Int
            let orgTypesRolesID: Int
            let roleName: String
            let typeCode: String
            let userUniqueID: String
        }
    }
}
 
class LogedinRoleRMsg: Decodable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}
