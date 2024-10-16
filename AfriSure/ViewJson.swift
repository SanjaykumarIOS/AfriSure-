//import SwiftUI
//import Foundation
//
//struct ViewJson: View {
//    var body: some View {
//        
//        Text(viewJsonString)
//            .padding()
//            .onAppear(){
//                callConvertViewJson()
//            }
//        
//        
//    }
//    func callConvertViewJson(){
//        let viewJsonData = [
//            "filed": [
//                [
//                    "Key": "FirstName",
//                    "defaultValue": "aadhi",
//                    "type": "input",
//                    "wrappers": ["tooltip-icon"],
//                    "templateOptions": [
//                        "label": "Firstname",
//                        "disabled": false
//                    ],
//                    "className": "col-md-12"
//                ]
//            ]
//        ]
//
//        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: viewJsonData, options: .prettyPrinted)
//            
//            if let jsonString = String(data: jsonData, encoding: .utf8) {
//                let viewJsonString = """
//                {
//                    "viewJson": \(jsonString)
//                }
//                """
//                print(viewJsonString)
//                if let viewJsonObject = try JSONSerialization.jsonObject(with: viewJsonString.data(using: .utf8)!, options: []) as? [String: Any] {
//                    print(viewJsonObject)
//                }
//            }
//        } catch {
//            print("Error: \(error)")
//        }
//
//
//    }
//    var viewJsonString: String {
//        let fieldArray: [[String: Any]] = [
//            ["Key": "FirstName",
//             "defaultValue": "aadhi",
//             "type": "input",
//             "templateOptions": ["label": "Firstname", "disabled": false],
//             "wrappers": ["tooltip-icon"],
//             "className": "col-md-12"],
//            ["Key": "LastName",
//             "defaultValue": "arc",
//             "type": "input",
//             "templateOptions": ["label": "Lastname", "disabled": false],
//             "wrappers": ["tooltip-icon"],
//             "className": "col-md-12"],
//            // Add more fields here as needed
//        ]
//        
//        let viewJsonDictionary: [String: Any] = ["filed": fieldArray]
//        
//        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: viewJsonDictionary, options: [])
//            if let jsonString = String(data: jsonData, encoding: .utf8) {
//                print(jsonString)
//
//                return jsonString
//            }
//        } catch {
//            print("Error converting to JSON: \(error.localizedDescription)")
//        }
//        
//        return ""
//    }
//}
//
//struct ViewJson_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewJson()
//    }
//}
