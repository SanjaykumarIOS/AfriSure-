
import SwiftUI
//
//class QuotationSearchResponse: Decodable {
//    let rcode: Int
//    let rObj: QuotationSearchObject
//    let rmsg: [ResponseMessage]
//    let reqID: String
//    let objectDBID: String?
//    let transactionRef: String?
//    let outcome: Bool
//    let outcomeMsgCode: String?
//    let reDirectURL: String?
//    
//    class QuotationSearchObject: Decodable {
////        let quoationSearchID: String
//        let getAllQuotationSearchProduct: [QuotationSearchProductItem]
////        let getQuotation: [QuotationInfo]
//        
//        class QuotationSearchProductItem: Decodable {
////            let quoationSearchProductID: String
////            let quotationSearchID: String
////            let quotationID: String
//            let productID: Int
//            let productName: String
//            let productUniqueID: String
////            let productDescription: String
////            let lineOfBusinessID: String
////            let lineOfBusinessTitle: String
////            let categoryID: String
////            let categoryText: String
////            let basicPremium: Double
////            let addOnsPremium: Double
////            let riskPremium: Double
////            let discountPremium: Double
////            let taxPremium: Double
////            let beforeTax: Double
////            let totalPremium: Int
////            let paymentTypeID: String?
////            let paymentTypeName: String?
////            let isUnderwritingEligibility: Bool
//            let sTotalPremium: String
//            let sBasicPremium: String
//            let sDiscountPremium: String
//            let sBeforeTax: String
//            let sRiskPremium: String
//            let sTaxPremium: String
//            let sAddOnsPremium: String
//            let getAllByQuotationBreakage: [QuotationBreakage]
////            //               let getAllPreMedicalDocuments: [Any] // Update this type accordingly
////            //               let getAllExcess: [Any] // Update this type accordingly
////            let sTotalCoverAmount: String
////            let isPaymentOnHold: Bool
////            let isExpiryDate: Bool
////            let currencyID: String
////            let currencyText: String
////            let currencyShortName: String
//            let processBreakages: [ProcessBreakage]
////            let quotationRefID: String
////            let underwritingParameter: String?
//            let checklist: [ViewCheckList]
//        }
//        
//    }
//}
//
//class QuotationInfo: Decodable {
//    let quotationRefID: String
//    let quotationID: String
//    let masterQuotationID: String?
//    let masterQuotationRefID: String?
//    let crmAccountID: String
//    let crmAccountNum: String?
//    let title: String?
//    let fullName: String?
//    let createdOn: Date
//    let createdBy: String
//    let createdByUserName: String?
//    let modifyByUserName: String?
//}
//
//class QuotationBreakage: Decodable {
//    let productBreakageID: Int
//    let quoationSearchProductID: String
//    let serialNumber: Int
//    let premiumCategoryName: String
//    let premiumCategoryID: String
//    let premiumCustomText: String
//    let amount: Double
//    let sAmount: String
//    let isSelect: Bool
//    let addOnID: String
//    let quoationSearchID: String
//}
//
//class ViewCheckList: Decodable {
//    let json: String?
//    let objectID: String
//    let objectName: String
//    let objectOrderBy: Int
//    let objectTypeID: String
//    let quoationSearchID: String
//    let quoationSearchProductID: String
//    let searchProductObjectID: Int
//}
//
//
//class ProcessBreakage: Decodable {
//    let breakageID: Int
//    let quoationSearchProductID: String
//    let quoationSearchID: String
//    let productExpressionID: Int
//    let expressionFunctionID: Int
//    let expressionText: String
//    let funcationName: String?
//    let lookup1: String
//    let lookup2: String?
//    let lookup3: String?
//    let lookup4: String?
//    let lookup5: String?
//    let message: String?
//}
//
//class ResponseMessage: Decodable {
//    let errorText: String
//    let errorCode: String
//    let fieldName: String?
//    let fieldValue: String?
//}








class QuotationResponse: Decodable {
    let rcode: Int
    let rObj: QuotationResponseObject
    let rmsg: [QuotationResponseMessage]
    let reqID: String
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool
    let outcomeMsgCode: String
    let reDirectURL: String?
    
    class QuotationResponseObject: Decodable {
        let GetQuotationSearch: QuotationSearch
        
        class QuotationSearch: Decodable {
            let quotationID: String
            let subQuotationID: String
            let quotationRequestID: String
            let quotationSearchID: String
//            let customer: Customer?
            let pZLOB: String
            let pZLOBID: String
            let quotationProduct: [QuotationProduct]
            let productCompare: [ProductCompare]?
//            let mainBenefitsHeaderInfo: [String: MainBenefitHeaderInfo]?
//            let policyID: String?
//            let policyBeginDate: String?
//            let policyEndDate: String?
//            let sumInsured: Int
            
            class ProductCompare: Decodable {
                let insurerTitle: String?
                let insurerID: String?
                let productID: String?
                let productTitle: String?
                let productDescription: String?
                let variantID: String?
                let uniqueProductCode: String?
                let uniqueName: String?
            //    let sumAssured: Int
            //    let premium: Double
                let sSumAssured: String?
                let sPremium: String
                let iconURL: String?
                let quotationDetailRefID: String
                let quotationDetailID: String?
                let mainBenefits: [MainBenefit]?
                let otherBenefits: String?
                
