//
//  QuoteInfo.swift
//  AfriSure
//
//  Created by SANJAY  on 18/01/24.
//

import SwiftUI

struct QuoteInfo: View {
    
    @Binding var navigateQuoteInfoPage: Bool
    
    @State var quoteInfoArray: [QuoteInfoResponse.QuoteInfoObject.QuoteInfoDetails] = []
    
    @State var basePremium = ""
    @State var risk = ""
    @State var discount = ""
    @State var tax = ""
    @State var total = ""
    
    @State var navigateGeneratePolicyPage = false
    
    @State var quoteInfoViewJson = ""
    @State var quoteInfoViewJsonArray: [ViewJsonModel.Field] = []
    
    @State private var alertItem: AlertItem?
    @State private var isLoading = false
    
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some View {
        NavigationStack {
            LoadingView(isShowing: $isLoading) {
                VStack {
                    
                    ScrollView {
                        VStack {
                            ForEach(quoteInfoViewJsonArray, id: \.Key) { field in
                                
                                if !field.Key.hasPrefix("ADDON") {
                                    
                                    let templateOptions = field.templateOptions
                                    Text("\(field.Key) \(templateOptions.disabled ? "*" : "")")
                                        .halfTextColorChange(fullText: "\(field.Key) \(templateOptions.disabled ? "*" : "")", changeText: "*")
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
                                        .disabled(templateOptions.disabled)
                                    
                                }
                                
                                if field.Key.hasPrefix("ADDON") {
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
                                        .disabled(templateOptions.disabled)
                                }
                            }
                            
                            ZStack {
                                Color.white
                                VStack(spacing: 0) {
                                    HStack {
                                        
                                        Text("Policy Premium Breaup")
                                            .foregroundColor(.white)
                                            .font(isFontMedium(size: 20))
                                        
                                    }
                                    .frame(width:350,height:50)
                                    .background(fontOrangeColour)
                                    
                                    VStack(spacing: 0) {
                                        HStack(spacing: 0) {
                                            VStack(spacing: 0) {
                                                
                                                Text("S.No")
                                                    .bold()
                                                    .font(.system(size: 16))
                                                    .foregroundColor(fontOrangeColour)
                                                    .multilineTextAlignment(.center)
                                                    .frame(width: 50, height: 60, alignment: .center)
                                                    .background(Color.gray.opacity(0.2))
                                                
                                                Divider()
                                                    .frame(width:50,height:2)
                                                    .background(Color.white)
                                                
                                            }
                                            
                                            VStack(alignment:.center,spacing: 0) {
                                                Text("Product Category Name")
                                                    .bold()
                                                    .font(.system(size: 16))
                                                    .foregroundColor(fontOrangeColour)
                                                    .multilineTextAlignment(.center)
                                                    .frame(width: 100, height: 60, alignment: .center)
                                                
                                                Divider()
                                                    .frame(width:100,height:1)
                                                    .background(Color.gray.opacity(0.2))
                                            }
                                            
                                            VStack(spacing: 0) {
                                                Text("Custom Text")
                                                    .bold()
                                                    .font(.system(size: 16))
                                                    .foregroundColor(fontOrangeColour)
                                                    .multilineTextAlignment(.center)
                                                    .frame(width: 100, height: 60, alignment: .center)
                                                
                                                Divider()
                                                    .frame(width:100,height:1)
                                                    .background(Color.gray.opacity(0.2))
                                        
                                            }
                                            
                                            VStack(spacing: 0) {
                                                Text("Amount")
                                                    .bold()
                                                    .font(.system(size: 16))
                                                    .foregroundColor(fontOrangeColour)
                                                    .multilineTextAlignment(.center)
                                                    .frame(width: 100, height: 60, alignment: .center)
                                                    .background(Color.gray.opacity(0.2))
                                                
                                                Divider()
                                                    .frame(width:100)
                                            }
                                        }
                                        
                                        ScrollView(showsIndicators:false) {
                                            VStack(spacing:0) {
                                                
                                                
                                                HStack(spacing: 0) {
                                                    
                                                    VStack(alignment: .center, spacing: 0) {
                                                        Text("\("1")")
                                                            .modifier(TextModifier())
                                                            .background(Color.gray.opacity(0.2))
                                                        
                                                        Divider()
                                                            .frame(width: 50, height: 2)
                                                            .background(Color.white)
                                                    }
                                                    .frame(width: 50)
                                                    
                                                    VStack(spacing: 0) {
                                                        Text("\("Base Premium")")
                                                            .modifier(TextModifier())
                                                            .background(Color.white)
                                                        
                                                        Divider()
                                                            .frame(width: 100, height: 1)
                                                            .background(Color.gray.opacity(0.2))
                                                    }
                                                    .frame(width: 100)
                                                    
                                                    VStack(spacing: 0) {
                                                        Text("\("Personal Line Automobile Own damage BP")")
                                                            .modifier(TextModifier())
                                                            .background(Color.white)
                                                        
                                                        Divider()
                                                            .frame(width:100,height:1)
                                                            .background(Color.gray.opacity(0.2))
                                                      
                                                    }
                                                    .frame(width: 100)
                                                    
                                                    VStack(spacing: 0) {
                                                        Text(basePremium)
                                                            .multilineTextAlignment(.center)
                                                            .modifier(TextModifier())
                                                            .background(Color.gray.opacity(0.2))
                                                        
                                                        Divider()
                                                            .frame(width: 100, height: 2)
                                                            .background(Color.white)
                                                    }
                                                    .frame(width: 100)
                                                }
                                                .padding(.leading, 10)
                                                .padding(.trailing, 10)
                                                
                                                
                                                HStack(spacing: 0) {
                                                    
                                                    VStack(alignment: .center, spacing: 0) {
                                                        Text("\("2")")
                                                            .modifier(TextModifier())
                                                            .background(Color.gray.opacity(0.2))
                                                        
                                                        Divider()
                                                            .frame(width: 50, height: 2)
                                                            .background(Color.white)
                                                    }
                                                    .frame(width: 50)
                                                    
                                                    VStack(spacing: 0) {
                                                        Text("\("Risk")")
                                                            .modifier(TextModifier())
                                                            .background(Color.white)
                                                        
                                                        Divider()
                                                            .frame(width: 100, height: 1)
                                                            .background(Color.gray.opacity(0.2))
                                                    }
                                                    .frame(width: 100)
                                                    
                                                    VStack(spacing: 0) {
                                                        Text("\("Duty Free Risk")")
                                                            .modifier(TextModifier())
                                                            .background(Color.white)
                                                        
                                                        Divider()
                                                            .frame(width:100,height:1)
                                                            .background(Color.gray.opacity(0.2))
                                                      
                                                    }
                                                    .frame(width: 100)
                                                    
                                                    VStack(spacing: 0) {
                                                        Text(risk)
                                                            .multilineTextAlignment(.center)
                                                            .modifier(TextModifier())
                                                            .background(Color.gray.opacity(0.2))
                                                        
                                                        Divider()
                                                            .frame(width: 100, height: 2)
                                                            .background(Color.white)
                                                    }
                                                    .frame(width: 100)
                                                }
                                                .padding(.leading, 10)
                                                .padding(.trailing, 10)
                                                
                                                HStack(spacing: 0) {
                                                    
                                                    VStack(alignment: .center, spacing: 0) {
                                                        Text("\("3")")
                                                            .modifier(TextModifier())
                                                            .background(Color.gray.opacity(0.2))
                                                        
                                                        Divider()
                                                            .frame(width: 50, height: 2)
                                                            .background(Color.white)
                                                    }
                                                    .frame(width: 50)
                                                    
                                                    VStack(spacing: 0) {
                                                        Text("\("Discount")")
                                                            .modifier(TextModifier())
                                                            .background(Color.white)
                                                        
                                                        Divider()
                                                            .frame(width: 100, height: 1)
                                                            .background(Color.gray.opacity(0.2))
                                                    }
                                                    .frame(width: 100)
                                                    
                                                    VStack(spacing: 0) {
                                                        Text("\("NCD Discount")")
                                                            .modifier(TextModifier())
                                                            .background(Color.white)
                                                        
                                                        Divider()
                                                            .frame(width:100,height:1)
                                                            .background(Color.gray.opacity(0.2))
                                                      
                                                    }
                                                    .frame(width: 100)
                                                    
                                                    VStack(spacing: 0) {
                                                        Text(discount)
                                                            .multilineTextAlignment(.center)
                                                            .modifier(TextModifier())
                                                            .background(Color.gray.opacity(0.2))
                                                        
                                                        Divider()
                                                            .frame(width: 100, height: 2)
                                                            .background(Color.white)
                                                    }
                                                    .frame(width: 100)
                                                }
                                                .padding(.leading, 10)
                                                .padding(.trailing, 10)
                                                
                                                HStack(spacing: 0) {
                                                    
                                                    VStack(alignment: .center, spacing: 0) {
                                                        Text("\("4")")
                                                            .modifier(TextModifier())
                                                            .background(Color.gray.opacity(0.2))
                                                        
                                                        Divider()
                                                            .frame(width: 50, height: 2)
                                                            .background(Color.white)
                                                    }
                                                    .frame(width: 50)
                                                    
                                                    VStack(spacing: 0) {
                                                        Text("\("Tax")")
                                                            .modifier(TextModifier())
                                                            .background(Color.white)
                                                        
                                                        Divider()
                                                            .frame(width: 100, height: 1)
                                                            .background(Color.gray.opacity(0.2))
                                                    }
                                                    .frame(width: 100)
                                                    
                                                    VStack(spacing: 0) {
                                                        Text("\("Stamp Duty")")
                                                            .modifier(TextModifier())
                                                            .background(Color.white)
                                                        
                                                        Divider()
                                                            .frame(width:100,height:1)
                                                            .background(Color.gray.opacity(0.2))
                                                      
                                                    }
                                                    .frame(width: 100)
                                                    
                                                    VStack(spacing: 0) {
                                                        Text(tax)
                                                            .multilineTextAlignment(.center)
                                                            .modifier(TextModifier())
                                                            .background(Color.gray.opacity(0.2))
                                                        
                                                        Divider()
                                                            .frame(width: 100, height: 2)
                                                            .background(Color.white)
                                                    }
                                                    .frame(width: 100)
                                                }
                                                .padding(.leading, 10)
                                                .padding(.trailing, 10)
                                                
                                                HStack(spacing: 0) {
                                                    
                                                    VStack(alignment: .center, spacing: 0) {
                                                        
                                                        Divider()
                                                            .frame(width: 50, height: 2)
                                                            .modifier(TextModifier())
                                                            .background(Color.white)
                                                    }
                                                    .frame(width: 50)
                                                    
                                                    VStack(spacing: 0) {
                                                      
                                                        Divider()
                                                            .frame(width: 100, height: 1)
                                                            .modifier(TextModifier())
                                                    }
                                                    .frame(width: 100)
                                                    
                                                    VStack(spacing: 0) {
                                                        Text("\("Total")")
                                                            .bold()
                                                            .font(isFontMedium(size: 20))
                                                            .modifier(TextModifier())
                                                            .foregroundColor(inkBlueColour)
                                                      
                                                    }
                                                    .frame(width: 100)
                                                    
                                                    VStack(spacing: 0) {
                                                        Text(total)
                                                            .multilineTextAlignment(.center)
                                                            .bold()
                                                            .font(isFontMedium(size: 18))
                                                            .modifier(TextModifier())
                                                            .background(Color.gray.opacity(0.2))
                                                        
                                                        Divider()
                                                            .frame(width: 100, height: 2)
                                                            .background(Color.white)
                                                    }
                                                    .frame(width: 100)
                                                }
                                                .padding(.leading, 10)
                                                .padding(.trailing, 10)


                                            }
                                        }
                                        
                                    }
                                    
                                }
                            }
                            .frame(width:350)
                            .fixedSize(horizontal: false, vertical: true)
                            .cornerRadius(8)
                            .shadow(radius: 3)
                            .padding(.bottom,10)

                            
                        }.padding(.top)
                    }
                }
                .onAppear {
                    fetchQuoteInfo()
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
                                    navigateQuoteInfoPage = false
                                }
                            })
                            {
                                
                                Image(systemName: "arrow.backward")
                                    .bold()
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .padding(.bottom)
                                
                            }
                            
                            Text("Quote Info")
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
        }.navigationBarBackButtonHidden()
        
