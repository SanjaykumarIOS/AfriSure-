import Foundation


class ProductResponse: Decodable {
    let rcode: Int
    let rObj: ProductData
    let rmsg: [ProductResponseMessage]
    let reqID: String
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool?
    let outcomeMsgCode: String?
    let reDirectURL: String?
    
    class ProductData: Decodable {
        let getAllProduct: [ProductValues]
        
        
        class ProductValues: Decodable {
            let productID: String
            let productCode: String
            let productName: String
            let productDescription: String
            let pZLOB: String
            let pZLOBID: String
            let pzCategory: String
            let pzCategoryID: String
            let crts: String
            let crUserName: String
        }
    }
}



class ProductResponseMessage: Decodable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}
