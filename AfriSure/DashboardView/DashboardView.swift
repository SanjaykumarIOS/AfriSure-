//
//  DashboardView.swift
//  AfriSure
//
//  Created by iosdevelopment on 26/12/23.
//

import SwiftUI
import Foundation

struct DashboardView: View {
    
    @State var index = 0
    @State var curvePos: CGFloat = 0
    @State private var isShowingDetailView = false
    @State private var navigateInsuranceOptiondPage = false
    
//    @State private var detailsArray: [ApiResponse.ROBJ.FetchMasterData] = []
    @State private var detailsArray: [LobResponse.LobData.LOBValues] = []
    
    @State private var showAllItems = false
    private let numberOfItemsToShow = 5
    @State private var navigateProductPage = false
    
    @Binding var navigateOtpPage: Bool
    @State private var showingLogoutAlert = false
    @State var navigateLoginPage = false
    
    @State var showTokenExpiredPopup = false
    
    @State var navigateQuotationHistory = false
    
    @State var showLanguageChangePopup = false
   
    
    @State private var alertItem: AlertItem?
    @State private var isLoading = false
    
    @StateObject var networkMonitor = NetworkMonitor()
//    @State private var detailsArray: [FetchAllModules.LogedinRole] = []
    
    
    

    var body: some View {
        
        NavigationStack {
            LoadingView(isShowing: $isLoading){
                
                ZStack(alignment: .center) {
                    
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
                        Color(.secondarySystemBackground)
                        
                        VStack {
                            VStack {
                                
                                Button(action: {
                                    
                                    withAnimation(.interpolatingSpring) {
                                        navigateQuotationHistory = true
                                    }
                                    
                                }) {
                                    
                                    HStack {
                                        Image(systemName: "plus")
                                            .font(.system(size: 20, weight: .bold))
                                        
                                    }
                                    .foregroundColor(.white)
                                    .padding(.vertical, 20)
                                    .padding(.horizontal, 20)
                                    .background(toolbarcolor)
                                    .cornerRadius(20)
                                    .shadow(radius: 4)
                                    
                                    
                                }
                            }
                            .frame(maxWidth:.infinity,alignment:.trailing)
                            .padding(.trailing,40)
                            
                            
                            HStack(spacing:13) {
                                Spacer()
                                
                                VStack(spacing:5) {
                                    Image(systemName: "house")
                                        .foregroundColor(fontOrangeColour)
                                    Text("Home")
                                        .foregroundColor(fontOrangeColour)
                                        .font(isFontMedium(size: 13))
                                }
                                
                                Spacer()
                                
                                VStack(spacing:5) {
                                    Image(systemName: "ellipsis.message")
                                        .foregroundColor(fontOrangeColour)
                                    Text("My Quotation")
                                        .foregroundColor(fontOrangeColour)
                                        .font(isFontMedium(size: 13))
                                }
                                .onTapGesture {
                                    
                                }
                                
                                Spacer()
                                
                                VStack(spacing:5) {
                                    Image(systemName: "bell")
                                        .foregroundColor(fontOrangeColour)
                                    Text("Notifications")
                                        .foregroundColor(fontOrangeColour)
                                        .font(isFontMedium(size: 13))
                                }
                                
                                Spacer()
                                
                                VStack(spacing:5) {
                                    Image(systemName: "person.crop.circle")
                                        .foregroundColor(fontOrangeColour)
                                    Text("Account")
                                        .foregroundColor(fontOrangeColour)
                                        .font(isFontMedium(size: 13))
                                }
                                
                                Spacer()
                                
                                VStack(spacing:5) {
                                    Image(systemName: "gearshape")
                                        .foregroundColor(fontOrangeColour)
                                    Text("Settings")
                                        .foregroundColor(fontOrangeColour)
                                        .font(isFontMedium(size: 13))
                                }
                                .onTapGesture {
                                    showLanguageChangePopup = true
                                }
                                
                                Spacer()
                            }
                            .frame(width: 400, height:50)
                            .background(Color.white)
                            .padding()
                        }
                        
                        
//                        HStack{
//                            GeometryReader{g in
//                                VStack{
//                                    Button(action: {
//                                        
//                                        withAnimation(.spring()){
//                                            index = 0
//                                            self.curvePos = g.frame(in: .global).midX
//                                        }
//                                    }, label: {
//                                        
//                                        Image("homeGray")
//                                            .renderingMode(.template)
//                                            .resizable()
//                                            .foregroundColor(index == 0 ? toolbarcolor : .gray)
//                                            .frame(width: 28, height: 28)
//                                            .padding(.all, 15)
//                                            .background(Color.white.opacity(index == 0 ? 1 :0).clipShape(Circle()))
//                                            .offset(y: index == 0 ? -35 : 0)
//                                        
//                                    })
//                                }
//                                .frame(width: 43, height: 43)
//                                .onAppear{
//                                    DispatchQueue.main.async {
//                                        self.curvePos = g.frame(in: .global).midX
//                                    }
//                                }
//                                
//                            }
//                            .frame(width: 43, height: 43)
//                            Spacer(minLength: 0)
//                            
//                            GeometryReader{g in
//                                VStack{
//                                    Button(action: {
//                                        withAnimation(.spring()){
//                                            index = 1
//                                            self.curvePos = g.frame(in: .global).midX
//                                            
//                                            navigateQuotationHistory = true
//                                        }
//                                        
//                                    }, label: {
//                                        
//                                        Image("messageGray")
//                                            .renderingMode(.template)
//                                            .resizable()
//                                            .foregroundColor(index == 1 ? toolbarcolor : .gray)
//                                            .frame(width: 28, height: 28)
//                                            .padding(.all, 15)
//                                            .background(Color.white.opacity(index == 1 ? 1 :0).clipShape(Circle()))
//                                            .offset(y: index == 1 ? -35 : 0)
//                                        
//                                    })
//                                }
//                                .frame(width: 43, height: 43)
//                                
//                            }
//                            .frame(width: 43, height: 43)
//                            
//                            Spacer(minLength: 0)
//                            
//                            GeometryReader{g in
//                                VStack{
//                                    Button(action: {
//                                        withAnimation(.spring()){
//                                            index = 2
//                                            self.curvePos = g.frame(in: .global).midX
//                                        }
//                                    }, label: {
//                                        
//                                        Image("exploreGray")
//                                            .renderingMode(.template)
//                                            .resizable()
//                                            .foregroundColor(index == 2 ? toolbarcolor : .gray)
//                                            .frame(width: 28, height: 28)
//                                            .padding(.all, 15)
//                                            .background(Color.white.opacity(index == 2 ? 1 :0).clipShape(Circle()))
//                                            .offset(y: index == 2 ? -35 : 0)
//                                        
//                                    })
//                                }
//                                .frame(width: 43, height: 43)
//                            }
//                            .frame(width: 43, height: 43)
//                            
//                            Spacer(minLength: 0)
//                            
//                            GeometryReader{g in
//                                VStack{
//                                    Button(action: {
//                                        withAnimation(.spring()){
//                                            index = 3
//                                            self.curvePos = g.frame(in: .global).midX
//                                        }
//                                    }, label: {
//                                        
//                                        Image("notificationGray")
//                                            .renderingMode(.template)
//                                            .resizable()
//                                            .foregroundColor(index == 3 ? toolbarcolor : .gray)
//                                            .frame(width: 28, height: 28)
//                                            .padding(.all, 15)
//                                            .background(Color.white.opacity(index == 3 ? 1 :0).clipShape(Circle()))
//                                            .offset(y: index == 3 ? -35 : 0)
//                                        
//                                    })
//                                }
//                                .frame(width: 43, height: 43)
//                            }
//                            .frame(width: 43, height: 43)
//                            Spacer(minLength: 0)
//                            
//                            GeometryReader{g in
//                                VStack{
//                                    Button(action: {
//                                        isShowingDetailView = true
//                                        withAnimation(.spring()){
//                                            index = 4
//                                            self.curvePos = g.frame(in: .global).midX
//                                        }
//                                        
//                                    }, label: {
//                                        
//                                        Image("userGray")
//                                            .renderingMode(.template)
//                                            .resizable()
//                                            .foregroundColor(index == 4 ? toolbarcolor : .gray)
//                                            .frame(width: 28, height: 28)
//                                            .padding(.all, 15)
//                                            .background(Color.white.opacity(index == 4 ? 1 :0).clipShape(Circle()))
//                                            .offset(y: index == 4 ? -35 : 0)
//                                    })
//                                    //                            NavigationLink("", destination: UserInformationView(), isActive: $isShowingDetailView)
//                                    //                                .opacity(0)
//                                    //                                .background(Color.clear)
//                                    
//                                }
//                                .frame(width: 43, height: 43)
//                            }
//                            .frame(width: 43, height: 43)
//                            Spacer(minLength: 0)
//                            
//                        }
//                        .padding(.horizontal, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 25 :35)
//                        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 8 :UIApplication.shared.windows.first?.safeAreaInsets.bottom)
//                        .padding(.top, 8)
//                        .background(Color.white.clipShape(CShape(curvePos: curvePos)))
//                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                        
                    })
                    .ignoresSafeArea()
                    
                    
                    VStack {
                        
                        ScrollView {
                            VStack() {
                                Text("Line of Business".localized())
                                    .font(isFontMedium(size: 20))
                                    .frame(maxWidth:.infinity, alignment:.leading)
                                    .padding(.leading)
                                    .padding()
                                
                                VStack {
                                    
                                    LazyVGrid(columns: [
                                        GridItem(alignment: .top),
                                        GridItem(alignment: .top),
                                        GridItem(alignment: .top)
                                    ], spacing: 10) {
                                        ForEach(detailsArray.indices.prefix(showAllItems ? detailsArray.count : numberOfItemsToShow), id: \.self) { index in
                                            
                                            Button(action:{
                                                Extensions.lineOfBusinessID = "\(detailsArray[index].pZLOBID)"
                                                
                                                withAnimation {
                                                    navigateProductPage = true
                                                }
                                                
                                                Extensions.selectedLineOfBusiness = "\(detailsArray[index].pZLOB)"
                                                
                                                Extensions.selectedItem = Set<String>()
                                                
                                                productArray = []
                                                
                                                selectedProductIds = Set<String>()
                                            })
                                            {
                                                VStack(spacing:10) {
                                                    HStack(alignment:.top) {
                                                        Image(systemName: "doc.text")
                                                            .resizable()
                                                            .foregroundColor(fontOrangeColour)
                                                            .frame(width: 50, height: 60)
                                                        
                                                    }
                                                    .frame(width: 60, height: 60)
                                                    .padding(8)
                                                    .background(Color.white)
                                                    .cornerRadius(8)
                                                    .shadow(radius: 2)
                                                    
                                                    Text(detailsArray[index].pZLOB)
                                                        .font(isFontMedium(size: 15))
                                                        .foregroundColor(.black)
                                                        .multilineTextAlignment(.center)
                                                        .lineLimit(4)
                                                }
                                            }
                                            
                                        }
                                        
                                        
                                        VStack(alignment:.center) {
                                            
                                            if detailsArray.count > numberOfItemsToShow {
                                                Button(action: {
                                                    withAnimation {
                                                        navigateInsuranceOptiondPage = true
                                                    }
                                                }) {
                                                    
                                                    VStack {
                                                        Image(systemName: "chevron.right.circle.fill")
                                                            .resizable()
                                                            .foregroundColor(fontOrangeColour)
                                                            .frame(width: 60, height: 60)
                                                            .padding(8)
                                                            .background(Color.white)
                                                            .cornerRadius(8)
                                                            .shadow(radius: 2)
                                                        
                                                        Text("View more")
                                                            .font(.subheadline)
                                                            .foregroundColor(.black)
                                                            .multilineTextAlignment(.center)
                                                    }
                                                }
                                            }
                                            
                                        }
                                        
                                        
                                    }
                                    .padding()
                                    
                                }
                                .frame(width:350,height:320)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                                
                            }
                            .padding(.top,200)
                        }
                        
                        
                    
                    }
                    .onAppear{
                        fetchLOB()
                        callFetchAllModulesforLogedinRole()
                    }
                    
                    .offset(y: -UIScreen.main.bounds.height / 10) // Adjust the position of the button
                    .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 8 : UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                    // End of button code
                    
                } .edgesIgnoringSafeArea(.all)
                
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            
                            HStack {
                                
                                Image("user-default")
                                
                                VStack(alignment: .leading) {
                                    
                                    Text("Hello Saranya,".localized())
                                        .font(isFontMedium(size: 16))
                                        .foregroundColor(.black)
                                    
                                    Text("saranya@swiftant.com")
                                        .font(isFontMedium(size: 15))
                                        .foregroundColor(inkBlueColour)
                                        .padding(.top, 0.5)
                                    
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 5)
                                
                                //                            NavigationLink("",destination: LoginPage(),isActive: $navigateLoginPage)
                                
                            }
                            
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            
                            Button(action: {
                                showingLogoutAlert = true
                            }, label: {
                                //                            Image("logout")
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .resizable()
                                    .frame(width:30, height: 30)
                                    .foregroundColor(fontOrangeColour)
                                    .padding(8)
                                    .background(Color.white)
                                    .cornerRadius(6)
                                    .shadow(radius: 1)
                                    .rotationEffect(Angle(degrees: 180))
                                
                                
                            })
                            
                            .alert(isPresented: $showingLogoutAlert) {
                                Alert(
                                    title: Text("Logout"),
                                    message: Text("Are you sure you want to logout?"),
                                    primaryButton: .default(Text("Yes")) {
                                        
                                        navigateLoginPage = true
                                       
                                        showingLogoutAlert = false
                                        
                                    },
                                    secondaryButton: .cancel(Text("No")) {
                                        showingLogoutAlert = false
                                    }
                                    
                                )
                            }
                            
                            
                        }
                        
                    }
            }
            
        }.navigationBarBackButtonHidden(true)
        
            .overlay {
                navigateInsuranceOptiondPage ? LineOfBusinessView(navigateInsuranceOptiondPage: $navigateInsuranceOptiondPage) : nil
                
                navigateQuotationHistory ? QuotationHistory(navigateQuotationHistory: $navigateQuotationHistory) : nil
            }
            
            .overlay {
                navigateProductPage ? ProductsView(navigateProductPage: $navigateProductPage) : nil
                
                navigateLoginPage ? LoginPage() : nil
                
                !networkMonitor.isConnected ? ErrorView() : nil
            }
        
            .overlay {
                if showTokenExpiredPopup {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea(.all)
                       
                    VStack {
                        Text("Your session has been expired. Please login again to continue")
                            .font(isFontMedium(size: 18))
                        
                        Text("OK")
                            .font(isFontMedium(size: 18))
                            .foregroundColor(fontOrangeColour)
                            .padding(10)
                            .frame(maxWidth:.infinity, alignment:.trailing)
                            .onTapGesture {
                                navigateLoginPage = true
                                showTokenExpiredPopup = false
                                
                            }
                        
                    }
                    .frame(width:320)
                    .padding()
                    .background(Color.white)
                }
                
                if showLanguageChangePopup {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea(.all)
                        .onTapGesture {
                            showLanguageChangePopup = false
                        }
                    
                    ZStack {
                        Color(.secondarySystemBackground)
                        
                        VStack {
                            VStack {
                                HStack(spacing:10) {
                                    Image(systemName: "arrow.backward")
                                        .font(isFontMedium(size: 25))
                                        .foregroundColor(.white)
                                        .padding(.leading)
                                        .onTapGesture {
                                            showLanguageChangePopup = false
                                        }
                                    
                                    Text("Select your language")
                                        .font(isFontMedium(size: 20))
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                }
                                .frame(width:300,height:50)
                                .background(fontOrangeColour)
                                
                                Spacer()
                                
                            }
                            
                            VStack(spacing:13) {
                                Text("English")
                                    .font(isFontMedium(size: 18))
                                    .frame(maxWidth :.infinity,alignment:.leading)
                                    .padding(.leading)
                                    .frame(width:250,height:50)
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .overlay {
                                        if Extensions.selectedLanguage == "en" {
                                            Image(systemName: "checkmark")
                                                .font(isFontMedium(size: 25))
                                                .bold()
                                                .foregroundColor(fontOrangeColour)
                                                .frame(maxWidth :.infinity,alignment:.trailing)
                                                .padding(.trailing)
                                        }
                                    }
                                    .onTapGesture {
                                        showLanguageChangePopup = false
                                        Extensions.selectedLanguage = "en"
                                    }
                                
                                Text("Amharic")
                                    .font(isFontMedium(size: 18))
                                    .frame(maxWidth :.infinity,alignment:.leading)
                                    .padding(.leading)
                                    .frame(width:250,height:50)
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .overlay {
                                        if Extensions.selectedLanguage == "am" {
                                            Image(systemName: "checkmark")
                                                .font(isFontMedium(size: 25))
                                                .bold()
                                                .foregroundColor(fontOrangeColour)
                                                .frame(maxWidth :.infinity,alignment:.trailing)
                                                .padding(.trailing)
                                        }
                                    }
                                    .onTapGesture {
                                        showLanguageChangePopup = false
                                        Extensions.selectedLanguage = "am"
                                    }
                            }
                            .padding(.bottom,20)
                        }
                        
                        
                    }
                    .frame(width:300,height:200)
                    .cornerRadius(10)
                }
            }
        
        
    }
    
    func fetchLOB() {
        isLoading = true
//        let parameters: [String: Any] = ["functionalClassification" : 26000]
        
        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(BaseURL)")!,
                                         path: "api/prodconfig/Quotation/GetAllLOB",
                                         method: "POST",
                                         bodyData: [:])
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<LobResponse, Error>) in
            switch result {
            case .success(let model):
                // Handle success
                DispatchQueue.main.async {
                    if model.rcode == 200 {
                        isLoading = false
                        detailsArray = model.rObj.getAllLOB
                    } else if model.rcode == 401 {
                        isLoading = false
                        showTokenExpiredPopup = true
                    } else {
                        isLoading = false
                        
                        if let errorDict = Extensions.getValidationDict() as? [String: String] {
                            if let errorMessage = errorDict["API001"] {
                                self.alertItem = AlertItem(title: Text("API001 \n \(errorMessage)"))
                            }
                        }
                    }
                }
                
            case .failure(let error):
                // Handle error
                print(error)
                
                   if let errorDict = Extensions.getValidationDict() as? [String: String] {
                       if let errorMessage = errorDict["ERR014"] {
                           self.alertItem = AlertItem(title: Text("ERR014 \n \(errorMessage)"))
                       }
                   }
                isLoading = false
            }
        }
    }
    
    
    func callFetchAllModulesforLogedinRole() {
        
        isLoading = true

        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(loginBaseURL)")!,
                                         path: "api/digital/core/Module/FetchAllModulesforLogedinRole",
                                         method: "POST", bodyData: [:])
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<FetchAllModulesforLogedinRoleResponse, Error>) in
            switch result {
            case .success(let model):
                // Handle success
                DispatchQueue.main.async {
                    if model.rcode == 200 {
                        
                        let components = model.rObj.userDetails.fullName.components(separatedBy: " ")
                        if let firstName = components.first {
                            print(firstName)
                            Extensions.userName = firstName
                        } else {
                            print("Error: Full name does not contain a space.")
                        }

                        
                        Extensions.emailID = model.rObj.userDetails.emailID
                        
                        isLoading = false
                    } else if model.rcode == 401 {
                        showTokenExpiredPopup = true
                        isLoading = false
                    } else {
                        isLoading = false
                        
                        if let errorDict = Extensions.getValidationDict() as? [String: String] {
                            if let errorMessage = errorDict["API001"] {
                                self.alertItem = AlertItem(title: Text("API001 \n \(errorMessage)"))
                            }
                        }
                    }
                }
            case .failure(let error):
                // Handle error
                print(error)
                showTokenExpiredPopup = true
                
                   if let errorDict = Extensions.getValidationDict() as? [String: String] {
                       if let errorMessage = errorDict["ERR014"] {
                           self.alertItem = AlertItem(title: Text("ERR014 \n \(errorMessage)"))
                       }
                   }
                isLoading = false
            }
        }
        
        
        