                class MainBenefit: Decodable {
                    let type: String
                    let pZBenefitID: String
                    let pZBenefitTitle: String
                    let pZBenefitDesc: String
                    let verbose: String?
                    let value: String?
                    let available: Bool
                    let importance: String?
                    let showIcon: Bool?
                    let shortDescription: String?
                    let icon: String?
                    let pZBenefitTypeID: Int?
                    let pZBenefitType: String?
                    let isExcessAllowed: Bool?
                    let isAddon: Bool?
                    let marketingStatement1: String?
                    let marketingStatement2: String?
                }
            }

            
            class QuotationProduct: Decodable {
                let quoationSearchProductID: String?
                let isProductEligibility: Bool
//                let purchasePeriod: [PurchasePeriod]?
//                let products: Products?
                let quotationDetails: [QuotationDetail]?
//                let eligibilityParameter: EligibilityParameter?
                
                
                class QuotationDetail: Decodable {
                    let productUniqueID: String
                    let quotationDetailRefID: String
//                    let quotationDetailID: String
//                    let quoationSearchProductID: String
                    let products: Products
//                    let variant: String?
//                    let variantID: String?
//                    let uniqueProductCode: String?
//                    let uniqueName: String?
//                    let isVariantEligibility: Bool
//                    let sumInsured: Int
                    let pZPurchasePeriodID: String?
//                    let pZPurchasePeriod: String
                //    let basicPremium: Double
                //    let benefitsPremium: Double?
                //    let riskPremium: Double
                //    let discountPremium: Double
                //    let taxPremium: Double
                //    let beforeTax: Double
                    let totalPremium: Double?
                    let sTotalPremium: String?
                    let sBasicPremium: String?
                    let sDiscountPremium: String?
                    let sBeforeTax: String?
                    let sRiskPremium: String?
                    let sTaxPremium: String?
                    let sBenefitsPremium: String?
                    let breakdown: [BreakdownItem]?
                    let checklist: [ChecklistItem]?
                    let isInstallment: Bool
                    let installment: [InstallmentItem]?
                    let benefits: [benefitsItem]?
                    
                    // Other properties omitted for brevity
                    
                    class BreakdownItem: Decodable {
                        let productBreakdownID: String
                        let variantID: String?
                        let serialNumber: Int
                        let premiumCategoryName: String
                        let premiumCategoryID: Int
                        let premiumCustomText: String
                //        let amount: Double
                        let sAmount: String
                        let isSelect: Bool
                        let subCategoryID: String?
                        let subCategoryName: String?
                //        let taxPremium: Double
                        let sTaxPremium: String?
                //        let beforeTax: Double
                        let sBeforeTax: String?
                        let information: String?
                        let extraTypeID: String?
                        let extraTypeText: String?
                    }
                    
                    class ChecklistItem: Decodable {
                        let checklistID: String
                        let checklist: String
                        let variantID: String?
                    }
                    
                    class InstallmentItem: Decodable {
                        let pZInstallmentPeriodID: String
                        let pZInstallmentPeriod: String
                //        let amount: Double
                        let sAmount: String
                        let numberOfInstallments: Int
                    }
                    
                    class benefitsItem: Decodable {
                        let pZBenefitCode: String
                        let pZBenefitID: String
                        let pZBenefitTitle: String
                        let pZBenefitDesc: String
                        let amount: Int
                        let sAmount: Int?
                        let variantID: String?
                        let pZBenefitTypeID: Int?
                        let pZBenefitType: String?
                        let isExcessAllowed: Bool
                        let isAddon: Bool
                        let marketingStatement1: String?
                        let marketingStatement2: String?
                        let isBasePremiumBenefit: Bool
                        let isVariantBenefit: Bool
                        let isProductBenefit: Bool
                    }

                }
                
                class EligibilityParameter: Decodable {
                    let pZParameterID: String?
                    let pZParameterKey: String?
                    let pZParameterName: String?
                    let value: Int?
                }
                
            }
        }
    }
}




class Customer: Decodable {
    let accountID: String
    let accountNum: String
    let accountTypeID: Int
    let accountType: String
    let customerStatus: String
    let fullName: String
    let phoneNo: String
    let countryCode: String
    let email: String
}



class PurchasePeriod: Decodable {
    let pZPurchasePeriodID: String?
    let pZPurchasePeriod: String?
    let isAllowed: Bool
    let isInstallmentsAllowed: Bool
    let installments: [Installment]?
}

class Installment: Decodable {
    let pZInstallmentPeriodID: String?
    let pZInstallmentPeriod: String?
    let isAllowed: Bool
    let pZInstallmentLoadTypeID: String?
    let pZInstallmentLoadType: String?
    let pZInstallmentLoadvalue: Double?
}

class Products: Decodable {
    let productID: String
    let productCode: String
    let productName: String
    let productDescription: String
    let pZLOB: String
    let pZLOBID: String
    let pZCategory: String
    let pZCategoryID: String
    let productLogoURL: String?
    let pZPremiumPrimaryCurrencyPrefix: String
    let pZPremiumPrimaryCurrencyID: String
    let pZPremiumPrimaryCurrencyName: String
    let pZBenefitPrimaryCurrencyPrefix: String
    let pZBenefitPrimaryCurrencyID: String
    let pZBenefitPrimaryCurrencyName: String
}

class MainBenefitHeaderInfo: Decodable {
    let title: String
    let description: String
}

class QuotationResponseMessage: Decodable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}






struct TextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(isFontMedium(size: 18))
            .modifier(EquallySized())
    }
}

struct EquallySized: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
                .frame(maxHeight: .infinity)
                .frame(height: .infinity)
                .background(GeometryReader { proxy in
                    Color.clear.preference(key: HeightPreferenceKey.self, value: proxy.size.height)
                })
                .onPreferenceChange(HeightPreferenceKey.self) { height in
                    content.frame(height: height)
                }
            Spacer()
        }
    }
}

struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}



struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
