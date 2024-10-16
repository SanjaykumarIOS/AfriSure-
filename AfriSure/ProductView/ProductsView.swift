//
//  ProductsView.swift
//  AfriSure
//
//  Created by iosdevelopment on 08/01/24.
//

import SwiftUI

var selectedProductIds = Set<String>()
var productDetailsArray: [ProductResponse.ProductData.ProductValues] = []
var productArray: [String] = []

struct ProductsView: View {
    
    @Binding var navigateProductPage: Bool
    
    @State private var searchText = ""
    @State private var selectedNavigationLink: String? = nil
    @State private var isLoading = false
    @State private var detailsArray: [ProductResponse.ProductData.ProductValues] = []
    @State private var alertItem: AlertItem?
    @State private var isButtonEnabled = false // Track button enable/disable state
    @State private var navigateUserInformationdPage = false
    @State private var selectedItem = Set<String>()
    
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
                                ForEach(Array(filteredItems(searchText: searchText).enumerated()), id: \.element.productName) { index, item in

                                    VStack {
                                        
                                        VStack(alignment:.leading) {
                                            HStack(alignment:.top) {
                                                Text(item.productName)
                                                    .bold()
                                                    .font(isFontBold(size: 19))
                                                    .foregroundColor(.black)
                                                    .multilineTextAlignment(.leading)
                                                    .padding(.leading)
                                                
                                                Spacer()
                                                
                                                Image(systemName: selectedItem.contains("\(item.productName)") ? "checkmark.square.fill" : "square")
                                                    .bold()
                                                    .font(isFontMedium(size: 20))
                                                    .padding(.trailing)
                                                    .foregroundColor(toolbarcolor)
                                                    .onAppear {
                                                        isButtonEnabled = !selectedItem.isEmpty
                                                    }
                                                
                                            }
                                            
//                                            Text(item.productName)
//                                                .font(isFontMedium(size: 15))
//                                                .padding(.top, 0.5)
//                                                .foregroundColor(.black)
//                                                .padding(.leading)

                                        }
                                        
                                    }
                                    .frame(width: 350, height: 70)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 2)
                                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                    .padding(.bottom, 10)
                                    .onTapGesture {
                                        print("\(item.productName) Pressed")
                                        
                                        isLoading = true
                                        isLoading = false
                                        
                                        if selectedItem.contains("\(item.productName)") {
                                            productArray.removeAll(where: { $0 == item.productName })
                                            
                                            selectedItem.remove("\(item.productName)")
                                            selectedProductIds.remove("\(item.productID)")
                                        } else {
                                            productArray.append("\(item.productName)")
                                            
                                            selectedItem.insert("\(item.productName)")
                                            selectedProductIds.insert("\(item.productID)")
                                            
                                        }
                                
                                        isButtonEnabled = !selectedItem.isEmpty
                                        
                                    }
                                }
                                
                            }.padding(.top, 10)
                                .onAppear{
                                    callGetAllProductAPI()
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
                                        self.selectedNavigationLink = "InsuranceOptionPage"
                                        Extensions.selectedItem = Set<String>()
                                        selectedProductIds = Set<String>()
                                        
                                        withAnimation {
                                            navigateProductPage = false
                                        }
                                        
                                    })
                                    {
                                        Image(systemName: "arrow.backward")
                                            .bold()
                                            .font(.system(size: 20))
                                            .foregroundColor(.white)
                                            .padding(.bottom)
                                        
                                    }
                                    
//                                    NavigationLink(destination: InsuranceOptionView(), tag: "InsuranceOptionPage", selection: $selectedNavigationLink) { EmptyView() }
                                    
                                    Text("Products")
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
                        
                        VStack {
                        if isButtonEnabled {
//                            NavigationLink("", destination: UserInformationView(), isActive: $navigateUserInformationdPage)

                            Button(action: {
                                withAnimation {
                                    navigateUserInformationdPage = true
                                }
                                
                            }) {
                                Text("NEXT")
                                    .padding(.top)
                                    .frame(maxWidth: .infinity)
                                    .background(toolbarcolor)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .font(isFontBold(size: 20))
                            }
         
                            
                        }
                            
                       
                    }
                        
                    }
                    
                }

            }.navigationBarBackButtonHidden(true)
        
            .overlay(
                navigateUserInformationdPage ? UserInformationView(navigateUserInformationdPage: $navigateUserInformationdPage) : nil
            )
        
            .overlay(
                !networkMonitor.isConnected ? ErrorView() : nil
            )
      


}
    
    func filteredItems(searchText: String) -> [ProductResponse.ProductData.ProductValues] {
        if searchText.isEmpty {
            return detailsArray
        } else {
            
            let filteredItems = detailsArray.filter { product in
                return product.pZLOB.lowercased().contains(searchText.lowercased())
            }
            return filteredItems
        }
       
    }
    
    
