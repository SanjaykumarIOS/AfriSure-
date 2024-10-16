//
//  GeneratePolicy.swift
//  AfriSure
//
//  Created by SANJAY  on 17/01/24.
//

import SwiftUI

var assetsLabelName = ""

struct GeneratePolicy: View {
    
    @Binding var isOverlayVisible: Bool
    
    @State var showAssessmentsOverlay = false
    @State var fullName = ""
    @State var accountStatus = ""
    @State var lobName = ""
    @State var sQuotationTotalAmount = ""
    @State var quotationExpiryDate = ""
    @State var productName = ""
    @State var sourceQuotation = ""
    
    @State var selectedPolicy = ""
        
    @State private var generatePolicyArray: [GeneratePolicyResponseData.GeneratePolicyRObject.MenuDetails.MenuItem] = []
    
    @State var navigateQuoteInfoPage = false
    @State var navigateProposalInfoPage = false
    @State var showAssetsOverlay = false
    @State var navigateAssetsNewPersonPage = false
    
    @State var navigateAssetsInfoPage = false
    @State var navigateAddonExcessPage = false
        
    @State var navigateRiskAdjustmentsPage = false
    
    @State var navigateProposalFormPage = false
    
    @State private var alertItem: AlertItem?
    @State private var isLoading = false
    
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some View {
        NavigationStack {
            LoadingView(isShowing: $isLoading) {
                VStack {

                    ScrollView(showsIndicators: false) {
                        VStack {
                    
                    VStack(spacing:3) {
                        
                        
                        HStack(alignment:.top,spacing:3) {
                            VStack(alignment:.center,spacing: 5) {
                                Text("Customer")
                                    .font(isFontMedium(size: 17))
                                
                                Text(fullName)
                                    .font(isFontMedium(size: 17))
                                    .foregroundColor(inkBlueColour)
                                    .foregroundColor(.black.opacity(0.7))
                                    .lineLimit(0)
                                
                            }
                            .padding(5)
                            .frame(width: 180)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            
                            
                            
                            VStack(alignment:.center,spacing: 5) {
                                Text("KYC Status")
                                    .font(isFontMedium(size: 17))
                                
                                Text(accountStatus)
                                    .font(isFontMedium(size: 17))
                                    .foregroundColor(inkBlueColour)
                                    .foregroundColor(.black.opacity(0.7))
                                    .lineLimit(0)
                                
                            }
                            .padding(5)
                            .frame(width: 180)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            
                        }
                        
                        HStack(alignment:.top,spacing:3) {
                            VStack(alignment:.center,spacing: 5) {
                                Text("Line of Business")
                                    .font(isFontMedium(size: 17))
                                
                                Text(lobName)
                                    .font(isFontMedium(size: 17))
                                    .foregroundColor(inkBlueColour)
                                    .foregroundColor(.black.opacity(0.7))
                                    .lineLimit(0)
                                
                                
                            }
                            .padding(5)
                            .frame(width: 180)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            
                            
                            
                            VStack(alignment:.center,spacing: 5) {
                                Text("Quote")
                                    .font(isFontMedium(size: 17))
                                
                                Text(sQuotationTotalAmount)
                                    .font(isFontMedium(size: 17))
                                    .foregroundColor(inkBlueColour)
                                    .foregroundColor(.black.opacity(0.7))
                                    .lineLimit(0)
                                
                            }
                            .padding(5)
                            .frame(width: 180)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            
                        }
                       
                        
                        HStack(alignment:.top,spacing:3) {
                            VStack(alignment:.center,spacing: 5) {
                                Text("Valid Till")
                                    .font(isFontMedium(size: 17))
                                
                                Text(quotationExpiryDate)
                                    .font(isFontMedium(size: 17))
                                    .foregroundColor(inkBlueColour)
                                    .foregroundColor(.black.opacity(0.7))
                                    .lineLimit(0)
                            }
                            .padding(5)
                            .frame(width: 180)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            
                            
                            
                            VStack(alignment:.center,spacing: 5) {
                               
                                Text("Product")
                                    .font(isFontMedium(size: 17))
                                
                                Text(productName)
                                    .font(isFontMedium(size: 17))
                                    .foregroundColor(inkBlueColour)
                                    .foregroundColor(.black.opacity(0.7))
                                    .lineLimit(0)
                            }
                            .padding(5)
                            .frame(width: 180)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            
                        }
                        
                        HStack(alignment:.top,spacing:3) {
                            VStack(alignment:.center,spacing: 5) {
                                Text("Source")
                                    .font(isFontMedium(size: 17))
                                
                                Text(sourceQuotation)
                                    .font(isFontMedium(size: 17))
                                    .foregroundColor(inkBlueColour)
                                    .foregroundColor(.black.opacity(0.7))
                                    .lineLimit(0)
                            }
                            .padding(5)
                            .frame(width: 180)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .frame(maxWidth: .infinity, alignment:.leading)
                            .padding(.leading,12)
                            
                        }
                    }
                    .padding(.top)
                   
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 130))], spacing: 13) {
                               
                                    ForEach(generatePolicyArray, id: \.label) { value in
                                        
                                        VStack {
                                            
                                            Button(action:{
                                                let child = value.children
                                                
                                               
                                                if value.label == "Quote Info" {
                                                    withAnimation {
                                                        navigateQuoteInfoPage = true
                                                    }
                                                }
                                                
                                                if value.label == "Proposal Info" {
                                                    withAnimation {
                                                        navigateProposalInfoPage = true
                                                    }
                                                }
                                                
                                                if value.label == "Assets" {
                                                    withAnimation {
                                                        showAssetsOverlay = true
                                                    }
                                                }
                                                
                                                
                                                if value.label == "Assessments" && !(child?.isEmpty ?? false) {
                                                    withAnimation {
                                                        showAssessmentsOverlay = true
                                                    }
                                                }
                                                
                                                
                                                if value.label == "Addons and Excess" {
                                                    withAnimation {
                                                        navigateAddonExcessPage = true
                                                    }
                                                }
                                                
                                                if value.label == "Risk Adjustments" {
                                                    withAnimation {
                                                        navigateRiskAdjustmentsPage = true
                                                    }
                                                }
                                                
                                                selectedPolicy = value.label
                                                
                                            }) {
                                                
                                                ZStack {
                                                    Color.white
                                                    
                                                    Text(value.label)
                                                        .font(isFontMedium(size: 18))
                                                        .foregroundColor(.black)
                                                        .padding(.trailing,10)
                                                        .padding(.leading,10)
                                                }
                                                .frame(width: 160, height: 115)
                                                .cornerRadius(10)
                                                .shadow(radius: 3)
                                                .overlay {
                                                    ZStack {
                                                        if value.isCompleted {
                                                            Image(systemName: "checkmark.circle.fill")
                                                                .font(isFontMedium(size: 25))
                                                                .foregroundColor(.green)
                                                                .padding(.bottom,70)
                                                                .padding(.leading,120)
                                                        } else {
                                                            Image(systemName: "exclamationmark.circle.fill")
                                                                .font(isFontMedium(size: 25))
                                                                .foregroundColor(.red)
                                                                .padding(.bottom,70)
                                                                .padding(.leading,120)
                                                        }
                                                    }
                                                }
                                                
                                            }
                                           
                                        }
                                        .padding(.top,10)
                                    }
                                    
//                                if showPolicyConfirmation {
//                                    Button(action: {
//
//                                    }) {
//
//                                        ZStack {
//                                            Color.white
//                                            Text("Policy Confirmation")
//                                                .bold()
//                                                .font(isFontMedium(size: 18))
//                                                .foregroundColor(.black)
//
//                                        }
//                                        .frame(width: 170, height: 130)
//                                        .cornerRadius(10)
//                                        .shadow(radius: 3)
//                                        .padding(.top,10)
//                                        .overlay {
//                                            ZStack {
//                                                Image(systemName: "checkmark.circle.fill")
//                                                    .font(isFontMedium(size: 25))
//                                                    .foregroundColor(.green)
//                                                    .padding(.bottom,80)
//                                                    .padding(.leading,130)
//                                            }
//                                        }
//                                    }
//                                }
                              
                                
                            }.padding(.horizontal)
                            
//                            NavigationLink("", destination: QuoteInfo(), isActive: $navigateQuoteInfoPage)
//                            NavigationLink("", destination: ProposalInfo(), isActive: $navigateProposalInfoPage)
//                            NavigationLink("", destination: AssetsNewPerson(), isActive: $navigateAssetsNewPersonPage)
//                            NavigationLink("", destination: RiskAdjustments(), isActive: $navigateRiskAdjustmentsPage)
                            
//                            NavigationLink("", destination: AssetsInfo(), isActive: $navigateAssetsInfoPage)
//                            NavigationLink("", destination: AddonsandExces(), isActive: $navigateAddonExcessPage)

                        }
                    }
                   
                    
                    
                }
                .onAppear {
                    fetchGeneratePolicy()
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
//                                navigateProposalFormPage = true
                                withAnimation {
                                    isOverlayVisible = false
                                }
                            })
                            {
                                
                                Image(systemName: "arrow.backward")
                                    .bold()
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .padding(.bottom)
                                
                            }
                            
                            Text("Policy Generate Details")
                                .bold()
                                .font(isFontBlack(size: 22))
                                .foregroundColor(.white)
                                .padding(.bottom,8)
                            
