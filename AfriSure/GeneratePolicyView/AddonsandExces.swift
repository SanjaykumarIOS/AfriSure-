
import SwiftUI


struct AddonsandExces: View {
    
    @Binding var navigateAddonExcessPage: Bool
    
    @State var addonExcessDetailArray: [AddonsExcessResponse.AddonsExcessValues.FormField] = []
    @State private var selectedDropdownValue: String = ""
   
    @State var selectedCustomFormField = ""
    @State private var isDropdownOpen = false
    
    @State var selectedItem = Set<String>()
    @State var addonVisibilityKeys = Set<String>()
    @State var textAnswers: [String: String] = [:]
    @State var selectedAddonAnswers: [String: Bool] = [:]
    
    @State var isDefaultValue = false
    
    @State var navigateGeneratePolicyPage = false
    
    @State private var alertItem: AlertItem?
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack {
            LoadingView(isShowing: $isLoading) {
                VStack {
                    
                    ScrollView {
                        VStack {
                            
                            Text("Addons")
                                .font(isFontMedium(size: 22))
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                                .padding(.top)
                            
                            VStack {
                                
                                
                                ForEach(addonExcessDetailArray.indices, id: \.self) { index in
                                    let form = addonExcessDetailArray[index]
                                    
                                    ForEach(form.fieldGroup.indices, id: \.self) { fieldIndex in
                                        let product = form.fieldGroup[fieldIndex]
                                        
                                        if product.key?.hasPrefix("ADDON") == true && product.type == "checkbox" && product.templateOptions != nil {
                                            if let key = product.key, let templateOptions = product.templateOptions {
                                                Button(action: {
                                                    
                                                    if selectedItem.contains(templateOptions.label) {
                                                        selectedItem.remove(templateOptions.label)
                                                        selectedAddonAnswers[key] = false
                                                        addonVisibilityKeys.remove("model.\(key)!== true")
                                                        
                                                        if let hideExpression = product.expressionProperties?.hide, !addonVisibilityKeys.contains(hideExpression) {
                                                            textAnswersParameters[key] = ""
                                                        }
                                                        
                                                    } else {
                                                        selectedItem.insert("\(templateOptions.label)")
                                                        addonVisibilityKeys.insert("model.\(key)!== true")
                                                        selectedAddonAnswers[key] = true
                                                    }
                                                    
                                                }) {
                                                    HStack(alignment:.top) {
                                                        Image(systemName: selectedItem.contains(templateOptions.label) ? "checkmark.square.fill" : "square")
                                                            .bold()
                                                            .font(isFontMedium(size: 20))
                                                            .foregroundColor( selectedItem.contains(templateOptions.label) ? fontOrangeColour : .black)
                                                            .padding(.top)
                                                        
                                                        Text(templateOptions.label)
                                                            .font(isFontMedium(size: 18))
                                                            .foregroundColor(.black)
                                                            .multilineTextAlignment(.leading)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                            .padding(.top)
                                                    }
                                                    .padding(.leading)
                                                }
                                                .onAppear {
                                                    // Set the initial state based on defaultValue
                                                    if let defaultValue = product.defaultValue {
                                                        selectedItem.insert("\(templateOptions.label)")
                                                        addonVisibilityKeys.insert("model.\(key)!== true")
                                                        selectedAddonAnswers[key] = defaultValue
                                                    }
                                                }
                                            }
                                            
                                        }
                                        
                                        if addonVisibilityKeys.contains(product.expressionProperties?.hide ?? "") {
                                        
                                            if let subFieldGroup = product.fieldGroup {
                                                
                                                ForEach(subFieldGroup.indices, id: \.self) { subFieldIndex in
                                                    let subField = subFieldGroup[subFieldIndex]
                                                    
                                                    if let templateOptions = subField.templateOptions {
                                                        
                                                        VStack(spacing:10) {
                                                            if subField.type ?? "" == "select" {
                                                                Text("\(templateOptions.label) \(templateOptions.required ? "*" : "")")
                                                                    .halfTextColorChange(fullText: "\(templateOptions.label) \(templateOptions.required ? "*" : "")", changeText: "*")
                                                                    .font(isFontMedium(size: 18))
                                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                                    .padding(.leading)
                                                                    .padding(.top,10)
                                                                
                                                                TextField("\(templateOptions.placeholder ?? "")", text: Binding<String>(
                                                                    get: {
                                                                        subField.defaultValue ?? ""
                                                                        
                                                                    },
                                                                    set: { newValue in
                                                                        subField.defaultValue = newValue
                                                                        
                                                                    }
                                                                ))
                                                                .disabled(true)
                                                                .padding(.trailing,25)
                                                                .padding(10)
                                                                .frame(width: 350,height: 50)
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
                                                                        isDropdownOpen = true
                                                                        selectedCustomFormField = subField.key ?? ""
                                                                    }
                                                                }
                                                            }
                                                            
                                                            if subField.type ?? "" == "input" {
                                                                Text("\(templateOptions.label) \(templateOptions.required ? "*" : "")")
                                                                    .halfTextColorChange(fullText: "\(templateOptions.label) \(templateOptions.required ? "*" : "")", changeText: "*")
                                                                    .font(isFontMedium(size: 18))
                                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                                    .padding(.leading)
                                                                    .padding(.top,10)
                                                                
                                                                TextField("\(templateOptions.placeholder ?? "")", text: Binding<String>(
                                                                    get: {
                                                                        subField.defaultValue ?? ""
                                                                        
                                                                    },
                                                                    set: { newValue in
                                                                        
                                                                        subField.defaultValue = newValue
                                                                        
                                                                        if addonVisibilityKeys.contains(product.expressionProperties?.hide ?? "") {
                                                                            textAnswersParameters[subField.key ?? ""] = newValue
                                                                        } else {
                                                                            textAnswersParameters[subField.key ?? ""] = ""
                                                                        }
                                                                        
                                                                    }
                                                                ))
                                                                .padding(.trailing,25)
                                                                .padding(10)
                                                                .frame(width: 350,height: 50)
                                                                .font(isFontMedium(size: 18))
                                                                .autocapitalization(.none)
                                                                .autocorrectionDisabled()
                                                                .background(Color.gray.opacity(0.2))
                                                                .foregroundColor(.black)
                                                                .cornerRadius(8)
                                                                
                                                            }
                                                        }
                                                    }
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
                          addonsExcessValidation()
                           
                        }) {
                            Text("Submit")
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
                    fetchAddonsandExcess()
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
                                    navigateAddonExcessPage = false
                                }
                            })
                            {
                                
                                Image(systemName: "arrow.backward")
                                    .bold()
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .padding(.bottom)
                                
                            }
                            
                            Text("Addons and Excess")
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
                            
                            ForEach(addonExcessDetailArray.indices, id: \.self) { index in
                                let form = addonExcessDetailArray[index]
                                
                                ForEach(form.fieldGroup.indices, id: \.self) { fieldIndex in
                                    let product = form.fieldGroup[fieldIndex]
                                    
                                    if addonVisibilityKeys.contains(product.expressionProperties?.hide ?? "") {
                                        
                                        if let subFieldGroup = product.fieldGroup {
                                            
                                            ForEach(subFieldGroup.indices, id: \.self) { subFieldIndex in
                                                let subField = subFieldGroup[subFieldIndex]
                                                
                                                if selectedCustomFormField == subField.key ?? ""  {
                                                    
                                                    ForEach(subField.templateOptions?.options ?? [], id: \.label) { option in
                                                        
                                                        Button(action: {
                                                            
                                                            subField.defaultValue = option.label
                                                            textAnswersParameters[subField.key ?? ""] = option.value
                                                            isDropdownOpen = false
                                                            
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
                                    }
                                }.listRowSeparator(.hidden)
                            }
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
    
    
    func addonsExcessValidation() {
        for productValues in addonExcessDetailArray {
            for formField in productValues.fieldGroup {
                if let key = formField.key, let templateOptions = formField.templateOptions, let option = templateOptions.options {
                    let answer = formField.defaultValue
                    
//                    if templateOptions.required && (answer.isEmpty) && !templateOptions.label.isEmpty {
//                        if templateOptions.type == "select" {
//                            if !option.isEmpty {
//                                if let validation = formField.validation {
//                                    self.alertItem = AlertItem(title: Text(validation.messages.required ?? ""))
//                                    return
//                                }
//                            }
//                        } else {
//                            if let validation = formField.validation {
//                                self.alertItem = AlertItem(title: Text(validation.messages.required ?? ""))
//                                return
//                            }
//                        }
//                    }
                }
                
                if let fieldGroup = formField.fieldGroup {
                    for value in fieldGroup {
                        if formField.key == nil {
                            if let templateOptions = value.templateOptions {
                                let key = value.key ?? ""
//                                let answer = textAnswers[key]?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                                let answer = value.defaultValue
                                
                                if addonVisibilityKeys.contains(formField.expressionProperties?.hide ?? "") {
                                    if templateOptions.required && (answer?.isEmpty ?? true) {
                                        if let validation = value.validation {
                                            self.alertItem = AlertItem(title: Text(validation.messages.required ?? ""))
                                            return
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        fetchInsertAddonsandExcess()
    }
    
    
    func fetchAddonsandExcess() {
        
        isLoading = true
        
        let parameters: [String: Any] = [
            "policyGroupID": Extensions.policyID
            
            ]

        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(BaseURL)")!,
                                         path: "api/digital/core/Policy/FetchAllPolicyExtras",
                                         method: "POST",bodyData:parameters)
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<AddonsExcessResponse, Error>) in
            switch result {
            case .success(let Response):
                // Handle success
                DispatchQueue.main.async {
                    
                    if Response.rcode == 200 {
                        print(Response.rcode)
                        
                        addonExcessDetailArray = Response.rObj.getAllAPIFormaly1

                        
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
//        let url = URL(string: "\(BaseURL)api/digital/core/Policy/FetchAllPolicyExtras")!
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
//            "policyGroupID": Extensions.policyID
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
//                print("Addons Excess Response = \(String(describing: resultDictionary))")
//                
//                let decoder = JSONDecoder()
//                let Response = try decoder.decode(AddonsExcessResponse.self, from: data)
//                
//                DispatchQueue.main.async {
//                    
//                    if Response.rcode == 200 {
//                        print(Response.rcode)
//                        
//                        addonExcessDetailArray = Response.rObj.getAllAPIFormaly1
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
    
    
    
    func fetchInsertAddonsandExcess() {
        isLoading = true
        let url = URL(string: "\(BaseURL)api/digital/core/Policy/UpdatePolicyExtras")!
        print(url)
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        
        let authToken:String! = "Bearer " + Extensions.token
        
        request.addValue(authToken, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print(authToken as Any)
        
        var informationsParameters: [String: Any] = [:]
        var viewJsonParametersList: [[String: Any]] = []
        
        for productValues in addonExcessDetailArray {
            for formField in productValues.fieldGroup {
                if let key = formField.key, let templateOptions = formField.templateOptions {
                    let answer = formField.defaultValue
                    
                    let inputInformationJson: [String: Any] = [
                        "\(key)" : "\(answer ?? true)"
                    ]
                    
                    informationsParameters.merge(inputInformationJson) { (_, new) in new }
                    
                    
                    let templateOptionsParameters: [String: Any] = [
                        "label": templateOptions.label ,
                        "disabled": isDefaultValue
                    ]
                    
                    let viewJsonParameters = [
                        "Key": key ,
                        "defaultValue": answer ?? "",
                        "type": formField.type ?? "",
                        "templateOptions": templateOptionsParameters,
                        "wrappers": formField.wrappers ?? "",
                        "className": formField.className ?? ""
                    ] as [String : Any]
                    
                    
                    viewJsonParametersList.append(viewJsonParameters)
                }
                
                if let fieldGroup = formField.fieldGroup {
                    for value in fieldGroup {
                        if let templateOptions = value.templateOptions {
                            let key = value.key ?? ""
                            let answer = value.defaultValue
                            
                            let inputInformationJson: [String: Any] = [
                                "\(key)" : "\(answer ?? "")"
                            ]
                            
                            informationsParameters.merge(inputInformationJson) { (_, new) in new }
                            
                            let templateOptionsParameters: [String: Any] = [
                                "label": templateOptions.label,
                                "disabled": isDefaultValue
                            ]
                            
                            let viewJsonParameters = [
                                "Key": key ,
                                "defaultValue": answer ?? "",
                                "type": value.type ?? "",
                                "templateOptions": templateOptionsParameters,
                                "wrappers": value.wrappers ?? "",
                                "className": value.className ?? ""
                            ] as [String : Any]
                            
                            viewJsonParametersList.append(viewJsonParameters)
                            
                        }
                    }
                }
            }
        }
               
        
           let viewJsonString: [String: Any] = [
               "filed": viewJsonParametersList
           ]
         
           var viewJsonStringForInput = ""
         
           do {
               let jsonData = try JSONSerialization.data(withJSONObject: viewJsonString, options: [])
               if let jsonString = String(data: jsonData, encoding: .utf8) {
                   // Now you have the JSON string representation in 'jsonString'
                   print(jsonString)
                   viewJsonStringForInput = jsonString
               }
           } catch {
               print("Error converting dictionary to JSON: \(error)")
           }
        
        let parameters: [String: Any] = [
            "policyGroupID": Extensions.policyID,
            "information": informationsParameters,
            "viewJson":viewJsonStringForInput
            ]
        
       
        
        print("informationsParameters --- > \(informationsParameters)")
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
                print("Insert Addons Excess Response = \(String(describing: resultDictionary))")
                
                
                DispatchQueue.main.async {
                    
                    let rcode = resultDictionary["rcode"] as? Int
                    if rcode == 200 {
                        print(rcode)
                        isLoading = false
                        withAnimation {
                            navigateAddonExcessPage = false
                        }
                    } else {
                        
                        if let rmsg = resultDictionary["rmsg"] as? [NSDictionary] {
                            for message in rmsg {
                                if let errorText = message["errorText"] as? String {
                                    self.alertItem = AlertItem(title: Text(errorText))
                                }
                                if let errorCode = message["errorCode"] as? String {
                                    print("errorCode: \(errorCode)")
                                }
                                if let fieldName = message["fieldName"] as? String {
                                    print("fieldName: \(fieldName)")
                                }
                                if let fieldValue = message["fieldValue"] as? String {
                                    print("fieldValue: \(fieldValue)")
                                }
                            }
                        }
                        
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
    }
}

struct AddonsandExces_Previews: PreviewProvider {
    static var previews: some View {
        AddonsandExces(navigateAddonExcessPage:.constant(false))
    }
}
