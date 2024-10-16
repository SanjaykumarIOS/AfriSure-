//
//  SignupPage.swift
//  DynamicFileUpload
//
//  Created by SANJAY  on 26/12/23.
//

import SwiftUI

struct SignupPage: View {
    @State private var signupName = ""
    @State private var signupMobile = ""
    @State private var signupEmail: String = ""
    @State private var signupPassword: String = ""
    @State private var isPasswordSecure = true
    @State private var showPasswordStrength = false
    @State private var signupConfirmPassword: String = ""
    @State private var isConfirmPasswordSecure = true
    
    @State private var navigateLoginPage = false
    
    @State private var alertItem: AlertItem?
    
    var passwordStrength: String {
        if signupPassword.count >= 7 &&
            containsLowerCase() &&
            containsUpperCase() &&
            containsNumber() &&
            containsSpecialCharacter() {
            return "Strong"
        } else {
            return "Weak"
        }
    }
    
    var passwordStrength7Character: String {
        if signupPassword.count >= 7  {
            return "Must Contain atleast 7 Character"
        } else {
            return ""
        }
    }
   
    var passwordStrengthLowerCase: String {
        if containsLowerCase() {
            return "Has one lower case letter"
        } else {
            return ""
        }
    }
    
    var passwordStrengthUpperrCase: String {
        if containsUpperCase()  {
            return "Has one upper case letter"
        } else {
            return ""
        }
    }
    
    var passwordStrengthOneNumber: String {
        if containsNumber() {
            return "Has atleast one number"
        }  else {
            return ""
        }
    }
    
