

import SwiftUI

struct AssetsInfo: View {
    
    @State var assetsInfoViewJsonArray: [AssetsViewJsonModel.Field] = []
    
    @Binding var navigateAssetsInfoPage: Bool
    
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
                            ForEach(assetsInfoViewJsonArray, id: \.key) { field in
                                
                                let templateOptions = field.templateOptions
                                
                                if templateOptions.label != "Api Url" {
                                    Text("\(templateOptions.label)")
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
                    fetchAssetsInfo()
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
                                withAnimation {
                                    navigateAssetsInfoPage = false
                                }
                            })
                            {
                                
                                Image(systemName: "arrow.backward")
                                    .bold()
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .padding(.bottom)
                                
                            }
                            
                            Text(assetsLabelName)
                                .bold()
                                .font(isFontBlack(size: 22))
                                .foregroundColor(.white)
                                .padding(.bottom,8)
                            
                            NavigationLink("", destination: GeneratePolicy(isOverlayVisible: .constant(false)), isActive: $navigateGeneratePolicyPage)

                            
                        }
                    }
                }
                .toolbarBackground(toolbarcolor,for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .navigationBarBackButtonHidden()
        
        .overlay(
            !networkMonitor.isConnected ? ErrorView() : nil
        )
    }
    
    func fetchAssetsInfo() {
        isLoading = true
        let url = URL(string: "\(BaseURL)api/digital/core/Policy/GetAssetsInfo")!
        print(url)
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        
        let authToken:String! = "Bearer " + Extensions.token
        
        request.addValue(authToken, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print(authToken as Any)
        
        let parameters: [String: Any] = [
            
            "assetID": assetsTypeId
            
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
                print("Assets Info Response = \(String(describing: resultDictionary))")
                
//                let decoder = JSONDecoder()
//                let Response = try decoder.decode(AssetsAddNewPersonResponse.self, from: data)
                
                DispatchQueue.main.async {
                    
                    let rcode = resultDictionary["rcode"] as? Int
                    
                    if rcode == 200 {
                        print(rcode as Any)
                        
                        if let rObj = resultDictionary["rObj"] as? [String: Any],
                           let getAssetInfo = rObj["getAssetInfo"] as? [String: Any],
                           let viewJsonString = getAssetInfo["viewJson"] as? String {
                            print("viewJson: \(viewJsonString)")
                            
                            
                            if let visibilityData = viewJsonString.data(using: .utf8) {
                                do {
                                    let visibilityModel = try JSONDecoder().decode(AssetsViewJsonModel.self, from: visibilityData)
                                    assetsInfoViewJsonArray = visibilityModel.filed
                                   
                                } catch {
                                    print("Error decoding visibility data: \(error)")
                                }
                            } else {
                                print("Error converting 'viewJson' to data")
                            }
                        }
                                                
                        isLoading = false
                        
                    } else {
                        
                        if let rmsg = resultDictionary["rmsg"] as? [NSDictionary] {
                            for message in rmsg {
                                if let errorText = message["errorText"] as? String {
                                    self.alertItem = AlertItem(title: Text(errorText))
                                }
                                if let errorCode = message["errorCode"] as? String {
                                    print("errorCode: \(errorCode)")
                                }
                                if let fieldName = message["fieldName"] as? String {
                                    print("fieldName: \(fieldName)")
                                }
                                if let fieldValue = message["fieldValue"] as? String {
                                    print("fieldValue: \(fieldValue)")
                                }
                            }
                        }
                        
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




struct AssetsInfo_Previews: PreviewProvider {
    static var previews: some View {
        AssetsInfo(navigateAssetsInfoPage:.constant(false))
    }
}





class AssetsViewJsonModel: Decodable {
    let filed: [Field]

    class Field: Decodable {
        let key: String
        let defaultValue: String
        let type: String
        let templateOptions: TemplateOptions
        let wrappers: [String]
        let className: String

        class TemplateOptions: Decodable {
            let label: String
            let disabled: Bool
        }
    }
}
