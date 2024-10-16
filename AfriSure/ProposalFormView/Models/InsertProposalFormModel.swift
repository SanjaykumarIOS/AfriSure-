class InsertProposalFormResponse: Decodable {
    let rcode: Int
//    let rObj: InsertProposalValues
    let rmsg: [InsertProposalFormResponseMessage]
    let reqID: String
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool
    let outcomeMsgCode: String?
    let reDirectURL: String?
    
    class InsertProposalValues: Decodable {
        let policyNumber: String?
        let policyID: String
    }
}
 
class InsertProposalFormResponseMessage: Decodable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}






class InsertProposalFormv2Response: Decodable {
    let rcode: Int
    let rObj: InsertProposalFormv2RObj
    let rmsg: [InsertProposalFormv2Rmsg]
    let reqID: String?
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool?
    let outcomeMsgCode: String?
    let reDirectURL: String?
    
    class InsertProposalFormv2RObj: Decodable {
        let policyID: String?
        let isSelfTask: Bool?
        let policyNumber: String?
    }
}



class InsertProposalFormv2Rmsg: Decodable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}
