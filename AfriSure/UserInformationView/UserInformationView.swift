import SwiftUI
import Foundation


var productQuotationRequestID = ""

struct UserInformationView: View {
    
    @Binding var navigateUserInformationdPage: Bool
    
    @State private var backToLogin = false
    @State private var fullName = ""
    @State private var phoneNumber = ""
    @State private var email = ""
    @State private var selectedNavigationLink: String? = nil
    @State private var isLoading = false
    @State private var alertItem: AlertItem?
    @State private var navigateLogindPage = false
    @State private var navigateCustomPage = false
//    @State private var detailsArray: [InsertQuotationResponse.InsertQuotationObject.AccountInformation] = []
    @State private var getCountry: [Country] = []
    @State private var selectedCountryCode = "KE (+254)"
    @State private var showCountryCodePopUp = false
    @State private var showProductPopUp = false
    @State private var phoneNumberCount: Int  = 9
    @State private var blocksOfPhoneNo = [3,3,3]
    
    @State private var newCustomer = false
    @State private var existingCustomer = false
    
    @State private var customerTypeArray = ["Retail", "Business"]
    @State var showCustomerTypeArray = false
    
    @State private var customerTypeText = ""
    @State private var customerIdText = ""
    @State private var customerNameText = ""
    
    @State private var accountTypeName = ""
    @State private var accountNum = ""
    @State private var accountName = ""
    @State private var accountStatus = ""
    
    @State var showExitingCustomerValues = false
    @State var submitExitingCustomerValues = false
    
    @State private var errorText = ""
    @State private var existingCustomerFieldDisable = false
    
    @State var showNextButton = false
    
//    @State var productDetailsArray: [ProductResponse.ProductData.ProductValues] = []
    
