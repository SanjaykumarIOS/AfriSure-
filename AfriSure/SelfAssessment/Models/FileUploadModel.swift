
import Foundation

class FileUploadResponse: Decodable {
    let rcode: Int
    let rObj: FileUploadRObj
    let rmsg: [FileUploadRmsg]
    let reqID: String?
    let objectDBID: String?
    let transactionRef: String?
    let outcome: Bool?
    let outcomeMsgCode: String?
    let reDirectURL: String?
    let isSuccess: Bool?
    
    class FileUploadRObj: Decodable {
        let SASURL: String?
        let attachmentID: String?
    }
}



struct FileUploadRmsg: Codable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}