func callGetAllProductAPI(){
    
    isLoading = true
    let parameters: [String: Any] = ["pZLOBID": Extensions.lineOfBusinessID]

    let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(BaseURL)")!,
                                     path: "api/prodconfig/Quotation/GetAllProduct",
                                     method: "POST",bodyData:parameters)
    
    APIService.request(endpoint: dynamicEndpoint) { (result: Result<ProductResponse, Error>) in
        switch result {
        case .success(let model):
            // Handle success
            DispatchQueue.main.async {
                if model.rcode == 200 {
                    isLoading = false
                    detailsArray = model.rObj.getAllProduct
                    productDetailsArray = model.rObj.getAllProduct
                   
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
    
    
//        isLoading = true
//        let mobileParameters: [String: Any] = ["deviceID": "D450B9D0-C614-4E8E-B058-DD0AE7D8D7FF",
//                                               "deviceLongitude": "77.83072172671355",
//                                               "deviceUserID": "D450B9D0-C614-4E8E-B058-DD0AE7D8D7FF",
//                                               "deviceLatitude": "12.708760360267288",
//                                               "deviceIsJailBroken": false,
//                                               "deviceAppVersion": "1.0.0",
//                                               "deviceTimeZone": "Asia/Kolkata",
//                                               "deviceID2": "",
//                                               "deviceDateTime": "22-Sep-2023 11:51",
//                                               "deviceIpAddress": "169.254.249.214",
//                                               "deviceType": "iOS",
//                                               "deviceVersion": "16.6.1",
//                                               "deviceModel": "iPhone"]
////        print("mobileParameters = \(mobileParameters)")
//        let url = URL(string: "\(BaseURL)api/digital/core/Product/GetAllProduct")!
//    
//        print(url)
//        let request = NSMutableURLRequest(url: url)
//        request.httpMethod = "POST"
//        
//        var postData : Data
//     
//        postData = try! JSONSerialization.data(withJSONObject: mobileParameters, options: JSONSerialization.WritingOptions(rawValue: 0))
//     
//        let theJSONData = (NSString(data: postData, encoding: String.Encoding.utf8.rawValue)! as String).replacingOccurrences(of: "%20", with: " ")
//        
//        let authToken:String! = "Bearer " + Extensions.token
//        request.addValue("\(theJSONData)", forHTTPHeaderField: "clientInfo")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue(authToken, forHTTPHeaderField: "Authorization")
////        request.addValue("D450B9D0-C614-4E8E-B058-DD0AE7D8D7FF", forHTTPHeaderField: "fingerprint")
//     
//        
//        let parameters: [String: Any] = [  "pageNumber": "1",
//                                       "pageSize": "100",
////                                       "productStatusID":"",
//                                       "lineOfBusinessID": Extensions.lineOfBusinessID]
//                
//        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters,options: .fragmentsAllowed) else {
//        return
//        }
//        
//        request.httpBody = httpBody
//        
//        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
//        guard let data = data else {
//            print("Error No data returned from server \(error?.localizedDescription ?? "")")
//            return
//        }
//        
//        do {
//            var resultDictionary:NSDictionary! = NSDictionary()
//            resultDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
//            print("Quotation Response = \(String(describing: resultDictionary))")
//            
//            let decoder = JSONDecoder()
//            let quotationResponse = try decoder.decode(GetProductResponse.self, from: data)
//            
//            DispatchQueue.main.async {
//                if quotationResponse.rcode == 200 {
//                    detailsArray = quotationResponse.rObj.getAllProduct
//                    print(quotationResponse.rcode)
//                        isLoading = false
//                    
//                                  
//                              } else {
//                                  self.alertItem = AlertItem(title: Text(quotationResponse.rmsg.first?.errorText ?? ""))
//                                  isLoading = false
//                              }
//                              
//                          }
//
//        } catch {
//            isLoading = false
//            print("Error decoding JSON: \(error)")
//        }
//    }
//    task.resume()
}
    


}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView(navigateProductPage: .constant(false))
    }
}
