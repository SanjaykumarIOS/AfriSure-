import Foundation


class FetchAllProposalFormResponse: Decodable {
    let rcode: Int
    let rObj: FetchAllProposalFormRObj
    let rmsg: [FetchAllProposalFormRmsg]
    let reqID: String
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool?
    let outcomeMsgCode: String?
    let reDirectURL: String?
    
    class FetchAllProposalFormRObj: Decodable {
        let fetchAllProposalForm: [ProposalForm]
        
        class ProposalForm: Decodable {
            let quoationFormID: String?
            let quotationDetailRefID: String?
            let productID: String?
            let productName: String?
            let pZFormTypeID: String?
            let pzFormTypeName: String?
            let pZFormSubTypeID: String?
            let pZFormSubTypeName: String?
            let formRefID: String?
            let formName: String?
            let sequenceNum: Int?
            let isCompleted: Bool?
        }
    }
}


class FetchAllProposalFormRmsg: Decodable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}
