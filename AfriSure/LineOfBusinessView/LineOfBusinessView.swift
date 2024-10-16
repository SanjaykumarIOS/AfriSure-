//
//  InsuranceOptionView.swift
//  AfriSure
//
//  Created by iosdevelopment on 02/01/24.
//

import SwiftUI


struct LineOfBusinessView: View {
    
    @Binding var navigateInsuranceOptiondPage: Bool
    
    @State private var searchText = ""
    @State private var selectedNavigationLink: String? = nil
//    @State private var detailsArray: [ApiResponse.ROBJ.FetchMasterData] = []
    @State private var detailsArray: [LobResponse.LobData.LOBValues] = []
    @State private var isLoading = false
    @State private var alertItem: AlertItem?
    @State private var navigateDashboardPage = false
    @State private var navigateProductPage = false
    
    @StateObject var networkMonitor = NetworkMonitor()
    
    
    var body: some View {
        NavigationStack {
            LoadingView(isShowing: $isLoading){
                VStack{
                    HStack {
                        TextField("Search", text: $searchText)
                            .padding(.leading,40)
                            .frame(width: 350 ,height: 50)
                            .background(Color(.white))
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            .padding(.bottom, 10)
                            .padding(.horizontal, 25)
                            .padding(.top, 10)
                            .font(isFontMedium(size: 18))
                        
                            .overlay(
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.black)
                                        .bold()
                                        .font(.system(size: 20))
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 30)
                                    
                                    
                                    if !searchText.isEmpty {
                                        Button(action: {
                                            self.searchText = ""
                                        }) {
                                            Image(systemName: "multiply.circle.fill")
                                                .foregroundColor(.gray)
                                                .padding(.trailing, 30)
                                        }
                                    }
                                }
                            )
                            .padding(.horizontal, 10)
                    }
                    
                    ScrollView {
                        VStack {
                            ForEach(filteredItems(searchText: searchText), id: \.pZLOBID) { item in
                                
                                Button(action: {
                                    Extensions.lineOfBusinessID = "\(item.pZLOBID)"
                                    
                                    withAnimation {
                                        navigateProductPage = true
                                    }
                                    
                                    Extensions.selectedLineOfBusiness = "\(item.pZLOB)"
                                                                        
                                    Extensions.selectedItem = Set<String>()
                                    productArray = []
                                    
                                    selectedProductIds = Set<String>()
                                    
                                }) {
                                    VStack(alignment: .leading) { // Align text to the left
                                        Text(item.pZLOB)
                                            .font(isFontBold(size: 18))
                                            .foregroundColor(toolbarcolor)
                                        
                                        Text(item.pZLOBDesc)
                                            .font(isFontMedium(size: 15))
                                            .padding(.top, 0.5)
                                            .foregroundColor(.black)
                                    }
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading)
                                    
//                                    NavigationLink(destination: ProductsView(), tag: "ProductsPage", selection: $selectedNavigationLink) { EmptyView() }

                                }
                                
                                .frame(width: 350, height: 80)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                .padding(.bottom, 10)
                            }

                        }.padding(.top, 10)
                            .onAppear{
                                fetchLOB()
                            }
                    }
                    // ALERT VIEW
                    .alert(item: $alertItem) { alertItem in
                        Alert(title: alertItem.title)
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            
                            HStack {
                                
                                Button(action: {
//                                    self.selectedNavigationLink = "DashboardPage"
                                    
                                    withAnimation {
//                                        navigateInsuranceOptiondPage = false
                                        
                                        navigateDashboardPage = true
                                    }
                                    
                                })
                                {
                                    
                                    Image(systemName: "arrow.backward")
                                        .bold()
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                        .padding(.bottom)
                                    
                                }
                                
                                
                                NavigationLink(destination: DashboardView(navigateOtpPage:.constant(false)), tag: "DashboardPage", selection: $selectedNavigationLink) { EmptyView() }
                                
                                Text("Line of Business")
                                    .bold()
                                    .font(isFontBlack(size: 22))
                                    .foregroundColor(.white)
                                    .padding(.bottom,8)
                            }
                        }
                    }
                    .toolbarBackground(toolbarcolor,for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .navigationBarTitleDisplayMode(.inline)
                    
                }
            }
        }.navigationBarBackButtonHidden(true)
        
            .overlay(
                navigateProductPage ? ProductsView(navigateProductPage: $navigateProductPage) : nil
            )
        
            .overlay(
                navigateDashboardPage ? DashboardView(navigateOtpPage: .constant(false)) : nil
            )
        
            .overlay(
                !networkMonitor.isConnected ? ErrorView() : nil
            )
           
    }
    
    func filteredItems(searchText: String) -> [LobResponse.LobData.LOBValues] {
        if searchText.isEmpty {
            return detailsArray
        } else {
            
            let filteredItems = detailsArray.filter { product in
                return product.pZLOB.lowercased().contains(searchText.lowercased())
            }
            return filteredItems
        }
       
    }

    func fetchLOB(){
        isLoading = true
//        let parameters: [String: Any] = ["functionalClassification" : "26000"]

        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(BaseURL)")!,
                                         path: "api/prodconfig/Quotation/GetAllLOB",
                                         method: "POST",bodyData:[:])
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<LobResponse, Error>) in
            switch result {
            case .success(let model):
                // Handle success
                DispatchQueue.main.async {
                    if model.rcode == 200 {
                        isLoading = false
                        detailsArray = model.rObj.getAllLOB
                        print("detailsArray: \(detailsArray)")
                    } else {
                        isLoading = false
                        
                        if let errorDict = Extensions.getValidationDict() as? [String: String] {
                            if let errorMessage = errorDict["API001"] {
                                self.alertItem = AlertItem(title: Text("API001 \n \(errorMessage.localized())"))
                            }
                        }
                    }
                }
            case .failure(let error):
                // Handle error
                print(error)
                
                   if let errorDict = Extensions.getValidationDict() as? [String: String] {
                       if let errorMessage = errorDict["ERR014"] {
                           self.alertItem = AlertItem(title: Text("ERR014 \n \(errorMessage.localized())"))
                       }
                   }
                isLoading = false
            }
        }

       /*
        let mobileParameters: [String: Any] = ["deviceID": "D450B9D0-C614-4E8E-B058-DD0AE7D8D7FF",
                                                   "deviceLongitude": "77.83072172671355",
                                                   "deviceUserID": "D450B9D0-C614-4E8E-B058-DD0AE7D8D7FF",
                                                   "deviceLatitude": "12.708760360267288",
                                                   "deviceIsJailBroken": false,
                                                   "deviceAppVersion": "1.0.0",
                                                   "deviceTimeZone": "Asia/Kolkata",
                                                   "deviceID2": "",
                                                   "deviceDateTime": "22-Sep-2023 11:51",
                                                   "deviceIpAddress": "169.254.249.214",
                                                   "deviceType": "iOS",
                                                   "deviceVersion": "16.6.1",
                                                   "deviceModel": "iPhone"]
            print("mobileParameters = \(mobileParameters)")
            let url = URL(string: "\(BaseURL)api/digital/core/MasterData/FetchMasterData")!
            print(url)
            let request = NSMutableURLRequest(url: url)
            request.httpMethod = "POST"
            
            var postData : Data
         
            postData = try! JSONSerialization.data(withJSONObject: mobileParameters, options: JSONSerialization.WritingOptions(rawValue: 0))
         
            let theJSONData = (NSString(data: postData, encoding: String.Encoding.utf8.rawValue)! as String).replacingOccurrences(of: "%20", with: " ")
            
            let authToken:String! = "Bearer " + Extensions.token
            print(authToken)
            request.addValue("\(theJSONData)", forHTTPHeaderField: "clientInfo")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue(authToken, forHTTPHeaderField: "Authorization")
            request.addValue("D450B9D0-C614-4E8E-B058-DD0AE7D8D7FF", forHTTPHeaderField: "fingerprint")
         
            
            
          
            
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters,options: .fragmentsAllowed) else {
            return
            }
            
            request.httpBody = httpBody
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let data = data else {
                print("Error No data returned from server \(error?.localizedDescription ?? "")")
                return
            }
            
            do {
                
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(ApiResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        if response.rcode == 200 {
                            isLoading = false
                            detailsArray = response.rObj.fetchMasterData
                            print("detailsArray: \(detailsArray)")
                        } else if response.rcode == 401 {
                            self.alertItem = AlertItem(title: Text(response.rmsg.first?.errorText ?? ""))
                            isLoading = false
                            
                        }
                    }
            } catch {
                isLoading = false
                print("Error decoding JSON: \(error)")
            }

        }
        task.resume()
        */
    }
       

}

struct InsuranceOptionView_Previews: PreviewProvider {
    static var previews: some View {
        LineOfBusinessView(navigateInsuranceOptiondPage:.constant(false))
    }
}

