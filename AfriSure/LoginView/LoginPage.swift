


import SwiftUI

struct LoginPage: View {
    
    
    @State private var loginEmail: String = ""
    @State private var loginPassword: String = ""
    @State private var isPasswordSecure = true
    
    @State var organisationList = ["KenIndia","Nyala"]
    @State var organisationField = ""
    @State var showOrganisationLish = false
    @State var organisationHeaderPassing = ""
    
    @State private var navigateOtpPage = false
    @State private var navigateSignupPage = false
    
    @State private var alertItem: AlertItem?
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack {
            LoadingView(isShowing: $isLoading) {
                VStack {
                    
                    ScrollView(showsIndicators: false) {
                        
                        VStack(spacing:10) {
                            
                            ZStack {
                                Color.black.opacity(0.9)
                                Image("primary_logo_reverse")
                                    .resizable()
                                    .frame(width: 180, height: 150)
                                
                            }
                            .frame(width: 260, height: 50)
                            .cornerRadius(20)
                            .padding(.top,30)
                            
                            Text("Sign in")
                                .bold()
                                .font(.system(size: 30))
                                .foregroundColor(fontOrangeColour)
                                .padding(.top,30)
                            
                            VStack(alignment:.leading) {
                                
                                Text("Select your Organisation")
                                    .font(isFontMedium(size: 20))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading,34)
                                    .padding(.top,40)
                                
                                VStack {
                                    TextField("Select", text: $organisationField)
                                        .disabled(true)
                                        .padding()
                                        .frame(height:50)
                                        .padding(.leading)
                                        .padding(.trailing,40)
                                        .foregroundColor(.black)
                                        .font(isFontMedium(size: 18))
                                        .background(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.black, lineWidth: 1)
                                                .frame(width: 320)
                                        )
                                        
                                        .overlay{
                                            
                                            Image(systemName: "chevron.down")
                                                .bold()
                                                .font(.system(size: 22))
                                                .frame(maxWidth: .infinity, alignment:.trailing)
                                                .padding(.trailing,30)
                                            
                                        }
                                        .padding(.horizontal)
                                }
                                .onTapGesture {
                                    showOrganisationLish.toggle()
                                }
                                
                                Text("Email")
                                    .font(isFontMedium(size: 20))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading,35)
                                    .padding(.top,5)
                                
                                TextField("Enter your Email", text: $loginEmail)
                                    .keyboardType(.emailAddress)
                                    .padding()
                                    .frame(height:50)
                                    .padding(.leading)
                                    .foregroundColor(.black)
                                    .font(isFontMedium(size: 18))
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.black, lineWidth: 1)
                                            .frame(width: 320)
                                    )
                                    .padding(.horizontal)
                                
                                
                                Text("Password")
                                    .font(isFontMedium(size: 20))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading,35)
                                    .padding(.top,5)
                                
                                
                                HStack {
                                    if isPasswordSecure {
                                        SecureField("Enter your Password", text: $loginPassword)
                                    } else {
                                        TextField("Enter your Password", text: $loginPassword)
                                    }
                                    
                                    Button(action: {
                                        withAnimation {
                                            isPasswordSecure.toggle()
                                        }
                                    }) {
                                        Image(systemName: isPasswordSecure ? "eye" : "eye.slash" )
                                            .bold()
                                            .foregroundColor(.black)
                                            .padding(.trailing)
                                    }
                                }
                                .padding()
                                .padding(.leading)
                                .foregroundColor(.black)
                                .font(isFontMedium(size: 18))
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black, lineWidth: 1)
                                        .frame(width: 320)
                                )
                                .padding(.horizontal)
                                
                            }
                            .overlay {
                                if showOrganisationLish {
                                    List(organisationList, id:\.self) { item in
                                        Button(action:{
                                            organisationField = item.localized()
                                            showOrganisationLish = false
                                            
                                            if item == "KenIndia" {
                                                organisationHeaderPassing = "6120"
                                            } else {
                                                organisationHeaderPassing = "6130"
                                            }
                                            Extensions.organisationAppID = organisationHeaderPassing

                                        })
                                        {
                                            Section {
                                                Text(item.localized())
                                                    .font(isFontMedium(size: 20))
                                            }
                                        }
                                    }
                                    .listStyle(.plain)
                                    .padding(.top,130)
                                    .frame(width: 330)
                                    .cornerRadius(8)
                                    .shadow(radius: 2)
                                }
                            }
                            
                            VStack {
                                Button(action: {
                                    withAnimation {
                                        LoginAlertView()
                                        
                                        emailValue = loginEmail
                                    }
                                }) {
                                    Text("LOGIN")
                                        .bold()
                                        .font(isFontMedium(size: 22))
                                        .foregroundColor(.white)
                                        .frame(width: 320,height: 50)
                                        .background(fontOrangeColour)
                                        .cornerRadius(10)
                                        .padding(.top,15)
                                    
                                }
                                
//                                NavigationLink("",destination: OtpPage(numberOfFields: 6),isActive: $navigateOtpPage)
//                                NavigationLink("",destination: DashboardView(),isActive: $navigateOtpPage)

                                
                                Button(action: {
                                    withAnimation {
                                        
                                    }
                                }) {
                                    Text("Forgot your password?")
                                        .font(isFontMedium(size: 18))
                                        .padding(.top,30)
                                        .foregroundColor(inkBlueColour)
                                    
                                }
                                
                                HStack {
                                    Divider()
                                        .frame(width: 50,height: 1)
                                        .background(Color(.gray))
                                    
                                    Text("Don't have an account?")
                                        .bold()
                                        .font(isFontMedium(size: 18))
                                    
                                    Divider()
                                        .frame(width: 50,height: 1)
                                        .background(Color(.gray))
                                }
                                .padding(.top,30)
                                
                                
                                Button(action: {
                                    withAnimation {
//                                        navigateSignupPage = true
                                    }
                                }) {
                                    Text("SIGN UP")
                                        .bold()
                                        .foregroundColor(fontOrangeColour)
                                        .background(RoundedRectangle(cornerRadius: 8)
                                            .stroke(fontOrangeColour, lineWidth: 1)
                                            .frame(width: 300,height: 50))
                                        .padding()
                                        .padding(10)
                                        
                                }
                                
                                NavigationLink("",destination: SignupPage(),isActive: $navigateSignupPage)
                            }
                            
                        }
                        
                        
                        
                    }
                }
                
                // ALERT VIEW
                .alert(item: $alertItem) { alertItem in
                    Alert(title: alertItem.title)
                }
            }
        }.navigationBarBackButtonHidden()
        
            .overlay(
                navigateOtpPage ? DashboardView(navigateOtpPage: $navigateOtpPage) : nil
            )
        
    }
    
    func fetchLogin() {
        
        isLoading = true
        let parameters: [String: Any] = [
            "emailID": "\(loginEmail)",
            "password": "\(loginPassword)"
            ]

        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(loginBaseURL)")!,
                                         path: "api/digital/core/Account/Login",
                                         method: "POST",
        bodyData:parameters)
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<LoginResponse, Error>) in
            switch result {
            case .success(let model):
                // Handle success
                DispatchQueue.main.async {
                    if model.rcode == 200 {
                        print(model.rObj?.token as Any)
                        Extensions.token = model.rObj?.token ?? ""
                        navigateOtpPage = true
                        isLoading = false
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
                self.alertItem = AlertItem(title: Text("ERR014 \n Something went wrong".localized()))
                isLoading = false
            }
        }
        
        
        
        /*
        isLoading = true
        let url = URL(string:"\(BaseURL)api/digital/core/Account/Login")!
        print(url)
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(organisationHeaderPassing, forHTTPHeaderField: "orgAppID")

        let parameters: [String: Any] = [
            "emailID": "\(loginEmail)",
            "password": "\(loginPassword)"
            ]
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])

        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let data = data else {
                print("\("Error No data returned from server") \(error?.localizedDescription ?? "")")
                return
            }

            do {
                var resultDictionary:NSDictionary! = NSDictionary()
                resultDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                print("Login Response = \(String(describing: resultDictionary))")

                let decoder = JSONDecoder()
                let loginResponse = try decoder.decode(LoginResponse.self, from: data)

                DispatchQueue.main.async {
                    
                    if loginResponse.rcode == 200 {
                        print(loginResponse.rObj.token)
                        Extensions.token = loginResponse.rObj.token
                        navigateOtpPage = true
                        isLoading = false
                    } else {
                        self.alertItem = AlertItem(title: Text("\(loginResponse.rmsg.first?.errorText ?? "")"))
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
         */
    }
    
    func LoginAlertView() {
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        
        if organisationField.trimmingCharacters(in: .whitespacesAndNewlines).description.isEmpty {
            
            if let errorDict = Extensions.getValidationDict() as? [String: String] {
                if let errorMessage = errorDict["ERR001"] {
                    self.alertItem = AlertItem(title: Text("ERR001 \n \(errorMessage.localized())"))
                }
            }

//            self.alertItem = AlertItem(title: Text("Please select your organisation to continue"))
            return
        } else if loginEmail.trimmingCharacters(in: .whitespacesAndNewlines).description.isEmpty {
            if let errorDict = Extensions.getValidationDict() as? [String: String] {
                if let errorMessage = errorDict["ERR002"] {
                    self.alertItem = AlertItem(title: Text("ERR002 \n \(errorMessage.localized())"))
                }
            }
//            self.alertItem = AlertItem(title: Text("Please enter your email address"))
            return
        } else if (!emailTest.evaluate(with: loginEmail)) {
            if let errorDict = Extensions.getValidationDict() as? [String: String] {
                if let errorMessage = errorDict["ERR003"] {
                    self.alertItem = AlertItem(title: Text("ERR003 \n \(errorMessage.localized())"))
                }
            }
//            self.alertItem = AlertItem(title: Text("Email is not valid"))
            return
        } else if loginPassword.trimmingCharacters(in: .whitespacesAndNewlines).description.isEmpty {
            if let errorDict = Extensions.getValidationDict() as? [String: String] {
                if let errorMessage = errorDict["ERR004"] {
                    self.alertItem = AlertItem(title: Text("ERR004 \n \(errorMessage.localized())"))
                }
            }
//            self.alertItem = AlertItem(title: Text("Please enter your password"))
            return
        } else if loginPassword.count < 7 {
            if let errorDict = Extensions.getValidationDict() as? [String: String] {
                if let errorMessage = errorDict["ERR007"] {
                    self.alertItem = AlertItem(title: Text("ERR007 \n \(errorMessage.localized())"))
                }
            }
//            self.alertItem = AlertItem(title: Text("Please enter your password atleast 7 characters"))
            return
        } else {
           
            fetchLogin()
        }
    }
    
}