    @StateObject var networkMonitor = NetworkMonitor()
    
    
    var body: some View {
        NavigationStack {
            LoadingView(isShowing: $isLoading) {
                VStack(spacing: 20) {
                    HStack(alignment: .top,spacing:8) {
                        ZStack {
                            VStack(spacing: 5){
                                Text("Line of Business")
                                    .font(isFontMedium(size: 19))
                                
                                Text(Extensions.selectedLineOfBusiness)
                                    .font(isFontMedium(size: 17))
                                    .foregroundColor(inkBlueColour)
                                    .padding(2)
                                
                            }
                            
                        }
                        .frame(width:175,height: Extensions.selectedItem.count == 1 ? 40 : 50,alignment: .top)
                        .padding(.top,10)
                        .padding(.bottom,10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.leading)
                        
                        ZStack {
                            VStack(spacing: 3) {
                                
                                Text("Products")
                                    .font(isFontMedium(size: 19))
                                
                                
                                 if productArray.count == 1 {
                                     
                                     Text(Array(productArray).first!)
                                         .font(isFontMedium(size: 17))
                                         .foregroundColor(inkBlueColour)
                                         .padding(2)
                                     
                                 } else {
                                     HStack {
                                         
                                         if let firstCharacter = productArray.first {
                                             Text(String(firstCharacter))
                                                 .font(isFontMedium(size: 17))
                                                 .foregroundColor(.black)
                                                 .padding(.leading, 10)
                                                 .lineLimit(1)
                                         }
                                         
                                         Spacer()
                                         
                                         Image(systemName: "chevron.down")
                                             .font(isFontMedium(size: 17))
                                             .padding(.trailing,10)
                                         
                                     }
                                     .frame(width: 160,height: 30)
                                     .background(Color.white)
                                     .cornerRadius(6)
                                     .onTapGesture {
                                         showProductPopUp = true
                                     }
                                 }
                               
//                                if Extensions.selectedItem.count == 1 {
//                                    
//                                    Text(Array(Extensions.selectedItem).first!)
//                                        .font(isFontMedium(size: 17))
//                                        .foregroundColor(inkBlueColour)
//                                        .padding(2)
//                                    
//                                } else {
//                                    HStack {
//                                        
//                                        if let firstCharacter = Extensions.selectedItem.first {
//                                            Text(String(firstCharacter))
//                                                .font(isFontMedium(size: 17))
//                                                .foregroundColor(.black)
//                                                .padding(.leading, 10)
//                                                .lineLimit(1)
//                                        }
//                                        
//                                        Spacer()
//                                        
//                                        Image(systemName: "chevron.down")
//                                            .font(isFontMedium(size: 17))
//                                            .padding(.trailing,10)
//                                        
//                                    }
//                                    .frame(width: 160,height: 30)
//                                    .background(Color.white)
//                                    .cornerRadius(6)
//                                    .onTapGesture {
//                                        showProductPopUp = true
//                                    }
//                                }
                                
                            }
                            
                            
                        }
                        .frame(width:175,height: Extensions.selectedItem.count == 1 ? 40 : 50,alignment: .top)
                        .padding(.top,10)
                        .padding(.bottom,10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.trailing)
                        
                    }
                    
                 
                    ScrollView(showsIndicators: false) {
                        VStack {
                            
                            Text("To personalize your insurance policy, we'd love to know more about you.")
                                .padding(.top,10)
                                .padding(.leading, 30)
                                .padding(.trailing, 30)
                                .foregroundColor(.black)
                                .font(isFontMediumItalic(size: 17))
                                .multilineTextAlignment(.center)
                            
                            Text("Customer Type*")
                                .font(isFontMedium(size: 18))
                                .padding(.top,10)
                                .frame(maxWidth: .infinity, alignment:.leading)
                                .padding(.leading)
                            
                            ZStack {
                                Color.white
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("Full Name")
                                        .padding(.leading)
                                        .font(isFontLight(size: 15))
                                        .font(.headline)
                                        .padding(.top,10)
                                    
                                    ZStack {
                                        Rectangle()
                                            .frame(height: 50) // Set the desired height
                                            .cornerRadius(8)
                                            .foregroundColor(Color.gray.opacity(0.2))
                                        
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color.clear, lineWidth: 1)
                                            )
                                        TextField("", text: $fullName)
                                            .keyboardType(.namePhonePad)
                                            .padding(.horizontal)
                                            .font(isFontMedium(size: 15))
                                            .frame(height: 40)
                                            .onAppear {
                                                fullName = Extensions.userName
                                            }
                                        
                                        
                                    }
//                                    .onChange(of: fullName) { newValue in
//                                        // Validate the input and allow only text and spaces
//                                        fullName = newValue.filter { $0.isLetter || $0.isWhitespace }
//                                    }
                                    .padding(.horizontal)
                                    
                                    
                                    Text("Phone Number")
                                        .padding(.leading)
                                        .font(isFontLight(size: 15))
                                        .font(.headline)
                                    
                                    HStack(spacing:5) {
                                        Text(selectedCountryCode)
                                            .padding(.trailing,25)
                                            .font(isFontLight(size: 18))
                                            .frame(width:130, height: 50)
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(5)
                                            .overlay{
                                                Image(systemName: "chevron.down")
                                                    .font(isFontMedium(size: 15))
                                                    .frame(maxWidth:.infinity, alignment: .trailing)
                                                    .padding(.trailing,10)
                                                
                                                
                                            }
                                            .onTapGesture {
                                                self.showCountryCodePopUp = true
                                            }
                                        
                                        ZStack(alignment: .leading) {
                                            
                                            Rectangle()
                                                .frame(width:180 ,height: 50) // Set the desired height
                                                .cornerRadius(8)
                                                .foregroundColor(Color.gray.opacity(0.2))
                                            
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .stroke(Color.clear, lineWidth: 1)
                                                )
                                            TextField("", text: $phoneNumber)
                                                .keyboardType(.phonePad)
                                                .padding(.trailing)
                                                .padding(.horizontal)
                                                .font(isFontMedium(size: 15))
                                                .frame(height: 40) // Match the height with the Rectangle
                                                .onChange(of: phoneNumber) { newValue in
                                                    //                                                phoneNumber = formatPhoneNumber(phoneNumber: newValue)
                                                    let formattedPhoneNumber = formatPhoneNumber(phoneNumber: phoneNumber, blocks: blocksOfPhoneNo)
                                                    phoneNumber = formattedPhoneNumber
                                                    
                                                }
                                        }
                                        
                                    }
                                    .padding(.leading)
                                    
                                    Text("Email Address")
                                        .padding(.leading)
                                        .font(isFontLight(size: 15))
                                        .font(.headline)
                                    
                                    ZStack(alignment: .leading) {
                                        Rectangle()
                                            .frame(height: 50) // Set the desired height
                                            .cornerRadius(8)
                                            .foregroundColor(Color.gray.opacity(0.2))
                                        
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color.clear, lineWidth: 1)
                                            )
                                        TextField("", text: $email)
                                            .keyboardType(.emailAddress)
                                            .padding(.trailing)
                                            .padding(.horizontal)
                                            .font(isFontMedium(size: 15))
                                            .frame(height: 40) // Match the height with the Rectangle
                                            .onAppear {
                                                email = Extensions.emailID
                                            }
                                        
                                    }
                                    .padding(.horizontal)
                                    
                                    Spacer()
                                    
                                }
                                
                            }
                            .frame(width: 350)
                            .fixedSize(horizontal: false, vertical: true)
                            .cornerRadius(8)
                            .shadow(radius: 3)
                            .padding(.top)

//                            
//                            Button(action:{
//                                newCustomer = true
//                                existingCustomer = false
//                                
//                                showNextButton = true
//                            })
//                            {
//                                HStack {
//                                    Image(systemName: newCustomer ? "smallcircle.filled.circle" : "circle")
//                                        .bold()
//                                        .font(isFontMedium(size: 20))
//                                        .foregroundColor(newCustomer ? fontOrangeColour : Color.black)
//                                    
//                                    Text("New Customer")
//                                        .font(isFontMedium(size: 17))
//                                        .foregroundColor(Color.black)
//                                    
//                                }
//                                .frame(maxWidth: .infinity, alignment:.leading)
//                                .padding(.leading,25)
//                                .padding(.top,10)
//                            }
//                            
//                            Button(action:{
//                                existingCustomer = true
//                                newCustomer = false
//                                showNextButton = false
//                            })
//                            {
//                                HStack {
//                                    Image(systemName: existingCustomer ? "smallcircle.filled.circle" : "circle")
//                                        .bold()
//                                        .font(isFontMedium(size: 20))
//                                        .foregroundColor(existingCustomer ? fontOrangeColour : Color.black)
//                                    
//                                    Text("Existing Customer")
//                                        .font(isFontMedium(size: 17))
//                                        .foregroundColor(Color.black)
//                                    
//                                }
//                                .frame(maxWidth: .infinity, alignment:.leading)
//                                .padding(.leading,25)
//                                .padding(.top,10)
//                            }
//                            
//                            if newCustomer {
//                                ZStack {
//                                    Color.white
//                                    VStack(alignment: .leading, spacing: 15) {
//                                        Text("Full Name")
//                                            .padding(.leading)
//                                            .font(isFontLight(size: 15))
//                                            .font(.headline)
//                                            .padding(.top,10)
//                                        
//                                        ZStack {
//                                            Rectangle()
//                                                .frame(height: 50) // Set the desired height
//                                                .cornerRadius(8)
//                                                .foregroundColor(Color.gray.opacity(0.2))
//                                            
//                                                .overlay(
//                                                    RoundedRectangle(cornerRadius: 8)
//                                                        .stroke(Color.clear, lineWidth: 1)
//                                                )
//                                            TextField("", text: $fullName)
//                                                .keyboardType(.namePhonePad)
//                                                .padding(.horizontal)
//                                                .font(isFontMedium(size: 15))
//                                                .frame(height: 40)
//                                            
//                                            
//                                        }
//                                        .onChange(of: fullName) { newValue in
//                                            // Validate the input and allow only text and spaces
//                                            fullName = newValue.filter { $0.isLetter || $0.isWhitespace }
//                                        }
//                                        .padding(.horizontal)
//                                        
//                                        
//                                        Text("Phone Number")
//                                            .padding(.leading)
//                                            .font(isFontLight(size: 15))
//                                            .font(.headline)
//                                        
//                                        HStack(spacing:5) {
//                                            Text(selectedCountryCode)
//                                                .padding(.trailing,25)
//                                                .font(isFontLight(size: 18))
//                                                .frame(width:130, height: 50)
//                                                .background(Color.gray.opacity(0.2))
//                                                .cornerRadius(5)
//                                                .overlay{
//                                                    Image(systemName: "chevron.down")
//                                                        .font(isFontMedium(size: 15))
//                                                        .frame(maxWidth:.infinity, alignment: .trailing)
//                                                        .padding(.trailing,10)
//                                                    
//                                                    
//                                                }
//                                                .onTapGesture {
//                                                    self.showCountryCodePopUp = true
//                                                }
//                                            
//                                            ZStack(alignment: .leading) {
//                                                
//                                                Rectangle()
//                                                    .frame(width:180 ,height: 50) // Set the desired height
//                                                    .cornerRadius(8)
//                                                    .foregroundColor(Color.gray.opacity(0.2))
//                                                
//                                                    .overlay(
//                                                        RoundedRectangle(cornerRadius: 8)
//                                                            .stroke(Color.clear, lineWidth: 1)
//                                                    )
//                                                TextField("", text: $phoneNumber)
//                                                    .keyboardType(.phonePad)
//                                                    .padding(.trailing)
//                                                    .padding(.horizontal)
//                                                    .font(isFontMedium(size: 15))
//                                                    .frame(height: 40) // Match the height with the Rectangle
//                                                    .onChange(of: phoneNumber) { newValue in
//                                                        //                                                phoneNumber = formatPhoneNumber(phoneNumber: newValue)
//                                                        let formattedPhoneNumber = formatPhoneNumber(phoneNumber: phoneNumber, blocks: blocksOfPhoneNo)
//                                                        phoneNumber = formattedPhoneNumber
//                                                        
//                                                    }
//                                            }
//                                            
//                                        }
//                                        .padding(.leading)
//                                        
//                                        Text("Email")
//                                            .padding(.leading)
//                                            .font(isFontLight(size: 15))
//                                            .font(.headline)
//                                        
//                                        ZStack(alignment: .leading) {
//                                            Rectangle()
//                                                .frame(height: 50) // Set the desired height
//                                                .cornerRadius(8)
//                                                .foregroundColor(Color.gray.opacity(0.2))
//                                            
//                                                .overlay(
//                                                    RoundedRectangle(cornerRadius: 8)
//                                                        .stroke(Color.clear, lineWidth: 1)
//                                                )
//                                            TextField("", text: $email)
//                                                .keyboardType(.emailAddress)
//                                                .padding(.trailing)
//                                                .padding(.horizontal)
//                                                .font(isFontMedium(size: 15))
//                                                .frame(height: 40) // Match the height with the Rectangle
//                                            
//                                        }
//                                        .padding(.horizontal)
//                                        
//                                        Spacer()
//                                        
//                                    }
//                                    
//                                }
//                                .frame(width: 350)
//                                .fixedSize(horizontal: false, vertical: true)
//                                .cornerRadius(8)
//                                .shadow(radius: 3)
//                                .padding(.top)
//                            }
//                            
//                            if existingCustomer {
//                                ZStack {
//                                    Color.white
//                                    VStack(alignment: .leading, spacing: 15) {
//                                        Text("Clear")
//                                            .bold()
//                                            .font(isFontMedium(size: 18))
//                                            .foregroundColor(inkBlueColour)
//                                            .underline()
//                                            .frame(maxWidth: .infinity, alignment:.trailing)
//                                            .padding(.trailing)
//                                            .padding(.top,10)
//                                            .onTapGesture {
//                                                customerTypeText = ""
//                                                customerIdText = ""
//                                                customerNameText = ""
//                                                showNextButton = false
//                                                existingCustomerFieldDisable = false
//                                            }
//                                        
//                                        Text("Customer Type*")
//                                            .font(isFontMedium(size: 18))
//                                        
//                                        TextField("Select", text: $customerTypeText)
//                                        .disabled(true)
//                                        .padding(10)
//                                        .frame(width: 315,height:50)
//                                        .autocapitalization(.none)
//                                        .autocorrectionDisabled()
//                                        .font(isFontMedium(size: 18))
//                                        .autocapitalization(.none)
//                                        .autocorrectionDisabled()
//                                        .background(Color.gray.opacity(0.2))
//                                        .foregroundColor(.black)
//                                        .cornerRadius(8)
//                                        .overlay(
//                                            
//                                            Image(systemName: "chevron.down")
//                                                .padding(.trailing,10)
//                                                .bold()
//                                                .foregroundColor(.black)
//                                                .font(isFontMedium(size: 20))
//                                                .frame(maxWidth: .infinity,alignment:.trailing)
//                                                .padding(.trailing)
//                                            
//                                        )
//                                        .onTapGesture {
//                                            if !existingCustomerFieldDisable {
//                                                withAnimation {
//                                                    showCustomerTypeArray.toggle()
//                                                }
//                                            }
//                                        }
//                                        
//                                        
//                                        Text("Customer ID")
//                                            .font(isFontMedium(size: 18))
//                                        
//                                        TextField("", text: $customerIdText)
//                                        .disabled(existingCustomerFieldDisable)
//                                        .padding(10)
//                                        .frame(width: 315,height:50)
//                                        .autocapitalization(.none)
//                                        .autocorrectionDisabled()
//                                        .font(isFontMedium(size: 18))
//                                        .autocapitalization(.none)
//                                        .autocorrectionDisabled()
//                                        .background(Color.gray.opacity(0.2))
//                                        .foregroundColor(.black)
//                                        .cornerRadius(8)
//                                        
//                                        Text("Customer Name")
//                                            .font(isFontMedium(size: 18))
//                                        
//                                        TextField("", text: $customerNameText)
//                                        .disabled(existingCustomerFieldDisable)
//                                        .padding(10)
//                                        .frame(width: 315,height:50)
//                                        .autocapitalization(.none)
//                                        .autocorrectionDisabled()
//                                        .font(isFontMedium(size: 18))
//                                        .autocapitalization(.none)
//                                        .autocorrectionDisabled()
//                                        .background(Color.gray.opacity(0.2))
//                                        .foregroundColor(.black)
//                                        .cornerRadius(8)
//                                        
//                                        Button(action: {
//                                            
//                                            existingCustomerValidation()
//                                        })
//                                        {
//                                            Text("Search")
//                                                .bold()
//                                                .font(isFontMedium(size: 18))
//                                                .foregroundColor(.white)
//                                                .frame(width:150, height: 50)
//                                                .background(fontOrangeColour)
//                                                .cornerRadius(10)
//                                                .frame(maxWidth: .infinity, alignment:.center)
//                                        }
//
//                                        
//                                    }
//                                    .padding()
//                                }
//                                .frame(width: 350)
//                                .fixedSize(horizontal: false, vertical: true)
//                                .cornerRadius(8)
//                                .shadow(radius: 3)
//                                .padding()
//                            }
                        }
                        
                    }
                    
                    VStack {
//                    if showNextButton {
                        
                            //                        NavigationLink("", destination: CustomForms(), isActive: $navigateCustomPage)
                            Button(action: {
                                userInfoAlertView()
                            }) {
                                Text("NEXT")
                                    .padding(.top)
                                    .frame(maxWidth: .infinity)
                                    .background(toolbarcolor)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .font(isFontBold(size: 20))
                                
                            }
//                        }
                    }
                   
                }
                .onAppear {
                    //                        service.fetchPhoneCodes()
                    getPhoneCode()
                }
                .padding(.top,10)
                
                
                // ALERT VIEW
                .alert(item: $alertItem) { alertItem in
                    Alert(title: alertItem.title)
                }

                
                //  TOOL BAR
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        
                        HStack {
                            
                            Button(action: {
//                                self.selectedNavigationLink = "ProductsView"
                                
                                withAnimation {
                                    navigateUserInformationdPage = false
                                }
                                
                            })
                            {
                                
                                Image(systemName: "arrow.backward")
                                    .bold()
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .padding(.bottom)
                                
                            }
                            
                            
//                            NavigationLink(destination: ProductsView(), tag: "ProductsView", selection: $selectedNavigationLink) { EmptyView() }
                            
                            Text("User Information")
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
        }.navigationBarBackButtonHidden(true)
        
            .overlay(
                navigateCustomPage ? CustomForms(navigateCustomPage: $navigateCustomPage) : nil
            )
        