            .overlay(
                !networkMonitor.isConnected ? ErrorView() : nil
            )
    }
    
    
    func fetchQuoteInfo() {
        
        isLoading = true
        
        let parameters: [String: Any] = [
            "policyID":Extensions.policyID
            ]

        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(BaseURL)")!,
                                         path: "api/digital/core/Quotation/GetQuotationFormly",
                                         method: "POST",bodyData:parameters)
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<QuoteInfoResponse, Error>) in
            switch result {
            case .success(let Response):
                // Handle success
                DispatchQueue.main.async {
                    
                    if Response.rcode == 200 {
                        print(Response.rcode)
                        
                        basePremium = Response.rObj.getAllQuotationSearchProduct.first?.sBasicPremium ?? ""
                        risk = Response.rObj.getAllQuotationSearchProduct.first?.sRiskPremium ?? ""
                        discount = Response.rObj.getAllQuotationSearchProduct.first?.sDiscountPremium ?? ""
                        tax = Response.rObj.getAllQuotationSearchProduct.first?.sTaxPremium ?? ""
                        total = Response.rObj.getAllQuotationSearchProduct.first?.sTotalPremium ?? ""

                        quoteInfoViewJson = Response.rObj.viewJson ?? ""
                        
                        
                        if let visibilityData = quoteInfoViewJson.data(using: .utf8) {
                            do {
                                let visibilityModel = try JSONDecoder().decode(ViewJsonModel.self, from: visibilityData)
                                quoteInfoViewJsonArray = visibilityModel.filed
                                
                                // Iterate through each field in quoteInfoViewJsonArray
                                for field in quoteInfoViewJsonArray {
                                    // Access properties of Field
                                    print("Key: \(field.Key)")
                                    print("DefaultValue: \(field.defaultValue)")
                                    
                                    // Access properties of TemplateOptions within each Field
                                    let templateOptions = field.templateOptions
                                    print("Label: \(templateOptions.label)")
                                    print("Disabled: \(templateOptions.disabled)")
                                }
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
//        let url = URL(string: "\(BaseURL)api/digital/core/Quotation/GetQuotationFormly")!
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
//        
//        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
//        
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
//                print("GetQuotationFormly Response = \(String(describing: resultDictionary))")
//                
//                let decoder = JSONDecoder()
//                let Response = try decoder.decode(QuoteInfoResponse.self, from: data)
//                
//                DispatchQueue.main.async {
//                    
//                    if Response.rcode == 200 {
//                        print(Response.rcode)
//                        
//                        basePremium = Response.rObj.getAllQuotationSearchProduct.first?.sBasicPremium ?? ""
//                        risk = Response.rObj.getAllQuotationSearchProduct.first?.sRiskPremium ?? ""
//                        discount = Response.rObj.getAllQuotationSearchProduct.first?.sDiscountPremium ?? ""
//                        tax = Response.rObj.getAllQuotationSearchProduct.first?.sTaxPremium ?? ""
//                        total = Response.rObj.getAllQuotationSearchProduct.first?.sTotalPremium ?? ""
//
//                        quoteInfoViewJson = Response.rObj.viewJson ?? ""
//                        
//                        
//                        if let visibilityData = quoteInfoViewJson.data(using: .utf8) {
//                            do {
//                                let visibilityModel = try JSONDecoder().decode(ViewJsonModel.self, from: visibilityData)
//                                quoteInfoViewJsonArray = visibilityModel.filed
//                                
//                                // Iterate through each field in quoteInfoViewJsonArray
//                                for field in quoteInfoViewJsonArray {
//                                    // Access properties of Field
//                                    print("Key: \(field.Key)")
//                                    print("DefaultValue: \(field.defaultValue)")
//                                    
//                                    // Access properties of TemplateOptions within each Field
//                                    let templateOptions = field.templateOptions
//                                    print("Label: \(templateOptions.label)")
//                                    print("Disabled: \(templateOptions.disabled)")
//                                }
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

struct QuoteInfo_Previews: PreviewProvider {
    static var previews: some View {
        QuoteInfo(navigateQuoteInfoPage:.constant(false))
    }
}
