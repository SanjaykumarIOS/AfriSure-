////
////  ModelClass.swift
////  AfriSure
////
////  Created by iosdevelopment on 05/01/24.
////
//
//import Foundation
//import SwiftUI
//
////1. Main response structure
//struct ApiResponse: Codable {
//    var rcode: Int
//    var rObj: ROBJ
//    var rmsg: [RMSG]
//    var reqID: String
//    var objectDBID: String?
//    var transactionRef: String?
//    var outcome: Bool
//    var outcomeMsgCode: String
//    var reDirectURL: String?
//    // Nested 'rObj' structure
//    struct ROBJ: Codable {
//        var fetchMasterData: [FetchMasterData]
//        // Array of 'fetchMasterData'
//        struct FetchMasterData: Codable {
//            var masterDataID: String
//            var parentMasterDataID: String
//            var mdCategoryID: Int
//            var mdTitle: String
//            var mdDesc: String
//            var mdValue: String?
//            var iconURL: String?
//            var regExValidation: String?
//        }
//
//    }
//
//}
//// Array of 'rmsg'
//struct RMSG: Codable {
//    var errorText: String
//    var errorCode: String
//    var fieldName: String?
//    var fieldValue: String?
//}
// 
//class GetProductResponse: Decodable {
//    let rcode: Int
//    let rObj: ProductItem
//    let rmsg: [ResponseMes]
//    let reqID: String
//    let objectDBID: String?
//    let transactionRef: String?
//    let outcome: Bool
//    let outcomeMsgCode: String?
//    let reDirectURL: String?
//    
//    class ProductItem: Decodable {
//        let totalRecords:Int
//        let getAllProduct: [Product]
//        
//        class Product: Decodable {
//               let productID: Int
//               let productRequestID: String
//               let productName: String
//               let productUniqueID: String
//               let productDescription: String
//               let lineOfBusinessID: String
//               let lineOfBusinessText: String
//               let categoryID: String
//               let categoryText: String
//               let currencyID: String
//               let currencyText: String
//               let enforcementStartDate: String
//               let enforcementEndDate: String
//               let defaultPolicyPeriodID: String
//               let defaultPolicyPeriodText: String?
//               let productStatusID: String
//               let productStatusText: String
//               let proposalFormID: String
//        }
//    }
//    
//}
//
//
//class GetInsertQuotationResponse: Decodable {
//    let rcode: Int
//    let rObj: [QuotationObject]
//    let rmsg: [ResponseMes]
//    let reqID: String
//    let objectDBID: String?
//    let transactionRef: String?
//    let outcome: Bool
//    let outcomeMsgCode: String?
//    let reDirectURL: String?
//
//    class QuotationObject: Decodable {
//        let quotationRefID: String
//        let getAccountInformation: AccountInformation
//        
//        let quotationID: String
//        let quotationSearchID: String
//        
//        class AccountInformation: Decodable {
//            let accountID:Int
//            let accountNum:String
//            let fullName:String
//
//        }
//
//    }
//}
// 
//class ResponseMes: Decodable {
//    let errorText: String
//    let errorCode: String
//    let fieldName: String?
//    let fieldValue: String?
//}
//
//
//
//
// // Modules structure
//struct Module: Codable {
//    var sWAModuleID: String
//    var isFunctionality: Bool
//    var parentModuleID: String?
//    var iconClass: String
//    var toolTip: String
//    var url: String?
//    var sequenceID: Int
//    var moduleName: String
//
//    enum CodingKeys: String, CodingKey {
//        case sWAModuleID = "sWAModuleID"
//        case isFunctionality = "isFunctionality"
//        case parentModuleID = "parentModuleID"
//        case iconClass = "iconClass"
//        case toolTip = "toolTip"
//        case url = "url"
//        case sequenceID = "sequenceID"
//        case moduleName = "moduleName"
//    }
//}
//
//// User details structure
//struct UserDetails: Codable {
//    var fullName: String
//    var userUniqueID: String
//    var orgAppLogoURL: String
//    var orgGroupID: String
//    var orgGroupRelationshipTypeID: Int
//    var orgTypesRolesID: Int
//    var orgGroupName: String
//    var emailID: String
//    var roleName: String
//    var orgAppID: Int
//    var typeCode: String
//
//    enum CodingKeys: String, CodingKey {
//        case fullName = "fullName"
//        case userUniqueID = "userUniqueID"
//        case orgAppLogoURL = "orgAppLogoURL"
//        case orgGroupID = "orgGroupID"
//        case orgGroupRelationshipTypeID = "orgGroupRelationshipTypeID"
//        case orgTypesRolesID = "orgTypesRolesID"
//        case orgGroupName = "orgGroupName"
//        case emailID = "emailID"
//        case roleName = "roleName"
//        case orgAppID = "orgAppID"
//        case typeCode = "typeCode"
//    }
//}
//