//                            NavigationLink("", destination: ProposalForms(), isActive: $navigateProposalFormPage)

                            
                        }
                    }
                }
                .toolbarBackground(toolbarcolor,for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)

                
            }
        }.navigationBarBackButtonHidden()
        
            .overlay (
                navigateProposalInfoPage ? ProposalInfo(navigateProposalInfoPage: $navigateProposalInfoPage) : nil
            )
            .overlay(
                navigateQuoteInfoPage ? QuoteInfo(navigateQuoteInfoPage: $navigateQuoteInfoPage) : nil
            )
        
            .overlay(
                navigateAssetsInfoPage ? AssetsInfo(navigateAssetsInfoPage: $navigateAssetsInfoPage) : nil
            )
            .overlay(
                navigateAssetsNewPersonPage ? AssetsNewPerson(navigateAssetsNewPersonPage: $navigateAssetsNewPersonPage) : nil
            )
            .overlay(
                navigateAddonExcessPage ? AddonsandExces(navigateAddonExcessPage: $navigateAddonExcessPage) : nil
            )
            .overlay(
                navigateRiskAdjustmentsPage ? RiskAdjustments(navigateRiskAdjustmentsPage: $navigateRiskAdjustmentsPage) : nil
            )
        
            .overlay(
                !networkMonitor.isConnected ? ErrorView() : nil
            )
        
        
            .overlay {
                if showAssetsOverlay {
                    ZStack {
                        Color.black.opacity(0.3)
                            .ignoresSafeArea()
                            .onTapGesture {
                                showAssetsOverlay = false
                            }
                        
                        ZStack {
                            Color.white
                            VStack {
                                HStack {
                                    Image(systemName: "multiply")
                                        .foregroundColor(.white)
                                        .font(.system(size: 22))
                                        .bold()
                                        .padding(.leading)
                                        .onTapGesture {
                                            showAssetsOverlay = false
                                        }
                                    
                                    Spacer()
                                    
                                    Text("Assets")
                                        .foregroundColor(.white)
                                        .font(isFontMedium(size: 20))
                                        .padding(.trailing)
                                    
                                    Spacer()
                                }
                                .frame(width:350,height:50)
                                .background(fontOrangeColour)
                                
                                ScrollView(showsIndicators: false) {
                                    VStack {
                                        ForEach(generatePolicyArray, id: \.label) { menuItem in
                                            
                                            if selectedPolicy == menuItem.label {
                                            
                                                if let children = menuItem.children {
                                                    ForEach(children ,id: \.label) { value in
                                                        
                                                        Button(action: {
                                                            if value.isCreate == true && value.isNew == true {
                                                                assetsTypeId = value.id ?? ""
                                                                navigateAssetsNewPersonPage = true
                                                            }
                                                            
                                                            if value.isCompleted == true {
                                                                assetsTypeId = value.id ?? ""
                                                                navigateAssetsInfoPage = true
                                                                assetsLabelName = value.label
                                                            }
                                                            
                                                            showAssetsOverlay = false
                                                            
                                                        })
                                                        {
                                                            HStack(alignment:.top) {
                                                                if value.isCreate == true && value.isNew == true {
                                                                    Text(value.label)
                                                                        .font(isFontMedium(size: 20))
                                                                        .foregroundColor(.black)
                                                                        .padding(.leading)
                                                                    
                                                                    Spacer()
                                                                    
                                                                    Image(systemName: "plus")
                                                                        .font(isFontMedium(size: 23))
                                                                        .bold()
                                                                        .padding(.trailing)
                                                                        .foregroundColor(fontOrangeColour)
                                                                    
                                                                } else {
                                                                    HStack(alignment:.top) {
                                                                        Image(systemName: "checkmark.circle.fill")
                                                                            .font(isFontMedium(size: 25))
                                                                            .foregroundColor(.green)
                                                                        
                                                                        Text(value.label)
                                                                            .font(isFontMedium(size: 20))
                                                                            .multilineTextAlignment(.leading)
                                                                            .foregroundColor(.black)
                                                                        
                                                                        Spacer()
                                                                    }
                                                                    
                                                                }
                                                                
                                                            }
                                                            .padding()
                                                            .frame(width:320)
                                                            .background(Color.white)
                                                            .cornerRadius(8)
                                                            .shadow(radius: 2)
                                                            .padding(5)
                                                            
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        
                                    }
                                }
                                
                            }
                        }
                        .frame(width:350, height: 350)
                        .cornerRadius(8)
                    }
                }
                
                
                if showAssessmentsOverlay {
                    ZStack {
                        Color.black.opacity(0.3)
                            .ignoresSafeArea()
                            .onTapGesture {
                                showAssessmentsOverlay = false
                            }
                        
                        ZStack {
                            Color.white
                            VStack {
                                HStack {
                                    Image(systemName: "multiply")
                                        .foregroundColor(.white)
                                        .font(.system(size: 22))
                                        .bold()
                                        .padding(.leading)
                                        .onTapGesture {
                                            showAssessmentsOverlay = false
                                        }
                                    
                                    Spacer()
                                    
                                    Text("Assessments")
                                        .foregroundColor(.white)
                                        .font(isFontMedium(size: 20))
                                        .padding(.trailing)
                                    
                                    Spacer()
                                }
                                .frame(width:350,height:50)
                                .background(fontOrangeColour)
                                
                                ScrollView(showsIndicators: false) {
                                    VStack {
                                        ForEach(generatePolicyArray, id: \.label) { menuItem in
                                            
                                            if selectedPolicy == menuItem.label {
                                                
                                                if let children = menuItem.children {
                                                    ForEach(children ,id: \.label) { value in
                                                        
                                                        Button(action: {
                                                            
                                                            showAssessmentsOverlay = false
                                                            
                                                        })
                                                        {
                                                            VStack(alignment:.leading) {
                                                                
                                                                Text(value.label)
                                                                    .font(isFontMedium(size: 20))
                                                                    .foregroundColor(.black)
                                                                    .multilineTextAlignment(.leading)
                                                                    .frame(maxWidth:.infinity, alignment:.leading)
                                                                    .fixedSize(horizontal: false, vertical: true)
                                                                
                                                                Spacer()
                                                                
                                                            }
                                                            .padding()
                                                            .frame(width:320)
                                                            .fixedSize(horizontal: false, vertical: true)
                                                            .background(Color.white)
                                                            .cornerRadius(8)
                                                            .shadow(radius: 2)
                                                            .padding(5)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        
                                    }
                                }
                                
                            }
                        }
                        .frame(width:350, height: 400)
                        .cornerRadius(8)
                    }
                }
            }
        
    }
    
    
    func fetchGeneratePolicy() {
        
        isLoading = true
        
        let parameters: [String: Any] = [
            "policyID":Extensions.policyID
            ]

        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(BaseURL)")!,
                                         path: "api/digital/core/Policy/GetUnderwritingScreenMenu",
                                         method: "POST",bodyData:parameters)
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<GeneratePolicyResponseData, Error>) in
            switch result {
            case .success(let Response):
                // Handle success
                DispatchQueue.main.async {
                    
                    if Response.rcode == 200 {
                        print(Response.rcode)
                        
                        generatePolicyArray = Response.rObj.menuDetails.menuItems
                        
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
        
        
//        
//        isLoading = true
//        let url = URL(string: "\(BaseURL)api/digital/core/Policy/GetUnderwritingScreenMenu")!
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
//                print("Generate Policy Response = \(String(describing: resultDictionary))")
//                
//                let decoder = JSONDecoder()
//                let Response = try decoder.decode(GeneratePolicyResponseData.self, from: data)
//                
//                DispatchQueue.main.async {
//                    
//                    if Response.rcode == 200 {
//                        print(Response.rcode)
//                        
//                        generatePolicyArray = Response.rObj.menuDetails.menuItems
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
                        
                        fullName = Response.rObj.getQuotationByPolicyID.fullName
                         accountStatus = Response.rObj.getQuotationByPolicyID.accountStatus
                       lobName = Response.rObj.getQuotationByPolicyID.lobName
                        sQuotationTotalAmount = Response.rObj.getQuotationByPolicyID.sQuotationTotalAmount
                        quotationExpiryDate = Response.rObj.getQuotationByPolicyID.quotationExpiryDate
                         productName = Response.rObj.getQuotationByPolicyID.productName
                        sourceQuotation = Response.rObj.getQuotationByPolicyID.sourceQuotation
                        
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
//                print("Generate Policy Response = \(String(describing: resultDictionary))")
//                
//                let decoder = JSONDecoder()
//                let Response = try decoder.decode(QuoteInfoResponse.self, from: data)
//                
//                DispatchQueue.main.async {
//                    
//                    if Response.rcode == 200 {
//                        print(Response.rcode)
//                        
//                        fullName = Response.rObj.getQuotationByPolicyID.fullName
//                         accountStatus = Response.rObj.getQuotationByPolicyID.accountStatus
//                       lobName = Response.rObj.getQuotationByPolicyID.lobName
//                        sQuotationTotalAmount = Response.rObj.getQuotationByPolicyID.sQuotationTotalAmount
//                        quotationExpiryDate = Response.rObj.getQuotationByPolicyID.quotationExpiryDate
//                         productName = Response.rObj.getQuotationByPolicyID.productName
//                        sourceQuotation = Response.rObj.getQuotationByPolicyID.sourceQuotation
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

struct GeneratePolicy_Previews: PreviewProvider {
    static var previews: some View {
        GeneratePolicy(isOverlayVisible: .constant(false))
    }
}


struct MenuItemView: View {
    let menuItem: GeneratePolicyResponseData.GeneratePolicyRObject.MenuDetails.MenuItem

    var body: some View {
        HStack {
            Image(systemName: menuItem.iconClass)
            Text(menuItem.label)
        }
    }
}
