import Foundation




struct AccountResponse: Codable {
    let rcode: Int
    let rObj: AccountData
    let rmsg: [AccountResponseMessage]
    let reqID: String
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool
    let outcomeMsgCode: String
    let reDirectURL: String?
}

struct AccountData: Codable {
    let getAccountRetailInsertDetails: AccountDetails
}

struct AccountDetails: Codable {
    let accountName: String
    let accountID: String
    let accountNum: String
    let accountType: Int
    let accountTypeName: String
    let accountStatus: String
}

struct AccountResponseMessage: Codable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}
