import Foundation



class InsertCustomFormResponse: Decodable {
    let rcode: Int
    let rObj: InsertCustomFormRObject
    let rmsg: [InsertCustomFormRMessage]
    let reqID: String
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool
    let outcomeMsgCode: String
    let reDirectURL: String?
    
    class InsertCustomFormRObject: Decodable {
        let SubQuotationID: String
        let quotationSearchID: String
    }
}



class InsertCustomFormRMessage: Decodable {
    let errorText: String
    let errorCode: String?
    let fieldName: String?
    let fieldValue: String?
}
