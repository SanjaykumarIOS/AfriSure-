//
//  QuoteInfoModel.swift
//  AfriSure
//
//  Created by SANJAY  on 18/01/24.
//

import SwiftUI

import Foundation

class QuoteInfoResponse: Decodable {
    let rcode: Int
    let rObj: QuoteInfoObject
    let rmsg: [QuoteInfoResponseMessage]
    let reqID: String
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool
    let outcomeMsgCode: String
    let reDirectURL: String?
    
    class QuoteInfoObject: Decodable {
        let getAllQuotationSearchProduct: [QuotationSearchProduct]
        let getQuotationByPolicyID: QuoteInfoDetails
        let viewJson: String?
//        let information: InformationDetails
        
        class QuotationSearchProduct: Decodable {
            let sBasicPremium: String
            let sRiskPremium: String
            let sDiscountPremium: String
            let sTaxPremium: String
            let sTotalPremium: String
        }
        
        class QuoteInfoDetails: Decodable {
            let quotationRefID: String
            let quotationID: String
            let masterQuotationID: String
            let masterQuotationRefID: String
            let crmAccountID: String
            let productID: Int
            let crmAccountNum: String
            let title: String
            let fullName: String
            let createdOn: String
            let createdBy: String
            let createdByUserName: String
            let modifyByUserName: String
            let quoationSearchProductID: String
            let quotationSearchID: String
            let lobName: String
            let productName: String
            let accountStatus: String
            let quotationTotalAmount: Double
            let sQuotationTotalAmount: String
            let currencyTitle: String
            let quotationExpiryDate: String
            let sourceQuotation: String
        }
        
        class InformationDetails: Decodable {
            let Gender: String
            let SumInsured: String
            let Occupation: String
            let IsSmoker: String
            let PaymentPeriodID: String
            let Term: String
            let DateOfBirth: String
            let ADDON_a0a3c364110849288b87fc90fef1e5a1: Bool
            let ADDON_a0a3c364110849288b87fc90fef1e5a2: Bool
            let ADDON_a0a3c364110849288b87fc90fef1e5a3: Bool
            let productIDs: [Int]
            let quotationSearchID: String
            let quotationRefID: String
            let viewJson: String
        }
    }
}


class QuoteInfoResponseMessage: Decodable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}




class ViewJsonModel: Codable {
    let filed: [Field]
    
    class Field: Codable {
        let templateOptions: TemplateOptionsModel
        let defaultValue: String
        let Key: String
        let wrappers: [String]
        let className: String
        let type: String
        
        class TemplateOptionsModel: Codable {
            let label: String
            let disabled: Bool
        }

    }

}