//        isLoading = true
//      
//        let url = URL(string: "\(BaseURL)api/digital/core/Module/FetchAllModulesforLogedinRole")!
//        print(url)
//        let request = NSMutableURLRequest(url: url)
//        request.httpMethod = "POST"
//       
//        let authToken:String! = "Bearer " + Extensions.token
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue(authToken, forHTTPHeaderField: "Authorization")
//        
//        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
//            guard let data = data else {
//                print("\("Error No data returned from server") \(error?.localizedDescription ?? "")")
//                return
//            }
//            do {
//                
//                var resultDictionary:NSDictionary! = NSDictionary()
//                resultDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
//                print("FetchAllModulesforLogedinRoleResponse = \(String(describing: resultDictionary))")
//
////                let loginResponse = try JSONDecoder().decode(FetchAllModulesforLogedinRoleResponse.self, from: data)
//
//                DispatchQueue.main.async {
//                    
//                    let rcode = resultDictionary["rcode"] as? Int
//                    
//                    print(rcode ?? "")
//                    
//                    if rcode == 401 {
//                        showTokenExpiredPopup = true
//                    }
//                  
//                }
//            } catch {
//                print("\("Error decoding response") \(error.localizedDescription)")
//                self.alertItem = AlertItem(title: Text("An unexpected error occurred"))
//                showTokenExpiredPopup = true
//                isLoading = false
//            }
//        }
//        task.resume()
    }
}


struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(navigateOtpPage:.constant(false))
    }
}


struct Home: View {
    @State var index = 0
    @State var curvePos: CGFloat = 0
    @State private var isShowingDetailView = false
    @State private var navigateInsuranceOptiondPage = false
    var body: some View {
        ZStack(alignment: .bottom) {
            // Your other content here

            // Your tab bar and other views here
            
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
                Color(.secondarySystemBackground)
                // TAB BAR...
                HStack{
                    GeometryReader{g in
                        VStack{
                            Button(action: {
                              
                                withAnimation(.spring()){
                                    index = 0
                                    self.curvePos = g.frame(in: .global).midX
                                }
                            }, label: {
                                
                                Image("homeGray")
                                    .renderingMode(.template)
                                    .resizable()
                                    .foregroundColor(index == 0 ? toolbarcolor : .gray)
                                    .frame(width: 28, height: 28)
                                    .padding(.all, 15)
                                    .background(Color.white.opacity(index == 0 ? 1 :0).clipShape(Circle()))
                                    .offset(y: index == 0 ? -35 : 0)
                                
                            })
                        }
                        .frame(width: 43, height: 43)
                        .onAppear{
                            DispatchQueue.main.async {
                                self.curvePos = g.frame(in: .global).midX
                            }
                        }
                        
                    }
                    .frame(width: 43, height: 43)
                    Spacer(minLength: 0)
                    
                    GeometryReader{g in
                        VStack{
                            Button(action: {
                                withAnimation(.spring()){
                                    index = 1
                                    self.curvePos = g.frame(in: .global).midX
                                }
                            }, label: {
                                
                                Image("messageGray")
                                    .renderingMode(.template)
                                    .resizable()
                                    .foregroundColor(index == 1 ? toolbarcolor : .gray)
                                    .frame(width: 28, height: 28)
                                    .padding(.all, 15)
                                    .background(Color.white.opacity(index == 1 ? 1 :0).clipShape(Circle()))
                                    .offset(y: index == 1 ? -35 : 0)
                                
                            })
                        }
                        .frame(width: 43, height: 43)
                        
                    }
                    .frame(width: 43, height: 43)
                    
                    Spacer(minLength: 0)
                    
                    GeometryReader{g in
                        VStack{
                            Button(action: {
                                withAnimation(.spring()){
                                    index = 2
                                    self.curvePos = g.frame(in: .global).midX
                                }
                            }, label: {
                                
                                Image("exploreGray")
                                    .renderingMode(.template)
                                    .resizable()
                                    .foregroundColor(index == 2 ? toolbarcolor : .gray)
                                    .frame(width: 28, height: 28)
                                    .padding(.all, 15)
                                    .background(Color.white.opacity(index == 2 ? 1 :0).clipShape(Circle()))
                                    .offset(y: index == 2 ? -35 : 0)
                                
                            })
                        }
                        .frame(width: 43, height: 43)
                    }
                    .frame(width: 43, height: 43)
                    
                    Spacer(minLength: 0)
                    
                    GeometryReader{g in
                        VStack{
                            Button(action: {
                                withAnimation(.spring()){
                                    index = 3
                                    self.curvePos = g.frame(in: .global).midX
                                }
                            }, label: {
                                
                                Image("notificationGray")
                                    .renderingMode(.template)
                                    .resizable()
                                    .foregroundColor(index == 3 ? toolbarcolor : .gray)
                                    .frame(width: 28, height: 28)
                                    .padding(.all, 15)
                                    .background(Color.white.opacity(index == 3 ? 1 :0).clipShape(Circle()))
                                    .offset(y: index == 3 ? -35 : 0)
                                
                            })
                        }
                        .frame(width: 43, height: 43)
                    }
                    .frame(width: 43, height: 43)
                    Spacer(minLength: 0)
                    
                    GeometryReader{g in
                        VStack{
                            Button(action: {
                                isShowingDetailView = true
                                withAnimation(.spring()){
                                    index = 4
                                    self.curvePos = g.frame(in: .global).midX
                                }
                                
                            }, label: {
                                
                                Image("userGray")
                                    .renderingMode(.template)
                                    .resizable()
                                    .foregroundColor(index == 4 ? toolbarcolor : .gray)
                                    .frame(width: 28, height: 28)
                                    .padding(.all, 15)
                                    .background(Color.white.opacity(index == 4 ? 1 :0).clipShape(Circle()))
                                    .offset(y: index == 4 ? -35 : 0)
                            })
//                            NavigationLink("", destination: UserInformationView(), isActive: $isShowingDetailView)
//                                .opacity(0)
//                                .background(Color.clear)

                        }
                        .frame(width: 43, height: 43)
                    }
                    .frame(width: 43, height: 43)
                    Spacer(minLength: 0)
                    
                }
                .padding(.horizontal, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 25 :35)
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 8 :UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                .padding(.top, 8)
                .background(Color.white.clipShape(CShape(curvePos: curvePos)))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                
                //going to add curve..
                
            })

            // The custom "Buy Policy" button
            Button(action: {
                // Perform the action here
                navigateInsuranceOptiondPage = true
            }) {
                HStack {
                    Image(systemName: "plus") // SF Symbols for the plus sign
                        .font(.system(size: 20, weight: .bold))
                        
                    Text("Get Quotes")
                        .fontWeight(.bold)
                        .font(isFontBlack(size: 20))
                }
               
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(toolbarcolor)
                .cornerRadius(30)
                .shadow(color: Color.orange.opacity(0.3), radius: 10, x: 0, y: 10)
                
//                NavigationLink("",destination: InsuranceOptionView(),isActive: $navigateInsuranceOptiondPage)
            }
           
            .offset(y: -UIScreen.main.bounds.height / 10) // Adjust the position of the button
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 8 : UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            // End of button code

        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct CShape : Shape {
    var curvePos: CGFloat
    
    //animating path..
    
    var animatableData: CGFloat{
        get{ return curvePos}
        set{ curvePos = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
            
            //adding curve....
            path.move(to: CGPoint(x: curvePos + 40, y: 0))
            
            path.addQuadCurve(to: CGPoint(x: curvePos - 40, y: 0), control: CGPoint(x: curvePos, y: 70))
        }
    }
}