//            .overlay(
//                !networkMonitor.isConnected ? ErrorView() : nil
//            )
        
            .overlay {

                    if showCountryCodePopUp {
                        Color.black.opacity(0.1)
                            .ignoresSafeArea()
                            .onTapGesture {
                                showCountryCodePopUp = false
                            }
                        ZStack {
                            
                            VStack {
                                List {
                                    ForEach(getCountry, id: \.dial_code) { country in
                                        VStack {
                                            
                                            Button(action: {
                                                // Handle the tap gesture
                                                self.selectedCountryCode = "\(country.code)" + " (\(country.dial_code))"
                                                let sumOfBlocks = country.blocks.reduce(0, +)
                                                self.phoneNumberCount = sumOfBlocks
                                               
                                                self.showCountryCodePopUp = false
                                                self.blocksOfPhoneNo = country.blocks
                                                self.phoneNumber = ""
                                            }) {
                                                Text("\(country.code)" + " (\(country.dial_code))")
                                                    .font(isFontMedium(size: 18))
                                                    .padding(3)
                                                    .font(isFontLight(size: 15))
                                            }
                                        }
                                    }
                                }
                                .listStyle(.plain)
                                .frame(width:300,height:600)
                                .cornerRadius(8)
                                .padding(.bottom)
                            }
                        }
                    }
                    
                    if showProductPopUp {
                        ZStack {
                            Color.black.opacity(0.3)
                                .ignoresSafeArea()
                                .onTapGesture {
                                    showProductPopUp = false
                                }
                            VStack {
                                ForEach(productArray, id: \.self) { value in
                                    Text(value)
                                    .font(isFontMedium(size: 18))
                                    .padding(8)
                                    .frame(maxWidth:.infinity,alignment:.leading)
                                        .onTapGesture {
                                            showProductPopUp = false
                                        }
                                }
                            }
                            .frame(width:350)
                            .background(Color.white)
                            
                            
                        }
                    }
                
                if showCustomerTypeArray {
                    
                    Color.black.opacity(0.1)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showCustomerTypeArray = false
                        }
                    ZStack {
                      
                        VStack {
                            Spacer()
                            
                            VStack {
                                ForEach(customerTypeArray, id: \.self) { value in
                                    
                                    Button(action:{
                                        showCustomerTypeArray = false
                                        customerTypeText = value
                                    })
                                    {
                                        Text(value)
                                            .font(isFontMedium(size: 18))
                                            .padding(10)
                                            .foregroundColor(.black)
                                            .frame(maxWidth:.infinity,alignment:.leading)
                                    }
                                }
                                
                            }
                            .frame(width:300)
                            .background(Color.white)
                            .cornerRadius(0)
                            .shadow(radius: 3)
                            
                            Spacer()
                        }
                    }
                    
                }
                   
                if showExitingCustomerValues {
                        Color.black.opacity(0.5)
                            .ignoresSafeArea()
                            .onTapGesture {
                                showExitingCustomerValues = false
                            }
                        ZStack {
                            TfBackgroundColor
                            VStack {
                                HStack {
                                    Image(systemName: "arrow.backward")
                                        .foregroundColor(.white)
                                        .font(.system(size: 22))
                                        .bold()
                                        .padding(.leading)
                                        .onTapGesture {
                                            showExitingCustomerValues = false
                                        }
                                    
                                    Spacer()
                                    
                                    Text("Existing Customer")
                                        .foregroundColor(.white)
                                        .font(isFontMedium(size: 20))
                                    
                                    Spacer()
                                }
                                .frame(width:350,height:50)
                                .background(fontOrangeColour)
                                
                                
                                if errorText.isEmpty {
                                    VStack(alignment:.leading, spacing:10) {
                                        
                                        HStack(alignment:.top) {
                                            
                                            VStack {
                                                Text("Customer ID")
                                                    .font(isFontMedium(size: 18))
                                                    .foregroundColor(fontOrangeColour)
                                                    .frame(maxWidth:.infinity, alignment:.leading)
                                            }
                                            .frame(width:140)
                                            
                                            VStack {
                                                Text(": \(accountNum)")
                                                    .font(isFontMedium(size: 18))
                                                    .foregroundColor(.black)
                                            }
                                            .frame(maxWidth:.infinity, alignment:.leading)
                                        }
                                        .fixedSize(horizontal: false, vertical: true)
                                        
                                        HStack(alignment:.top) {
                                            
                                            VStack {
                                                Text("Customer Type")
                                                    .font(isFontMedium(size: 18))
                                                    .foregroundColor(fontOrangeColour)
                                                    .frame(maxWidth:.infinity, alignment:.leading)
                                            }
                                            .frame(width:140)
                                            
                                            VStack {
                                                Text(": \(accountTypeName)")
                                                    .font(isFontMedium(size: 18))
                                                    .foregroundColor(.black)
                                            }
                                            .frame(maxWidth:.infinity, alignment:.leading)
                                        }
                                        .fixedSize(horizontal: false, vertical: true)
                                        
                                        
                                        HStack(alignment:.top) {
                                            
                                            VStack {
                                                Text("Customer Name")
                                                    .font(isFontMedium(size: 18))
                                                    .foregroundColor(fontOrangeColour)
                                                    .frame(maxWidth:.infinity, alignment:.leading)
                                            }
                                            .frame(width:140)
                                            
                                            VStack {
                                                Text(": \(accountName)")
                                                    .font(isFontMedium(size: 18))
                                                    .foregroundColor(.black)
                                            }
                                            .frame(maxWidth:.infinity, alignment:.leading)
                                        }
                                        .fixedSize(horizontal: false, vertical: true)

                                        
                                        HStack(alignment:.top) {
                                            
                                            VStack {
                                                Text("Customer Status")
                                                    .font(isFontMedium(size: 18))
                                                    .foregroundColor(fontOrangeColour)
                                                    .frame(maxWidth:.infinity, alignment:.leading)
                                            }
                                            .frame(width:140)
                                            
                                            VStack {
                                                Text(": \(accountStatus)")
                                                    .font(isFontMedium(size: 18))
                                                    .foregroundColor(.black)
                                            }
                                            .frame(maxWidth:.infinity, alignment:.leading)
                                        }
                                        .fixedSize(horizontal: false, vertical: true)
                                      
                                    }
                                    .padding()
                                    .frame(width: 310)
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(submitExitingCustomerValues ? fontOrangeColour : Color.clear, lineWidth: 2)
                                            .frame(width: 310)
                                    )
                                    .onTapGesture {
                                        submitExitingCustomerValues = true
                                    }
                                    .padding()
                                    
                                    
                                    Button(action: {
                                        
                                        if submitExitingCustomerValues {
                                            customerTypeText = accountTypeName
                                            customerNameText = accountName
                                            customerIdText = accountNum
                                            showExitingCustomerValues = false
                                            submitExitingCustomerValues = false
                                            showNextButton = true
                                        } else {
                                            
                                            if let errorDict = Extensions.getValidationDict() as? [String: String] {
                                                if let errorMessage = errorDict["ERR017"] {
                                                    self.alertItem = AlertItem(title: Text("ERR017" + "\n" + errorMessage.localized()))
                                                }
                                            }

                                        }
                                      
                                    })
                                    {
                                        Text("Submit")
                                            .bold()
                                            .font(isFontMedium(size: 18))
                                            .foregroundColor(.white)
                                            .frame(width:150, height: 40)
                                            .background(fontOrangeColour)
                                            .cornerRadius(10)
                                            .frame(maxWidth: .infinity, alignment:.center)
                                            .padding()
                                    }
                                    
                                    
                                } else {
                                    Text(errorText)
                                        .font(isFontMedium(size: 20))
                                        .padding()
                                }
                                
                            }
                            
                        }
                        .frame(width:350)
                        .fixedSize(horizontal: false, vertical: true)
                        .cornerRadius(8)
                        
                    
                }
                
            }

    }
    
    func getPhoneCode() {
        guard let url = URL(string: "https://kenindia-primez.insure.digital/assets/jsons/phoneCode.json") else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }

            guard let data = data else { return }
            DispatchQueue.main.async {
                let decoder = JSONDecoder()
                do {
                    // Decode an array of Country objects
                    let countries = try decoder.decode([Country].self, from: data)
                    print(countries)
                    getCountry = countries
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }

        dataTask.resume()
    }

    
    func fetchQuotationAccountRetailInsert() {
        
        
        isLoading = true
        
        let parameters: [String: Any?] = [
             "phoneNumber":phoneNumber,
             "countryCode":selectedCountryCode,
             "accountName":fullName,
             "lastName":nil,
             "email":email
        ]

        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "https://uat-core-api-primez.insure.digital/")!,
                                         path:"api/digital/core/CRM/QuotationAccountRetailInsert",
                                         method: "POST",bodyData:parameters as [String : Any])
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<AccountResponse, Error>) in
            switch result {
            case .success(let response):
                // Handle success
                DispatchQueue.main.async {
                    
                    if response.rcode == 200 {
                       
                        isLoading = false
                        fetchInsertQuotation()
                        
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
    }
    
    
    func fetchInsertQuotation() {
        
        isLoading = true
        
        var addedProducts: [[String: Any]] = []

        productDetailsArray.forEach { value in
            if selectedProductIds.contains(value.productID) {
                addedProducts.append([
                    "productID": value.productID,
                    "productCode": value.productCode,
                    "productName": value.productName,
                    "productDescription": value.productDescription,
                    "pZLOB": value.pZLOB,
                    "pZLOBID": value.pZLOBID,
                    "pzCategory": value.pzCategory,
                    "pzCategoryID": value.pzCategoryID,
                    "crts": value.crts,
                    "crUserName": value.crUserName
                ])
            }
        }
        
        let parameters: [String: Any] = [
            "pZLOBID": Extensions.lineOfBusinessID,
            "pZLOB": Extensions.selectedLineOfBusiness,
            "customer": [
                "accountID": "0796c27d-11c7-468d-afae-f86b8962357f",
                "accountNum": "RA01070",
                "accountTypeID": 200,
                "accountType": "Retail",
                "customerStatus": "Active",
                "fullName": "sanjay",
                "phoneNo": "4242342234",
                "countryCode": "+254",
                "email": "sanjay@gmail.com"
            ],
            "product": addedProducts
            
        ]
        
     
        print("selectedProductIds -- > \(selectedProductIds)")
        
        
        print("Insert parameters -- > \(parameters)")
        
        print("addedProducts parameters -- > \(addedProducts)")

        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(BaseURL)")!,
                                         path: "api/prodconfig/Quotation/InsertQuotation",
                                         method: "POST",bodyData:parameters)
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<InsertQuotationResponse, Error>) in
            switch result {
            case .success(let insertQuotationResponse):
                // Handle success
                DispatchQueue.main.async {
                    
                    if insertQuotationResponse.rcode == 200 {
                        print(insertQuotationResponse.rcode)
                        
                        withAnimation {
                            navigateCustomPage = true
                        }
                        
                        productQuotationRequestID = insertQuotationResponse.rObj.QuotationRequestID
//                        print(insertQuotationResponse.rObj.quotationSearchID)
//                        productQuotationRefId = insertQuotationResponse.rObj.quotationRefID
                        Extensions.quotationID = insertQuotationResponse.rObj.QuotationID
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
                
                   if let errorDict = Extensions.getValidationDict() as? [String: String] {
                       if let errorMessage = errorDict["ERR014"] {
                           self.alertItem = AlertItem(title: Text("ERR014 \n \(errorMessage.localized())"))
                       }
                   }
                isLoading = false
            }
        }
        
        
//        isLoading = true
//        let url = URL(string: "\(BaseURL)api/digital/core/Quotation/InsertQuotation")!
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
//            "productIDs": Array(selectedProductIds),
//             "phoneNumber":phoneNumber,
//             "name":fullName,
//             "email":email
//        ]
//        print(parameters)
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
//                print("Insert Quotation Response = \(String(describing: resultDictionary))")
//                
//                let decoder = JSONDecoder()
//                let insertQuotationResponse = try decoder.decode(InsertQuotationResponse.self, from: data)
//                
//                DispatchQueue.main.async {
//                    
//                    if insertQuotationResponse.rcode == 200 {
//                        print(insertQuotationResponse.rcode)
//                        
//                        withAnimation {
//                            navigateCustomPage = true
//                        }
//                        
//                        productQuotationSearchId = insertQuotationResponse.rObj.quotationSearchID
//                        print(insertQuotationResponse.rObj.quotationSearchID)
//                        productQuotationRefId = insertQuotationResponse.rObj.quotationRefID
//                        Extensions.quotationID = insertQuotationResponse.rObj.quotationID
//                        isLoading = false
//                        
//                    } else {
//                        self.alertItem = AlertItem(title: Text(insertQuotationResponse.rmsg.first?.errorText ?? ""))
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
    
    
    func fetchExitingCustomer() {
        isLoading = true
        let url = URL(string: "\(BaseURL)api/digital/core/Reports")!
        print(url)
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        
        let authToken:String! = "Bearer " + Extensions.token
        
        let filters: [String: Any] = ["pageNo": 1, "pageSize": 1000, "accountType": "200", "accountNum": "\(customerIdText)", "accountName": "\(customerNameText)"]
        
        var postData : Data

        postData = try! JSONSerialization.data(withJSONObject: filters, options: JSONSerialization.WritingOptions(rawValue: 0))

         let theJSONData = (NSString(data: postData, encoding: String.Encoding.utf8.rawValue)! as String).replacingOccurrences(of: "%20", with: " ")
        
        request.addValue(authToken, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("e697aad1-b2db-4d93-87e5-66e4ececc1e0", forHTTPHeaderField: "Reportid")
        request.addValue(theJSONData, forHTTPHeaderField: "Filters")

        print(authToken as Any)
        
        let parameters: [String: Any] = [
            "query": "{}",
            "variables": [:]
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
                print("Exiting Customers Response = \(String(describing: resultDictionary))")
//                
//                let decoder = JSONDecoder()
//                let insertQuotationResponse = try decoder.decode(InsertQuotationResponse.self, from: data)
//                
                DispatchQueue.main.async {
                    
                    if let responseData = resultDictionary?["Data"] as? [String: Any],
                       let accountSearchArray = responseData["accountSearch"] as? [[String: Any]],
                       let firstAccount = accountSearchArray.first,
                       let accountName = firstAccount["accountName"] as? String,
                       let accountNum = firstAccount["accountNum"] as? String,
                       let accountTypeName = firstAccount["accountTypeName"] as? String,
                       let accountStatus = firstAccount["accountStatus"] as? String {
                        
                        self.accountNum = accountNum
                        self.accountTypeName = accountTypeName
                        self.accountName = accountName
                        self.accountStatus = accountStatus
                        errorText = ""
                        
                        print("Account Num: \(accountNum)")
                        print("Account Type Name: \(accountTypeName)")
                        print("Account Status: \(accountStatus)")
                        
                        existingCustomerFieldDisable = true
                        
                    } else {
                        print("Error extracting account details from response")
                        errorText = "No Records Found"
                        
                    }
                        isLoading = false
                    showExitingCustomerValues = true

                }
            } catch {
                print("\("Error decoding response") \(error.localizedDescription)")
                self.alertItem = AlertItem(title: Text("An unexpected error occurred"))
                isLoading = false
                
                
                
                
            }
        }
        task.resume()
    }
    
    func existingCustomerValidation() {
        if existingCustomer == true && customerTypeText.trimmingCharacters(in: .whitespacesAndNewlines).description.isEmpty {
            if let errorDict = Extensions.getValidationDict() as? [String: String] {
                if let errorMessage = errorDict["ERR015"] {
                    self.alertItem = AlertItem(title: Text("ERR015" + "\n" + errorMessage.localized()))
                }
            }
            return
        } else if existingCustomer == true && customerIdText.trimmingCharacters(in: .whitespacesAndNewlines).description.isEmpty && customerNameText.trimmingCharacters(in: .whitespacesAndNewlines).description.isEmpty {
            if let errorDict = Extensions.getValidationDict() as? [String: String] {
                if let errorMessage = errorDict["ERR016"] {
                    self.alertItem = AlertItem(title: Text("ERR016" + "\n" + errorMessage.localized()))
                }
            }
            return
        } else {
            fetchExitingCustomer()
            showNextButton = false
            
        }
    }
    
    
    func userInfoAlertView() {
        
           let nameRegex = "[A-Za-z ]*"
//           let nameTest = NSPredicate(format:"SELF MATCHES %@" , nameRegex)
    
           let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
           
           let cleanedPhoneNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
   //        print("cleanedPhoneNumber = \(cleanedPhoneNumber.count)")
           
           if fullName.trimmingCharacters(in: .whitespacesAndNewlines).description.isEmpty {
               if let errorDict = Extensions.getValidationDict() as? [String: String] {
                   if let errorMessage = errorDict["ERR005"] {
                       self.alertItem = AlertItem(title: Text("ERR005" + "\n" + errorMessage.localized()))
                   }
               }
               return
           } 
//        else if (!nameTest.evaluate(with: fullName)) {
//               self.alertItem = AlertItem(title: Text("Please enter valid name"))
//               return
//    
//           }
        else if (fullName.count < 3 ){
               self.alertItem = AlertItem(title: Text("Full name should be at least 3 characters"))
    
               return
           }  else if phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines).description.isEmpty {
               if let errorDict = Extensions.getValidationDict() as? [String: String] {
                   if let errorMessage = errorDict["ERR006"] {
                       self.alertItem = AlertItem(title: Text("ERR006" + "\n" + errorMessage.localized()))
                   }
               }
               return
           } else if cleanedPhoneNumber.count != self.phoneNumberCount {
               if let errorDict = Extensions.getValidationDict() as? [String: String] {
                   if let errorMessage = errorDict["ERR007"] {
                       self.alertItem = AlertItem(title: Text("ERR007" + "\n" + errorMessage.localized()))
                   }
               }
               return
           } else if email.trimmingCharacters(in: .whitespacesAndNewlines).description.isEmpty {
               if let errorDict = Extensions.getValidationDict() as? [String: String] {
                   if let errorMessage = errorDict["ERR002"] {
                       self.alertItem = AlertItem(title: Text("ERR002" + "\n" + errorMessage.localized()))
                   }
               }
               return
           } else if (!emailTest.evaluate(with: email)) {
               if let errorDict = Extensions.getValidationDict() as? [String: String] {
                   if let errorMessage = errorDict["ERR003"] {
                       self.alertItem = AlertItem(title: Text("ERR003" + "\n" + errorMessage.localized()))
                   }
               }
               return
           }else {
               //Your API call here
              
               fetchQuotationAccountRetailInsert()
           }
       }
    
    
//    func userInfoAlertView() {
//        
//           let nameRegex = "[A-Za-z ]*"
//           let nameTest = NSPredicate(format:"SELF MATCHES %@" , nameRegex)
//    
//           let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//           let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
//           
//           let cleanedPhoneNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
//   //        print("cleanedPhoneNumber = \(cleanedPhoneNumber.count)")
//           
//           if newCustomer == true && fullName.trimmingCharacters(in: .whitespacesAndNewlines).description.isEmpty {
//               if let errorDict = Extensions.getValidationDict() as? [String: String] {
//                   if let errorMessage = errorDict["ERR005"] {
//                       self.alertItem = AlertItem(title: Text("ERR005" + "\n" + errorMessage))
//                   }
//               }
//               return
//           } else if newCustomer == true && (!nameTest.evaluate(with: fullName)) {
//               self.alertItem = AlertItem(title: Text("Please enter valid name"))
//               return
//    
//           } else if newCustomer == true && (fullName.count < 3 ){
//               self.alertItem = AlertItem(title: Text("Full name should be at least 3 characters"))
//    
//               return
//           }  else if newCustomer == true && phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines).description.isEmpty {
//               if let errorDict = Extensions.getValidationDict() as? [String: String] {
//                   if let errorMessage = errorDict["ERR006"] {
//                       self.alertItem = AlertItem(title: Text("ERR006" + "\n" + errorMessage))
//                   }
//               }
//               return
//           } else if newCustomer == true && cleanedPhoneNumber.count != self.phoneNumberCount {
//               if let errorDict = Extensions.getValidationDict() as? [String: String] {
//                   if let errorMessage = errorDict["ERR007"] {
//                       self.alertItem = AlertItem(title: Text("ERR007" + "\n" + errorMessage))
//                   }
//               }
//               return
//           } else if newCustomer == true && email.trimmingCharacters(in: .whitespacesAndNewlines).description.isEmpty {
//               if let errorDict = Extensions.getValidationDict() as? [String: String] {
//                   if let errorMessage = errorDict["ERR002"] {
//                       self.alertItem = AlertItem(title: Text("ERR002" + "\n" + errorMessage))
//                   }
//               }
//               return
//           } else if newCustomer == true && (!emailTest.evaluate(with: email)) {
//               if let errorDict = Extensions.getValidationDict() as? [String: String] {
//                   if let errorMessage = errorDict["ERR003"] {
//                       self.alertItem = AlertItem(title: Text("ERR003" + "\n" + errorMessage))
//                   }
//               }
//               return
//           }else {
//               //Your API call here
//               fetchInsertQuotation()
//           }
//       }


}

func formatPhoneNumber(phoneNumber: String, blocks: [Int]) -> String {
    let cleanedNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    var formattedNumber = ""
    var blockIndex = 0
    var currentIndex = cleanedNumber.startIndex

    for blockLength in blocks {
        let endIndex = cleanedNumber.index(currentIndex, offsetBy: blockLength, limitedBy: cleanedNumber.endIndex) ?? cleanedNumber.endIndex
        let block = cleanedNumber[currentIndex..<endIndex]
        formattedNumber.append(contentsOf: block)
        currentIndex = endIndex

        if blockIndex < blocks.count - 1 {
            formattedNumber.append(" ") // Add a space between blocks
        }
        blockIndex += 1
    }

    return formattedNumber.trimmingCharacters(in: .whitespaces)
}




struct UserInformationView_Previews: PreviewProvider {
    static var previews: some View {
        UserInformationView(navigateUserInformationdPage: .constant(false))
    }
}
