//
//  OtpPage.swift
//  DynamicFileUpload
//
//  Created by SANJAY  on 27/12/23.
//

import SwiftUI

var emailValue = ""

struct OtpPage: View {
    
    let numberOfFields: Int
    @State var enterValue: [String]
    @State private var navigateDashboardPage = false

    @FocusState private var fieldFocus: Int?
    @State private var oldValue = ""
    @State private var isKeyboardVisible = true
    
    init (numberOfFields: Int) {
        self.numberOfFields = numberOfFields
        self.enterValue = Array(repeating: "", count: numberOfFields)
    }
    
    @State private var secondsRemaining = 59
    @State private var timer: Timer?
    
    @State private var navigateLoginPage = false
    
    
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
                VStack(alignment:.center,spacing: 15) {
                    
                    Image("otppassword")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .padding(.top,40)
                    
                    Text("OTP Verification")
                        .bold()
                        .font(isFontMedium(size: 22))
                        .foregroundColor(fontOrangeColour)
                        .font(isFontMedium(size: 18))
                        .padding(.top)
                    
                    Text("We have sent a six digit code on")
                        .bold()
                        .font(isFontMedium(size: 18))
                    
                    HStack {
                        Text("\(emailValue)")
                            .bold()
                            .foregroundColor(.blue)
                            .font(isFontMedium(size: 17))
//                            .padding(.leading,30)
                            .fixedSize(horizontal: false, vertical: true)
                        
//                        Spacer()
                        
                        Button(action:{
                            navigateLoginPage = true
                            
                        }) {
                            Text("change?")
                                .underline()
                                .font(isFontMedium(size: 17))
                                .foregroundColor(inkBlueColour)
//                                .padding(.trailing,60)
                                .padding(.leading,30)
                        }
                        
                        
                    }
                    
                    HStack {
                        ForEach(0..<numberOfFields, id: \.self) { index in
                            TextField("", text: $enterValue[index], onEditingChanged: { editing in
                                if editing {
                                    oldValue = enterValue[index]
                                }
                            })
                            .bold()
                            .font(isFontMedium(size: 18))
                            .foregroundColor(.black)
                            .keyboardType(.numberPad)
                            .frame(width: 45, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            .multilineTextAlignment(.center)
                            .focused($fieldFocus, equals: index)
                            .tag(index)
                            .onChange(of: enterValue[index]) { newValue in
                                if enterValue[index].count > 1 {
                                    let currentValue = Array(enterValue[index])
                                    
                                    if currentValue[0] == Character(oldValue) {
                                        enterValue[index] = String(enterValue[index].suffix(1))
                                    } else {
                                        enterValue[index] = String(enterValue[index].prefix(1))
                                    }
                                }
                                
                                if !newValue.isEmpty {
                                    if index == numberOfFields - 1 {
                                        fieldFocus = nil
                                    } else {
                                        fieldFocus = (fieldFocus ?? 0) + 1
                                    }
                                } else {
                                    fieldFocus = (fieldFocus ?? 0) - 1
                                }
                            }
                        }
                    }
                    .padding(.top)
                    .padding(.leading)
                    .padding(.trailing)
                    .onAppear {
                        DispatchQueue.main.async {
                            isKeyboardVisible = true
                            fieldFocus = 0 // Set focus to the first field
                            UIApplication.shared.windows.first?.rootViewController?.view.endEditing(false)
                        }
                    }
                    .onChange(of: isKeyboardVisible) { visible in
                        if visible {
                            fieldFocus = 0 // Set focus to the first field
                        }
                    }
                    
                    Button(action:{
                        navigateDashboardPage = true
                    })
                        {
                            Text("VERIFY")
                                .fontWeight(.semibold)
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                                .frame(width: 300,height: 50)
                                .background(fontOrangeColour)
                                .cornerRadius(10)
                                .padding(.top,15)
                        }
//                    NavigationLink("",destination: DashboardView(),isActive: $navigateDashboardPage)
                   
                    HStack {
                        if secondsRemaining > 0 {
                            VStack {
                                Text("You can resend OTP request again in")
                                    .fontWeight(.medium)
                                    .font(isFontMedium(size: 18))
                                    
                                
                                Text("00:\(secondsRemaining)")
                                    .bold()
                                    .font(isFontMedium(size: 18))
                                    .foregroundColor(fontOrangeColour)
                                    .padding(.top,1)
                            }
                            
                        } else {
                            
                            VStack {
                                Text("Didn't get OTP code?")
                                    .fontWeight(.medium)
                                    .font(isFontMedium(size: 18))
                                
                                Button(action: {
                                    startTimer()
                                }) {
                                    Text("RESEND OTP")
                                        .fontWeight(.medium)
                                        .font(isFontMedium(size: 19))
                                        .foregroundColor(fontOrangeColour)
                                        .padding(.top,1)
                                    
                                }
                            }
                        }
                    }
                    .padding(.top,40)
                    .onAppear {
                        startTimer()
                    }
                }
            }
        }.navigationBarBackButtonHidden()
    }
    
    func startTimer() {
        secondsRemaining = 59
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if secondsRemaining > 0 {
                secondsRemaining -= 1
            } else {
                timer.invalidate()
                self.timer = nil
            }
        }
    }
}


