


import SwiftUI

struct ProposalInfo: View {
    
    @State var proposalInfoViewJsonArray: [ViewJsonModel.Field] = []
    
    @Binding var navigateProposalInfoPage: Bool
    
    @State var navigateGeneratePolicyPage = false
    
    @State private var alertItem: AlertItem?
    @State private var isLoading = false
    
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some View {
        NavigationStack {
            LoadingView(isShowing: $isLoading) {
                VStack {
                    
                    ScrollView {
                        VStack {
                            ForEach(proposalInfoViewJsonArray, id: \.Key) { field in
                                
                                if !field.Key.hasPrefix("ADDON") && !field.Key.isEmpty {
                                    
                                    let templateOptions = field.templateOptions
                                    Text("\(templateOptions.label) \(templateOptions.disabled ? "*" : "")")
                                        .halfTextColorChange(fullText: "\(templateOptions.label) \(templateOptions.disabled ? "*" : "")", changeText: "*")
                                        .font(isFontMedium(size: 18))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading)
                                    
                                    TextField("", text: .constant(field.defaultValue))
                                        .padding(.trailing,25)
                                        .padding(10)
                                        .frame(width: 350,height: 50)
                                        .font(isFontMedium(size: 18))
                                        .autocapitalization(.none)
                                        .autocorrectionDisabled()
                                        .background(Color.gray.opacity(0.2))
                                        .foregroundColor(.black)
                                        .cornerRadius(8)
                                        .padding(.bottom)
                                        .disabled(!templateOptions.disabled)
                                    
                                }

                            }
                        }
                        .padding(.top)
                    }
                }
                .onAppear {
                    fetchProposalInfo()
                }
                
                // ALERT VIEW
                .alert(item: $alertItem) { alertItem in
                    Alert(title: alertItem.title)
                }
                
                //  TOOL BAR
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        
                        HStack {
                            
                            Button(action: {
//                                navigateGeneratePolicyPage = true
                                withAnimation(.easeInOut) {
                                    navigateProposalInfoPage = false
                                }
                            })
                            {
                                
                                Image(systemName: "arrow.backward")
                                    .bold()
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .padding(.bottom)
                                
                            }
                            
                            Text("Proposal Info")
                                .bold()
                                .font(isFontBlack(size: 22))
                                .foregroundColor(.white)
                                .padding(.bottom,8)
                            
//                            NavigationLink("", destination: GeneratePolicy(isOverlayVisible: .constant(true)), isActive: $navigateGeneratePolicyPage)
                            
                        }
                    }
                }
                .toolbarBackground(toolbarcolor,for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
               
            }
        }.navigationBarBackButtonHidden()
        
            .overlay(
                !networkMonitor.isConnected ? ErrorView() : nil
            )
    }
    
    
    func fetchProposalInfo() {
        
        isLoading = true
        
        let parameters: [String: Any] = [
            "policyID":Extensions.policyID
            ]

        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(BaseURL)")!,
                                         path: "api/digital/core/Product/GetProposalFormInformationFormly",
                                         method: "POST",bodyData:parameters)
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<ProposalInfoResponse, Error>) in
            switch result {
            case .success(let Response):
                // Handle success
                DispatchQueue.main.async {
                    
                    if Response.rcode == 200 {
                        print(Response.rcode)

                        
                        if let visibilityData = Response.rObj.viewJson.data(using: .utf8) {
                            do {
                                let visibilityModel = try JSONDecoder().decode(ViewJsonModel.self, from: visibilityData)
                                proposalInfoViewJsonArray = visibilityModel.filed

                            } catch {
                                print("Error decoding visibility data: \(error)")
                            }
                        } else {
                            print("Error converting 'viewJson' to data")
                        }
                        
                        isLoading = false
                        
                    } else {
                        self.alertItem = AlertItem(title: Text(Response.rmsg.first?.errorText ?? ""))
                        isLoading = false
                    }
                    
                }

            case .failure(let error):
                // Handle error
                print(error)
                self.alertItem = AlertItem(title: Text("An unexpected error occurred"))
                isLoading = false
            }
        }
        
        
        
        
//        isLoading = true
//        let url = URL(string: "\(BaseURL)api/digital/core/Product/GetProposalFormInformationFormly")!
//        print(url)
//        let request = NSMutableURLRequest(url: url)
//        request.httpMethod = "POST"
//        
//        let authToken:String! = "Bearer " + Extensions.token
//        
//        request.addValue(authToken, forHTTPHeaderField: "Authorization")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        print(authToken as Any)
//        
//        let parameters: [String: Any] = [
//            "policyID":Extensions.policyID
//            ]
//        
//        print(parameters)
//        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
//        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
//            guard let data = data else {
//                print("\("Error No data returned from server") \(error?.localizedDescription ?? "")")
//                self.alertItem = AlertItem(title: Text("\("Error No data returned from server") \(error?.localizedDescription ?? "")"))
//                isLoading = false
//                return
//            }
//            
//            do {
//                
//                var resultDictionary:NSDictionary! = NSDictionary()
//                resultDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
//                print("GetProposalFormInformationFormly Response = \(String(describing: resultDictionary))")
//                
//                let decoder = JSONDecoder()
//                let Response = try decoder.decode(ProposalInfoResponse.self, from: data)
//                
//                DispatchQueue.main.async {
//                    
//                    if Response.rcode == 200 {
//                        print(Response.rcode)
//
//                        
//                        if let visibilityData = Response.rObj.viewJson.data(using: .utf8) {
//                            do {
//                                let visibilityModel = try JSONDecoder().decode(ViewJsonModel.self, from: visibilityData)
//                                proposalInfoViewJsonArray = visibilityModel.filed
//
//                            } catch {
//                                print("Error decoding visibility data: \(error)")
//                            }
//                        } else {
//                            print("Error converting 'viewJson' to data")
//                        }
//                        
//                        
//                        isLoading = false
//                        
//                    } else {
//                        self.alertItem = AlertItem(title: Text(Response.rmsg.first?.errorText ?? ""))
//                        isLoading = false
//                    }
//                    
//                }
//            } catch {
//                print("\("Error decoding response") \(error.localizedDescription)")
//                self.alertItem = AlertItem(title: Text("An unexpected error occurred"))
//                isLoading = false
//            }
//        }
//        task.resume()
    }
}

struct ProposalInfo_Previews: PreviewProvider {
    static var previews: some View {
        ProposalInfo(navigateProposalInfoPage: .constant(false))
    }
}
