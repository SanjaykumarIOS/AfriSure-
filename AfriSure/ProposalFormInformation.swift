//
//  ProposalFormInformation.swift
//  AfriSure
//
//  Created by iosdevelopment on 31/01/24.
//

import SwiftUI

struct ProposalFormInformation: View {
    @State private var generatePolicyArray: [GeneratePolicyResponseData.GeneratePolicyRObject.MenuDetails.MenuItem] = []

    @State var navigateQuoteInfoPage = false
    @State var navigateProposalInfoPage = false
    @State var showPolicyConfirmation = false
    
    @State private var alertItem: AlertItem?
    @State private var isLoading = false
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear(){
                callGetProposalFormInformationFormlyAPI()
            }
    }
    func callGetProposalFormInformationFormlyAPI() {
        isLoading = true
        let url = URL(string: "\(BaseURL)api/digital/core/Product/GetProposalFormInformationFormly")!
        print(url)
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        
        let authToken:String! = "Bearer " + Extensions.token
        
        request.addValue(authToken, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print(authToken as Any)
        
        let parameters: [String: Any] = [
            "policyID":"96891f96-75e9-4641-bc89-ea9610f88c19"
            ]
        
        print(parameters)
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let data = data else {
                print("\("Error No data returned from server") \(error?.localizedDescription ?? "")")
                self.alertItem = AlertItem(title: Text("\("Error No data returned from server") \(error?.localizedDescription ?? "")"))
                isLoading = false
                return
            }
            
            do {
                
                var resultDictionary:NSDictionary! = NSDictionary()
                resultDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                print("GetProposalFormInformationFormly Response = \(String(describing: resultDictionary))")
                
                let decoder = JSONDecoder()
                let Response = try decoder.decode(GeneratePolicyResponseData.self, from: data)
                
                DispatchQueue.main.async {
                    
                    if Response.rcode == 200 {
                        print(Response.rcode)
                        
                        generatePolicyArray = Response.rObj.menuDetails.menuItems
                        
                        showPolicyConfirmation = true
                        isLoading = false
                        
                    } else {
                        self.alertItem = AlertItem(title: Text(Response.rmsg.first?.errorText ?? ""))
                        isLoading = false
                    }
                    
                }
            } catch {
                print("\("Error decoding response") \(error.localizedDescription)")
                self.alertItem = AlertItem(title: Text("An unexpected error occurred"))
                isLoading = false
            }
        }
        task.resume()
    }

}

struct ProposalFormInformation_Previews: PreviewProvider {
    static var previews: some View {
        ProposalFormInformation()
    }
}