    var passwordStrengthSpecialCharacter: String {
        if containsSpecialCharacter() {
            return "Has a special character"
        }  else {
            return ""
        }
    }
    
    
    var body: some View {
        NavigationStack {
            
            Button(action:{
                navigateLoginPage = true
            })
            {
                Image(systemName: "arrow.left")
                    .bold()
                    .font(.system(size: 30))
                    .foregroundColor(fontOrangeColour)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .padding(.bottom)
            }
            
            NavigationLink("",destination: LoginPage(),isActive: $navigateLoginPage)
            
            ScrollView(showsIndicators: false) {
                
                VStack {
                    
                    Text("Sign up")
                        .bold()
                        .font(.system(size: 25))
                        .foregroundColor(fontOrangeColour)
                    
                    Text("Name")
                        .font(isFontMedium(size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading,35)
                        .padding(.top)
                    
                    TextField("Name", text: $signupName)
                        .padding()
                        .padding(.leading)
                        .foregroundColor(.black)
                        .font(isFontMedium(size: 18))
                        .onTapGesture {
                            showPasswordStrength = false
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(textFieldBorderColour, lineWidth: 1)
                                .frame(width: 320)
                        )
                        .padding(.horizontal)
                    
                    Text("Mobile")
                        .font(isFontMedium(size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading,35)
                        .padding(.top,10)
                    
                    TextField("Mobile", text: $signupMobile)
                        .keyboardType(.numberPad)
                        .padding()
                        .padding(.leading)
                        .foregroundColor(.black)
                        .font(isFontMedium(size: 18))
                        .onChange(of: signupMobile) { newValue in
                                if newValue.count > 10 {
                                    signupMobile = String(newValue.prefix(10))
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }
                            }
                        .onTapGesture {
                            showPasswordStrength = false
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(textFieldBorderColour, lineWidth: 1)
                                .frame(width: 320)
                        )
                        .padding(.horizontal)
                    
                    Text("Email")
                        .font(isFontMedium(size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading,35)
                        .padding(.top,10)
                    
                    TextField("Email", text: $signupEmail)
                        .keyboardType(.emailAddress)
                        .padding()
                        .padding(.leading)
                        .foregroundColor(.black)
                        .font(isFontMedium(size: 18))
                        .onTapGesture {
                            showPasswordStrength = false
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(textFieldBorderColour, lineWidth: 1)
                                .frame(width: 320)
                        )
                        .padding(.horizontal)
                    
                    
                    VStack {
                        Text("Password")
                            .font(isFontMedium(size: 20))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading,35)
                            .padding(.top,10)
                        
                        HStack {
                            if isPasswordSecure {
                                SecureField("Password", text: $signupPassword)
                            } else {
                                TextField("Password", text: $signupPassword)
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
                        .onTapGesture {
                            showPasswordStrength = true
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(textFieldBorderColour, lineWidth: 1)
                                .frame(width: 320)
                        )
                        .padding(.horizontal)
                       
                        if showPasswordStrength {
                        HStack {
                            Text("Password Strength:")
                                .foregroundColor(.black)
                                .font(.system(size: 14))
                                .bold()
                            +
                            
                            Text(" \(passwordStrength)")
                                .foregroundColor(passwordStrength == "Strong" ? .teal : .red)
                                .font(.system(size: 14))
                            
                        }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading,40)
                            
                            VStack(alignment: .leading) {
                                Text("\u{2022} Must Contain atleast 7 Character")
                                    .foregroundColor(passwordStrength7Character == "Must Contain atleast 7 Character" ? .teal : .red)
                                    .font(.system(size: 14))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading,40)
                                
                                Text("\u{2022} Has one lower case letter")
                                    .foregroundColor(passwordStrengthLowerCase == "Has one lower case letter" ? .teal : .red)
                                    .font(.system(size: 14))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading,40)
                                
                                Text("\u{2022} Has one upper case letter")
                                    .foregroundColor(passwordStrengthUpperrCase == "Has one upper case letter" ? .teal : .red)
                                    .font(.system(size: 14))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading,40)
                                
                                Text("\u{2022} Has atleast one number")
                                    .foregroundColor(passwordStrengthOneNumber == "Has atleast one number" ? .teal : .red)
                                    .font(.system(size: 14))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading,40)
                                
                                Text("\u{2022} Has a special character")
                                    .foregroundColor(passwordStrengthSpecialCharacter == "Has a special character" ? .teal : .red)
                                    .font(.system(size: 14))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading,40)
                            }
                        }

                        Text("Confirm Password")
                            .font(isFontMedium(size: 20))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading,35)
                            .padding(.top,10)
                        
                        HStack {
                            if isConfirmPasswordSecure {
                                SecureField("Confirm Password", text: $signupConfirmPassword)
                            } else {
                                TextField("Confirm Password", text: $signupConfirmPassword)
                            }
                            
                            Button(action: {
                                withAnimation {
                                    isConfirmPasswordSecure.toggle()
                                }
                            }) {
                                Image(systemName: isConfirmPasswordSecure ? "eye" : "eye.slash" )
                                    .bold()
                                    .foregroundColor(.black)
                                    .padding(.trailing)
                            }
                        }
                        .padding()
                        .padding(.leading)
                        .foregroundColor(.black)
                        .font(isFontMedium(size: 18))
                        .onTapGesture {
                            showPasswordStrength = false
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(textFieldBorderColour, lineWidth: 1)
                                .frame(width: 320)
                        )
                        .padding(.horizontal)
                        
                        Button(action: {
                            withAnimation {
                                signupAlertView()
                            }
                        }) {
                            Text("CREATE ACCOUNT")
                                .fontWeight(.semibold)
                                .font(isFontMedium(size: 22))
                                .foregroundColor(.white)
                                .frame(width: 310,height: 50)
                                .background(fontOrangeColour)
                                .cornerRadius(10)
                                .padding(.top,20)
                            
                        }
                    }
                    
                    
                }
            }
            
            // ALERT VIEW
            .alert(item: $alertItem) { alertItem in
                Alert(title: alertItem.title)
            }
        }
        .navigationBarBackButtonHidden()
       
    }
    
    func containsLowerCase() -> Bool {
        let letterRegEx = ".*[a-z]+.*"
        let letterTest = NSPredicate(format: "SELF MATCHES %@", letterRegEx)
        return letterTest.evaluate(with: signupPassword)
    }
    
    func containsUpperCase() -> Bool {
        let letterRegEx = ".*[A-Z]+.*"
        let letterTest = NSPredicate(format: "SELF MATCHES %@", letterRegEx)
        return letterTest.evaluate(with: signupPassword)
    }
    
    func containsNumber() -> Bool {
        let numberRegEx = ".*[0-9]+.*"
        let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        return numberTest.evaluate(with: signupPassword)
    }
    
    func containsSpecialCharacter() -> Bool {
        let specialCharacterRegEx = ".*[^A-Za-z0-9]+.*"
        let specialCharacterTest = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegEx)
        return specialCharacterTest.evaluate(with: signupPassword)
    }
    
    
    func signupAlertView() {
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        
        if signupName.trimmingCharacters(in: .whitespacesAndNewlines).description.isEmpty {
             self.alertItem = AlertItem(title: Text("Please provide a valid name"))
             return
         } else if signupMobile.trimmingCharacters(in: .whitespacesAndNewlines).description.isEmpty {
             self.alertItem = AlertItem(title: Text("Please provide a valid mobile number"))
             return
         } else if signupEmail.trimmingCharacters(in: .whitespacesAndNewlines).description.isEmpty {
            self.alertItem = AlertItem(title: Text("Please provide a valid email address"))
            return
        } else if (!emailTest.evaluate(with: signupEmail)) {
            self.alertItem = AlertItem(title: Text("Email is not valid"))
            return
        } else if signupPassword.trimmingCharacters(in: .whitespacesAndNewlines).description.isEmpty {
            self.alertItem = AlertItem(title: Text("Please provide a password that contains at least 7 characters"))
            return
        } else if signupPassword.count != 7 {
            self.alertItem = AlertItem(title: Text("Please provide a password that contains at least 7 characters"))
            return
        } else if signupPassword != signupConfirmPassword {
            self.alertItem = AlertItem(title: Text("Password entered in both the field doesn't match."))
            return
        } else {
            
        }
    }
}
