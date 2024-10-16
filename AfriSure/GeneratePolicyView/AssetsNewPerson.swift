

import SwiftUI

var assetsTypeId = ""

struct AssetsNewPerson: View {
    
    @Binding var navigateAssetsNewPersonPage: Bool
    
    @State var newPersonArrayDetails: [AssetsAddNewPersonResponse.GetAddNewPerson.FormField.FieldGroup] = []
        
    @State var selectedField = ""
    @State private var isDropdownOpen = false
    
    @State var selectedDate: Date?
    @State private var isShowingDatePicker = false
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        return formatter
    }()
    
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
                           
                            ForEach(newPersonArrayDetails, id: \.key) { field in
                                
                                VStack(spacing:10) {
                                    let templateOptions = field.templateOptions
                                    
                                    if field.type == "input" {
                                        
                                        
                                        Text("\(templateOptions?.label ?? "") \(templateOptions?.required ?? false ? "*" : "")")
                                            .halfTextColorChange(fullText: "\(templateOptions?.label ?? "") \(templateOptions?.required ?? false ? "*" : "")", changeText: "*")
                                            .font(isFontMedium(size: 18))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading)
                                            .padding(.top,10)
                                        
                                        TextField("\(templateOptions?.placeholder ?? "")", text: Binding<String>(
                                            get: {
                                                field.defaultValue ?? ""
                                            },
                                            set: { newValue in
                                                field.defaultValue = newValue
                                                
                                            }
                                        ))
                                        .padding(10)
                                        .frame(width: 350,height: 50)
                                        .font(isFontMedium(size: 18))
                                        .autocapitalization(.none)
                                        .autocorrectionDisabled()
                                        .background(Color.gray.opacity(0.2))
                                        .foregroundColor(.black)
                                        .cornerRadius(8)
                                    }
                                    
                                    if field.type == "textarea" {
                                        
                                        Text("\(templateOptions?.label ?? "") \(templateOptions?.required ?? false ? "*" : "")")
                                            .halfTextColorChange(fullText: "\(templateOptions?.label ?? "") \(templateOptions?.required ?? false ? "*" : "")", changeText: "*")
                                            .font(isFontMedium(size: 18))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading)
                                            .padding(.top,10)
                                        
                                        
                                        TextField("\(templateOptions?.placeholder ?? "")", text: Binding<String>(
                                            get: {
                                                field.defaultValue ?? ""
                                                
                                            },
                                            set: { newValue in
                                                field.defaultValue = newValue
                                                
                                            }
                                        ),axis: .vertical)
                                        .padding(10)
                                        .frame(width: 350)
                                        .lineLimit(5, reservesSpace: true)
                                        .autocapitalization(.none)
                                        .autocorrectionDisabled()
                                        .font(isFontMedium(size: 18))
                                        .autocapitalization(.none)
                                        .autocorrectionDisabled()
                                        .background(Color.gray.opacity(0.2))
                                        .foregroundColor(.black)
                                        .cornerRadius(8)
                                    }
                                    
                                    
                                    if field.type == "select" {
                                        
                                        Text("\(templateOptions?.label ?? "") \(templateOptions?.required ?? false ? "*" : "")")
                                            .halfTextColorChange(fullText: "\(templateOptions?.label ?? "") \(templateOptions?.required ?? false ? "*" : "")", changeText: "*")
                                            .font(isFontMedium(size: 18))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading)
                                            .padding(.top,10)
                                        
                                        TextField("\(templateOptions?.placeholder ?? "")", text: Binding<String>(
                                            get: {
                                                field.defaultValue ?? ""
                                                
                                            },
                                            set: { newValue in
                                                field.defaultValue = newValue
                                            }
                                        ))
                                        .disabled(true)
                                        .padding(10)
                                        .frame(width: 350,height:50)
                                        .autocapitalization(.none)
                                        .autocorrectionDisabled()
                                        .font(isFontMedium(size: 18))
                                        .autocapitalization(.none)
                                        .autocorrectionDisabled()
                                        .background(Color.gray.opacity(0.2))
                                        .foregroundColor(.black)
                                        .cornerRadius(8)
                                        .overlay(
                                            
                                            Image(systemName: "chevron.down")
                                                .padding(.trailing,10)
                                                .bold()
                                                .foregroundColor(.black)
                                                .font(isFontMedium(size: 20))
                                                .frame(maxWidth: .infinity,alignment:.trailing)
                                                .padding(.trailing)
                                            
                                        )
                                        .onTapGesture {
                                            withAnimation {
                                                isDropdownOpen.toggle()
                                                selectedField = field.key ?? ""
                                            }
                                        }
                                    }
                                    
                                    
                                    if field.type == "datepicker" {
                                        
                                        Text("\(templateOptions?.label ?? "") \(templateOptions?.required ?? false ? "*" : "")")
                                            .halfTextColorChange(fullText: "\(templateOptions?.label ?? "") \(templateOptions?.required ?? false ? "*" : "")", changeText: "*")
                                            .font(isFontMedium(size: 18))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading)
                                            .padding(.top,10)
                                        
                                        TextField("\(templateOptions?.placeholder ?? "")", text: Binding<String>(
                                            get: {
                                                field.defaultValue ?? ""
                                                
                                            },
                                            set: { newValue in
                                                field.defaultValue = newValue
                                            }
                                        ))
                                        .disabled(true)
                                        .padding(10)
                                        .frame(width: 350,height:50)
                                        .autocapitalization(.none)
                                        .autocorrectionDisabled()
                                        .font(isFontMedium(size: 18))
                                        .autocapitalization(.none)
                                        .autocorrectionDisabled()
                                        .background(Color.gray.opacity(0.2))
                                        .foregroundColor(.black)
                                        .cornerRadius(8)
                                        .onTapGesture {
                                            isShowingDatePicker = true
                                            selectedField = field.key ?? ""
                                        }
                                        
                                        
                                        if selectedField == field.key ?? ""  {
                                            if isShowingDatePicker {
                                                Button("Done") {
                                                    isShowingDatePicker = false
                                                }
                                                .bold()
                                                .font(.system(size: 18))
                                                .frame(maxWidth: .infinity,alignment: .trailing)
                                                .padding(.trailing)
                                                
                                            }
                                            
                                            if isShowingDatePicker {
                                                DatePicker(
                                                    "Select a Date",
                                                    selection: Binding(
                                                        get: {
                                                            selectedDate ?? Date()
                                                        },
                                                        set: { newValue in
                                                            selectedDate = newValue
                                                            
                                                            field.defaultValue = dateFormatter.string(from: newValue)
                                                        }
                                                    ),
                                                    in: ...Date(),
                                                    displayedComponents: [.date]
                                                )
                                                .datePickerStyle(.wheel)
                                                .labelsHidden()
                                                .onChange(of: selectedDate) { newValue in
                                                    if let date = newValue {
                                                       
                                                        field.defaultValue = dateFormatter.string(from: date)
                                                        
                                                    } else {
                                                        field.defaultValue = ""
                                                        
                                                    }
                                                }
                                                .onTapGesture {
                                                    isShowingDatePicker = false
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    VStack {
                        
                        Button(action: {
                            
                        }) {
                            Text("SUBMIT")
                                .padding(.top)
                                .frame(maxWidth: .infinity)
                                .background(toolbarcolor)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .font(isFontBold(size: 20))
                        }
                        
                    }
                }
                .onAppear {
                    fetchAssetsAddNewPerson()
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
                                    navigateAssetsNewPersonPage = false
                                }
                            })
                            {
                                
                                Image(systemName: "arrow.backward")
                                    .bold()
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .padding(.bottom)
                                
                            }
                            
                            Text("New Person")
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
        
            .overlay {
                if isDropdownOpen {
                    
                    Color.black.opacity(0.1)
                        .ignoresSafeArea(.all)
                        .onTapGesture {
                            isDropdownOpen = false
                        }
                    
                    ZStack {
                        
                        VStack {
                            Spacer()
                            List {
                                
                                ForEach(newPersonArrayDetails, id: \.key) { field in
                                    if let templateOptions = field.templateOptions,
                                       let options = templateOptions.options {
                                        
                                        if selectedField == field.key ?? ""  {
                                            ForEach(options, id: \.value) { option in
                                                
                                                Button(action: {
                                                    
                                                    isDropdownOpen = false
                                                    field.defaultValue = option.label
                                                    
                                                }) {
                                                    Text(option.label)
                                                        .padding(10)
                                                        .foregroundColor(.black)
                                                        .frame(maxWidth:.infinity,alignment:.leading)
                                                }
                                            }
                                        }
                                    }
                                }
                                .listRowSeparator(.hidden)
   
                        }
                        .listStyle(.plain)
                        .frame(width: 300)
                        .cornerRadius(0)
                        .shadow(radius: 3)
                            
                            Spacer()
                        }
                        .frame(height:400)
                        .offset(y: isDropdownOpen ? 125 : 0)
                        
                    }
                    
                }
            }
    
    }
    
    
    
    
    func fetchAssetsAddNewPerson() {
        
        isLoading = true
        
        let parameters: [String: Any] = [
            "assetTypeID":"9acde0c7-5117-49b9-bfe4-070aae791c1a",
            "policyID":assetsTypeId
            ]

        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(BaseURL)")!,
                                         path: "api/digital/core/Form/GetFormByQuotation",
                                         method: "POST",bodyData:parameters)
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<AssetsAddNewPersonResponse, Error>) in
            switch result {
            case .success(let Response):
                // Handle success
                DispatchQueue.main.async {
                    
                    if Response.rcode == 200 {
                        print(Response.rcode)
                        
                        newPersonArrayDetails = Response.rObj.formFieldList.fieldGroup
                        
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
//        let url = URL(string: "\(BaseURL)api/digital/core/Form/GetFormByQuotation")!
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
//            
//            "assetTypeID":"9acde0c7-5117-49b9-bfe4-070aae791c1a",
//            "policyID":assetsTypeId
//            
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
//                print("Assets New Person Response = \(String(describing: resultDictionary))")
//                
//                let decoder = JSONDecoder()
//                let Response = try decoder.decode(AssetsAddNewPersonResponse.self, from: data)
//                
//                DispatchQueue.main.async {
//                    
//                    if Response.rcode == 200 {
//                        print(Response.rcode)
//                        
//                        newPersonArrayDetails = Response.rObj.formFieldList.fieldGroup
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


struct AssetsNewPerson_Previews: PreviewProvider {
    static var previews: some View {
        AssetsNewPerson(navigateAssetsNewPersonPage:.constant(false))
    }
}
