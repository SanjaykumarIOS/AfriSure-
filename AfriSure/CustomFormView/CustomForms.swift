

import SwiftUI

var textAnswers: [String: String] = [:]
var textAnswersParameters: [String: String] = [:]
var textAnswersValueParameters: [String: String] = [:]
var textAddonAnswers: [[String]: [String]] = [:]
var textExcessAnswers: [[String]: [String]] = [:]
var selectedItems = Set<String>()
var selectedAddonAnswers: [String: Bool] = [:]
var addonVisibilityKeys = Set<String>()
var excessVisibilityKeys = Set<String>()
var quotationSearchID = ""

var getCustomFormArray: [GetAllAPIFormalyJsonResponse.FieldGroup] = []

struct SelectedItem {
    let key: String
    let value: String
}

struct CustomForms: View {
    
    @Binding var navigateCustomPage: Bool
        
//    @State var getProductDetailArray: [GetProductsResponse.GetProductValues.FormField] = []
    
    @State var getCustomFormArray: [GetAllAPIFormalyJsonResponse.FieldGroup] = []
    
    @State var addonVisibilityArray: [(label: String?, key: String?, type: String?, hide: String?, required: Bool, options: [GetAllAPIFormalyJsonResponse.FieldGroup.TemplateOptions.Option]?, placeholder: String?, validation: GetAllAPIFormalyJsonResponse.FieldGroup.Validation?)] = []
    
    @State var excessVisibilityArray: [(label: String?, key: String?, type: String?, hide: String?, required: Bool, options: [GetAllAPIFormalyJsonResponse.FieldGroup.TemplateOptions.Option]?, placeholder: String?, validation: GetAllAPIFormalyJsonResponse.FieldGroup.Validation?)] = []
 
    @State private var addonsTextDisplayed = false
    @State private var excessTextDisplayed = false
    @State var showAddonPopup = false
    @State var showExcessPopup = false
    @State var addonKeys: [String] = []
    @State var excessKeys: [String] = []
    @State var addonSelectedItem = Set<String>()
    @State var excessSelectedItem = Set<String>()
    
    @State var selectedItem: Set<String> = []
    
    @State private var shouldContinueLoop = true 
    
   @State var labelsArray: [String] = []
    
    @State var selectedCustomFormField = ""
    @State private var isDropdownOpen = false
    
    @State var selectedDate: Date?
    @State private var isShowingDatePicker = false
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        return formatter
    }()
    
    @State private var showProductPopUp = false
    
    @State var navigateQuotationPage = false
    @State var navigateLineofBusinessPage = false
    @State var navigateUserInformationPage = false
    @State private var alertItem: AlertItem?
    @State private var isLoading = false
    
    @State var masterDataApiUrl = ""
    @State var masterDataInputParameter = ""
    @State var vehicleMakeID = ""
    @State var mdCategoryID = ""
    
    @State var masterDataArray: [MasterDataResponse.MasterDataRObj.MasterData] = []
    
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some View {
        NavigationStack {
            LoadingView(isShowing: $isLoading) {
                VStack {
                    
                    ZStack {
                        
                        HStack {
                           
                            Spacer()
                            VStack(alignment: .center) {
                                Text("Quotation ID")
                                    .font(isFontMedium(size: 19))
                                
                                Text(Extensions.quotationID)
                                    .font(isFontMedium(size: 17))
                                    .foregroundColor(inkBlueColour)
                                    .padding(.top,1)
                            }
                            .padding(.leading)
                            Spacer()
//                            NavigationLink("",destination: InsuranceOptionView(navigateInsuranceOptiondPage : .constant(false)),isActive: $navigateLineofBusinessPage)
                            
                            Image(systemName: "square.and.pencil")
                                .bold()
                                .font(.system(size: 24))
                                .foregroundColor(inkBlueColour)
                                .padding(.trailing)
                                .onTapGesture {
                                    
                                    withAnimation {
                                        navigateLineofBusinessPage = true
                                    }
                                    
                                    Extensions.selectedItem = Set<String>()
                                    
                                    textAnswers = [:]
                                    textAnswersParameters = [:]
                                    textAddonAnswers = [:]
                                    selectedItems = Set<String>()
                                    addonVisibilityKeys = Set<String>()
                                    selectedAddonAnswers = [:]

                                }
                        }
                    }
                    .frame(width:360)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top,8)
                    .padding(.bottom,8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.top,10)
                    
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
                              
                                
                            }
                            
                            
                        }
                        .frame(width:175,height: Extensions.selectedItem.count == 1 ? 40 : 50,alignment: .top)
                        .padding(.top,10)
                        .padding(.bottom,10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.trailing)
                        
                    }
                    
                    ScrollView {
                        VStack {
                            
                            VStack {
                                ForEach(Array(getCustomFormArray.enumerated()), id: \.element.orderData) { index, product in

                                    let key = product.key
                                    
                                    if product.type == "input" ,let templateOptions = product.templateOptions {
                                        let labelText = "\(templateOptions.label ?? "") \(templateOptions.required ? "*" : "")"
                                        Text(labelText)
                                            .halfTextColorChange(fullText: labelText, changeText: "*")
                                            .font(isFontMedium(size: 18))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading)
                                            .padding(.top,10)
                                        
                                        TextField("\(templateOptions.placeholder ?? "")", text: Binding<String>(
                                            get: {
                                                product.defaultValue ?? ""
                                            },
                                            set: { newValue in
                                                
                                                product.defaultValue = newValue
                                                textAnswersParameters[product.key ?? ""] = newValue
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
                                    
                                    
                                    if let hideExpression = product.expressionProperties?.hide {
                                        let expression = hideExpression.replacingOccurrences(of: "'", with: "")
                                        if selectedItem.contains(expression) {
                                            
                                            if let fieldGroup = product.fieldGroup {
                                                ForEach(fieldGroup, id: \.key) { subField in
                                                    
                                                    if let templateOptions = subField.templateOptions {
                                                        
                                                        VStack(spacing:10) {
                                                            let labelText = "\(templateOptions.label ?? "") \(templateOptions.required ? "*" : "")"
                                                            
                                                            if subField.type ?? "" == "select" {
                                                                Text(labelText)
                                                                    .halfTextColorChange(fullText: labelText, changeText: "*")
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
                                                                        selectedCustomFormField = "\(subField.orderData ?? 0)"
                                                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    
                                    
                                    if product.type == "select" ,let templateOptions = product.templateOptions {
                                        
                                        let labelText = "\(templateOptions.label ?? "") \(templateOptions.required ? "*" : "")"
                                        Text(labelText)
                                            .halfTextColorChange(fullText: labelText, changeText: "*")
                                            .font(isFontMedium(size: 18))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading)
                                            .padding(.top,10)
                                        
                                        TextField("\(templateOptions.placeholder ?? "")", text: Binding<String>(
                                            get: {
                                                product.defaultValue ?? ""
                                            },
                                            set: { newValue in
                                                
                                                product.defaultValue = newValue
                                                textAnswersParameters[product.key ?? ""] = newValue
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
                                                isDropdownOpen.toggle()
                                                selectedCustomFormField = product.key ?? ""
 
                                                mdCategoryID = templateOptions.cascadingParentControl ?? ""
                                                
                                                if index + 1 < getCustomFormArray.count {
                                                    let nextProduct = getCustomFormArray[index + 1]
                                                    
                                                    if product.key == nextProduct.templateOptions?.cascadingParentControl {
                                                        masterDataApiUrl = nextProduct.templateOptions?.apiUrl ?? ""
                                                        masterDataInputParameter = nextProduct.templateOptions?.inputParameter ?? ""
                                                        
                                                        
                                                        print("apiUrl ---> \(nextProduct.templateOptions?.apiUrl ?? "")")
                                                    }
                                                }

                                                
                                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                            }
                                        }
                                        
                                    }
                                    
                                    
                                    if product.type == "datepicker" ,let templateOptions = product.templateOptions {
                                        
                                        let labelText = "\(templateOptions.label ?? "") \(templateOptions.required ? "*" : "")"
                                        
                                        Text(labelText)
                                            .halfTextColorChange(fullText: labelText, changeText: "*")
                                            .font(isFontMedium(size: 18))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading)
                                            .padding(.top,10)
                                        
                                        TextField("\(templateOptions.placeholder ?? "")", text: Binding<String>(
                                            get: {
                                                product.defaultValue ?? ""
                                            },
                                            set: { newValue in
                                                
                                                product.defaultValue = newValue
                                                textAnswersParameters[product.key ?? ""] = newValue
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
                                        .onTapGesture {
                                            isShowingDatePicker = true
                                            selectedCustomFormField = product.key ?? ""
                                            selectedDate = nil
                                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                        }
                                        
                                        if selectedCustomFormField == product.key ?? ""  {
                                            if isShowingDatePicker {
                                                Button("Done") {
                                                    isShowingDatePicker = false
                                                }
                                                .bold()
                                                .font(.system(size: 18))
                                                .frame(maxWidth: .infinity, alignment: .trailing)
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
                                                            product.defaultValue = dateFormatter.string(from: newValue)
                                                            textAnswersParameters[product.key ?? ""] = dateFormatter.string(from: newValue)
                                                        }
                                                    ),
                                                    displayedComponents: [.date]
                                                )
                                                .datePickerStyle(.wheel)
                                                .labelsHidden()
                                                .onChange(of: selectedDate) { newValue in
                                                    if let date = newValue {
                                                        product.defaultValue = dateFormatter.string(from: date)
                                                        textAnswersParameters[product.key ?? ""] = dateFormatter.string(from: date)
                                                    } else {
                                                        product.defaultValue = ""
                                                        textAnswersParameters[product.key ?? ""] = ""
                                                    }
                                                }
                                                .onTapGesture {
                                                    isShowingDatePicker = false
                                                }
                                            }

                                        }
                                        
                                    }
                                    
                                }
                                
                                if addonsTextDisplayed {
                                    VStack(spacing:10) {
                                        Text("Addons")
                                            .font(isFontMedium(size: 18))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading)
                                            .padding(.top,10)
                                        
                                        TextField("Select ", text: Binding<String>(
                                            get: {
                                                textAddonAnswers[addonKeys]?.joined(separator: ",") ?? ""
                                                
                                            },
                                            set: { newValue in
                                                textAddonAnswers[addonKeys] = newValue.components(separatedBy: ",")
                                                
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
                                            showAddonPopup.toggle()
                                           
                                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                        }
                                        
                                        
                                        
                                        
                                        ForEach(getCustomFormArray, id: \.orderData) { product in
                                         
                                            if addonVisibilityKeys.contains(product.expressionProperties?.hide ?? "") {
                                            if let fieldGroup = product.fieldGroup {
                                                ForEach(fieldGroup, id: \.key) { subField in
                                                    
    //                                                ForEach(fieldGroup.indices, id: \.self) { subFieldIndex in
    //                                                    let subField = fieldGroup[subFieldIndex]
                                                    
                                                    if let templateOptions = subField.templateOptions {
                                                        
                                                        VStack(spacing:10) {
                                                            let labelText = "\(templateOptions.label ?? "") \(templateOptions.required ? "*" : "")"
                                                            
                                                            if subField.type ?? "" == "select" {
                                                                Text(labelText)
                                                                    .halfTextColorChange(fullText: labelText, changeText: "*")
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
                                                                        selectedCustomFormField = "\(subField.orderData ?? 0)"
                                                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                                                    }
                                                                }
                                                            }
                                                            
                                                            if subField.type ?? "" == "input" {
                                                                Text(labelText)
                                                                    .halfTextColorChange(fullText: labelText, changeText: "*")
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
                                
                                
                                VStack {
                                    
                                    if excessTextDisplayed {
                                        VStack(spacing:10) {
                                            Text("Excess")
                                                .font(isFontMedium(size: 18))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(.leading)
                                                .padding(.top,10)
                                            
                                            TextField("Select ", text: Binding<String>(
                                                get: {
                                                    textExcessAnswers[excessKeys]?.joined(separator: ",") ?? ""
                                                    
                                                },
                                                set: { newValue in
                                                    textExcessAnswers[excessKeys] = newValue.components(separatedBy: ",")
                                                    
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
                                                showExcessPopup.toggle()
                                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                            }
                                            
                                            
                                            ForEach(getCustomFormArray, id: \.orderData) { product in
                                             
                                                if excessVisibilityKeys.contains(product.expressionProperties?.hide ?? "") {
                                                if let fieldGroup = product.fieldGroup {
                                                    ForEach(fieldGroup, id: \.key) { subField in
                                                        
        //                                                ForEach(fieldGroup.indices, id: \.self) { subFieldIndex in
        //                                                    let subField = fieldGroup[subFieldIndex]
                                                        
                                                        if let templateOptions = subField.templateOptions {
                                                            
                                                            VStack(spacing:10) {
                                                                let labelText = "\(templateOptions.label ?? "") \(templateOptions.required ? "*" : "")"
                                                                
                                                                if subField.type ?? "" == "select" {
                                                                    Text(labelText)
                                                                        .halfTextColorChange(fullText: labelText, changeText: "*")
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
                                                                            selectedCustomFormField = "\(subField.orderData ?? 0)"
                                                                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                                                        }
                                                                    }
                                                                }
                                                                
                                                                if subField.type ?? "" == "input" {
                                                                    Text(labelText)
                                                                        .halfTextColorChange(fullText: labelText, changeText: "*")
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
                                                                            
                                                                            if excessVisibilityKeys.contains(product.expressionProperties?.hide ?? "") {
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
                        }
                        .padding(.top)

                    }
                    

                    VStack {
//                        NavigationLink("", destination: QuotationPage(), isActive: $navigateQuotationPage)
                        
                        Button(action: {
                            customFormValidation()
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                           
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
                .onAppear {
                    fetchGetCustomForm()
                    addonSelectedItem =  selectedItems
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
                                navigateUserInformationPage = true
                                textAnswers = [:]
                                textAnswersParameters = [:]
                                textAddonAnswers = [:]
                                selectedItems = Set<String>()
                                addonVisibilityKeys = Set<String>()
                                selectedAddonAnswers = [:]
                                
                                withAnimation {
                                    navigateCustomPage = false
                                }
                            })
                            {
                                
                                Image(systemName: "arrow.backward")
                                    .bold()
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .padding(.bottom)
                                
                            }
                            
                            Text("Custom Forms")
                                .bold()
                                .font(isFontBlack(size: 22))
                                .foregroundColor(.white)
                                .padding(.bottom,8)
                            
//                            NavigationLink("", destination: UserInformationView(), isActive: $navigateUserInformationPage)
                        }
                    }
                }
                .toolbarBackground(toolbarcolor,for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .navigationBarBackButtonHidden()
        
        .overlay (
            navigateQuotationPage ? QuotationPage(navigateQuotationPage: $navigateQuotationPage) : nil
        )
        
        .overlay (
            navigateLineofBusinessPage ? LineOfBusinessView(navigateInsuranceOptiondPage: .constant(false)) : nil
        )
        
        .overlay(
            !networkMonitor.isConnected ? ErrorView() : nil
        )
        
        .overlay {
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

            
            if isDropdownOpen {
                ZStack {
                    Color.black.opacity(0.1)
                        .ignoresSafeArea(.all)
                        .onTapGesture {
                            isDropdownOpen = false
                        }
                    
                    VStack {
                        Spacer()
                        
                        List {
                            
                            ForEach(Array(getCustomFormArray.enumerated()), id: \.element.orderData) { index, product in
                                if selectedCustomFormField == product.key ?? "" {
                                    
                                    ForEach(product.templateOptions?.options ?? [], id: \.label) { option in
                                        
                                        Button(action: {
                                            product.defaultValue = option.label
                                            textAnswersParameters[product.key ?? ""] = option.value

                                            print(selectedItem)
                                            
                                             let hide = product.expressionProperties?.hide ?? ""
                                                
                                            print(hide)
                                            
                                            
                                            if selectedCustomFormField == "InsuredGenderID" {
                                                if let field = getCustomFormArray.first(where: {$0.expressionProperties?.hide?.replacingOccurrences(of: "'", with: "") == "model.\(product.key ?? "")!==\(option.value)"}) {
                                                    print("Hide Name --- > \(field)")
                                                    
                                                    // Insert the new value
                                                    selectedItem.insert("model.\(product.key ?? "")!==\(option.value)")
                                                } else {
                                                    // Clear the selectedItem set
                                                    selectedItem.removeAll()
                                                }
                                            }
                                            
 
                                            if var key = product.key {
                                                key = key.replacingOccurrences(of: "ID", with: "")
                                                textAnswersValueParameters[key] = option.label
                                            }
                                            
                                            if index + 1 < getCustomFormArray.count {
                                                let nextProduct = getCustomFormArray[index + 1]
                                                
                                                if product.key == nextProduct.templateOptions?.cascadingParentControl {
                                                    
                                                    mdCategoryID = option.value
                                                    
                                                    fetchMasterData(vehicleMakeID: option.value)
                                                }
                                            }
                                            
                                            
                                            isDropdownOpen = false
                                        }) {
                                            Text(option.label)
                                                .padding(10)
                                                .foregroundColor(.black)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .listRowSeparator(.hidden)
                                        }
                                        
                                    }
                                    
                                    
                                    ForEach(masterDataArray, id: \.masterDataID) { value in
                                        
                                        if mdCategoryID == product.templateOptions?.cascadingParentControl {
                                            Button(action: {
                                                
                                                product.defaultValue = value.mdTitle
                                                textAnswersParameters[product.key ?? ""] = value.masterDataID
                                                
                                                if var key = product.key {
                                                    key = key.replacingOccurrences(of: "ID", with: "")
                                                    textAnswersValueParameters[key] = value.mdTitle
                                                }
                                                
                                                if index + 1 < getCustomFormArray.count {
                                                    let nextProduct = getCustomFormArray[index + 1]
                                                    
                                                    if product.key == nextProduct.templateOptions?.cascadingParentControl {
                                                        
                                                        mdCategoryID = value.masterDataID
                                                        
                                                        fetchMasterData(vehicleMakeID: value.masterDataID)
                                                    }
                                                }
                                                
                                                isDropdownOpen = false
                                            }) {
                                                Text(value.mdTitle)
                                                    .padding(10)
                                                    .foregroundColor(.black)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .listRowSeparator(.hidden)
                                            }
                                        }
                                    }
                                }
                                
                                
                                if let hideExpression = product.expressionProperties?.hide, selectedItem.contains(hideExpression.replacingOccurrences(of: "'", with: "")) {
                                    
                                    if let subFieldGroup = product.fieldGroup {
                                        
                                        ForEach(subFieldGroup.indices, id: \.self) { subFieldIndex in
                                            let subField = subFieldGroup[subFieldIndex]
                                            

                                                ForEach(subField.templateOptions?.options ?? [], id: \.label) { option in
                                                    
                                                    if selectedCustomFormField == "\(subField.orderData ?? 0)" {
                                                    Button(action: {
                                                        subField.defaultValue = option.label
                                                        textAnswersParameters[subField.key ?? ""] = option.value
                                                        isDropdownOpen = false
                                                    }) {
                                                        Text(option.label)
                                                            .padding(10)
                                                            .foregroundColor(.black)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                            .listRowSeparator(.hidden)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                
                                if addonVisibilityKeys.contains(product.expressionProperties?.hide ?? "") {
                                    
                                    if let subFieldGroup = product.fieldGroup {
                                        
                                        ForEach(subFieldGroup.indices, id: \.self) { subFieldIndex in
                                            let subField = subFieldGroup[subFieldIndex]
                                            
                                                ForEach(subField.templateOptions?.options ?? [], id: \.label) { option in
                                                    
                                                    if selectedCustomFormField == "\(subField.orderData ?? 0)" {
                                                    Button(action: {
                                                        subField.defaultValue = option.label
                                                        textAnswersParameters[subField.key ?? ""] = option.value
                                                        isDropdownOpen = false
                                                    }) {
                                                        Text(option.label)
                                                            .padding(10)
                                                            .foregroundColor(.black)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                            .listRowSeparator(.hidden)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                if excessVisibilityKeys.contains(product.expressionProperties?.hide ?? "") {
                                    
                                    if let subFieldGroup = product.fieldGroup {
                                        
                                        ForEach(subFieldGroup.indices, id: \.self) { subFieldIndex in
                                            let subField = subFieldGroup[subFieldIndex]
                                            
                                           
                                                
                                                ForEach(subField.templateOptions?.options ?? [], id: \.label) { option in
                                                    
                                                    if selectedCustomFormField == "\(subField.orderData ?? 0)" {
                                                    Button(action: {
                                                        subField.defaultValue = option.label
                                                        textAnswersParameters[subField.key ?? ""] = option.value
                                                        isDropdownOpen = false
                                                    }) {
                                                        Text(option.label)
                                                            .padding(10)
                                                            .foregroundColor(.black)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                            .listRowSeparator(.hidden)
                                                    }
                                                }
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
                    .frame(height: 400)
                    .offset(y: isDropdownOpen ? 125 : 0)
                }
            }


            
            if showAddonPopup {
                ZStack {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea(.all)
                        .onTapGesture {
                            showAddonPopup = false
                        }
                    
                    VStack(spacing:0) {
                        List {
                            
//                            ForEach(getCustomFormArray, id: \.orderData) { product in
//                                if product.key?.hasPrefix("ADDON") == true && product.type == "checkbox" && product.templateOptions != nil {
//                                    if let key = product.key, let templateOptions = product.templateOptions {
//                                        Button(action: {
//                                            if selectedItem.contains(templateOptions.label ?? "") {
//                                                selectedItem.remove(templateOptions.label ?? "")
//                                                selectedItems.remove(templateOptions.label ?? "")
//                                                selectedAddonAnswers[key] = false
//                                                addonVisibilityKeys.remove("model.\(key)!== true")
//                                                
//                                                if let hideExpression = product.expressionProperties?.hide, !addonVisibilityKeys.contains(hideExpression) {
//                                                    textAnswersParameters[key] = ""
//                                                }
//                                                
//                                            } else {
//                                                selectedItem.insert("\(templateOptions.label ?? "")")
//                                                selectedItems.insert("\(templateOptions.label ?? "")")
//                                                selectedAddonAnswers[key] = true
//                                                addonVisibilityKeys.insert("model.\(key)!== true")
//                                            }
//                                            
//                                            textAddonAnswers[addonKeys] = Array(selectedItem)
//                                        }) {
//                                            HStack(alignment:.top) {
//                                                Image(systemName: selectedItem.contains(templateOptions.label ?? "") ? "checkmark.square.fill" : "square")
//                                                    .bold()
//                                                    .font(isFontMedium(size: 20))
//                                                    .foregroundColor(.black)
//                                                    .padding(.top)
//                                                
//                                                Text(templateOptions.label ?? "")
//                                                    .font(isFontMedium(size: 18))
//                                                    .foregroundColor(.black)
//                                                    .multilineTextAlignment(.leading)
//                                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                                    .padding(.top)
//                                            }.padding(.leading)
//                                        }
//                                    }
//                                    
//                                }
//                            }
                           
                            
                            ForEach(addonVisibilityArray.indices, id: \.self) { index in
                                let product = addonVisibilityArray[index]
                                if let key = product.key, let label = product.label {
                                    if key.hasPrefix("ADDON"), product.type == "checkbox" {
                                        Button(action: {
                                            // Your button action code here
                                            if addonSelectedItem.contains(label) {
                                                addonSelectedItem.remove(label)
                                                selectedItems.remove(label)
                                                selectedAddonAnswers[key] = false
                                                addonVisibilityKeys.remove("model.\(key)!== true")
                                                
                                                if let hideExpression = product.hide, !addonVisibilityKeys.contains(hideExpression) {
                                                    textAnswersParameters[key] = ""
                                                }
                                            } else {
                                                addonSelectedItem.insert("\(label)")
                                                selectedItems.insert("\(label)")
                                                selectedAddonAnswers[key] = true
                                                addonVisibilityKeys.insert("model.\(key)!== true")
                                            }
                                            
                                            textAddonAnswers[addonKeys] = Array(addonSelectedItem)
                                        }) {
                                            HStack(alignment:.top) {
                                                Image(systemName: addonSelectedItem.contains(label) ? "checkmark.square.fill" : "square")
                                                    .bold()
                                                    .font(isFontMedium(size: 20))
                                                    .foregroundColor(.black)
                                                    .padding(.top)
                                                
                                                Text(label)
                                                    .font(isFontMedium(size: 18))
                                                    .foregroundColor(.black)
                                                    .multilineTextAlignment(.leading)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .padding(.top)
                                            }.padding(.leading)
                                        }
                                    }
                                }
                            }
                            .listRowSeparator(.hidden)
                            
                            Text("OK")
                                .font(isFontMedium(size: 20))
                                .frame(maxWidth:.infinity, alignment:.trailing)
                                .padding(.trailing)
                                .foregroundColor(toolbarcolor)
                                .padding()
                                .onTapGesture {
                                    showAddonPopup = false
                                }
                        }
                        .listStyle(.plain)
                        .frame(width: 350)
                        .cornerRadius(0)
                        .shadow(radius: 3)
                    }
                    .frame(height: 400)
                   
             
                }
            }
            
            
            if showExcessPopup {
                ZStack {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea(.all)
                        .onTapGesture {
                            showExcessPopup = false
                        }
                    
                    VStack(spacing:0) {
                        List {
                            
                            ForEach(excessVisibilityArray.indices, id: \.self) { index in
                                let product = excessVisibilityArray[index]
                                if let key = product.key, let label = product.label {
                                    if key.hasPrefix("ADDON"), product.type == "checkbox" {
                                        Button(action: {
                                            // Your button action code here
                                            if excessSelectedItem.contains(label) {
                                                excessSelectedItem.remove(label)
                                                selectedItems.remove(label)
                                                selectedAddonAnswers[key] = false
                                                excessVisibilityKeys.remove("model.\(key)!== true")
                                                
                                                if let hideExpression = product.hide, !excessVisibilityKeys.contains(hideExpression) {
                                                    textAnswersParameters[key] = ""
                                                }
                                            } else {
                                                excessSelectedItem.insert("\(label)")
                                                selectedItems.insert("\(label)")
                                                selectedAddonAnswers[key] = true
                                                excessVisibilityKeys.insert("model.\(key)!== true")
                                            }
                                            
                                            textExcessAnswers[excessKeys] = Array(excessSelectedItem)
                                        }) {
                                            HStack(alignment:.top) {
                                                Image(systemName: excessSelectedItem.contains(label) ? "checkmark.square.fill" : "square")
                                                    .bold()
                                                    .font(isFontMedium(size: 20))
                                                    .foregroundColor(.black)
                                                    .padding(.top)
                                                
                                                Text(label)
                                                    .font(isFontMedium(size: 18))
                                                    .foregroundColor(.black)
                                                    .multilineTextAlignment(.leading)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .padding(.top)
                                            }.padding(.leading)
                                        }
                                    }
                                }
                            }
                            .listRowSeparator(.hidden)
                            
                            Text("OK")
                                .font(isFontMedium(size: 20))
                                .frame(maxWidth:.infinity, alignment:.trailing)
                                .padding(.trailing)
                                .foregroundColor(toolbarcolor)
                                .padding()
                                .onTapGesture {
                                    showExcessPopup = false
                                }
                        }
                        .listStyle(.plain)
                        .frame(width: 350)
                        .cornerRadius(0)
                        .shadow(radius: 3)
                    }
                    .frame(height: 400)
                   
             
                }
            }
            
        }
    }
    

  
    func customFormValidation() {
        
        for (index, formField) in getCustomFormArray.enumerated() {
            if let key = formField.key, let templateOptions = formField.templateOptions, let option = templateOptions.options {
                let answer = formField.defaultValue?.trimmingCharacters(in: .whitespacesAndNewlines)
                
                if templateOptions.required && (answer?.isEmpty ?? true) && (templateOptions.label != nil) {
                    if formField.type == "select" {
                        if !option.isEmpty {
                            if let validation = formField.validation {
                                self.alertItem = AlertItem(title: Text("ERR018 \n \(validation.messages.required ?? "")"))
                                return
                            }
                        }
                    } else {
                        if let validation = formField.validation {
                            self.alertItem = AlertItem(title: Text("ERR018 \n \(validation.messages.required ?? "")"))
                            return
                        }
                    }
                }
                
                
                // Check for minLength validation
                if let minMessage = formField.validation?.messages.min, let minLength = templateOptions.min, let fieldValue = answer {
                    if fieldValue.count <= minLength {
                        self.alertItem = AlertItem(title: Text("ERR018 \n \(minMessage)"))
                        return
                    }
                }
                           
                           // Check for maxLength validation
                if let maxMessage = formField.validation?.messages.max, let maxLength = templateOptions.max, let fieldValue = answer {
                    if fieldValue.count >= maxLength {
                        self.alertItem = AlertItem(title: Text("ERR018 \n \(maxMessage)"))
                        return
                    }
                }

            }
            
            
            if let fieldGroup = formField.fieldGroup {
                for value in fieldGroup {
                    if formField.key == nil {
                        if let templateOptions = value.templateOptions {
                            let key = value.key ?? ""
                            let answer = value.defaultValue?.trimmingCharacters(in: .whitespacesAndNewlines)
                            
                            
                            // Additional validations for other cases within field group
                            if addonVisibilityKeys.contains(formField.expressionProperties?.hide ?? "") {
                                if templateOptions.required && (answer?.isEmpty ?? true) {
                                    if let validation = value.validation {
                                        if ((validation.messages.required?.isEmpty) != nil) {
                                            self.alertItem = AlertItem(title: Text("ERR018 \n \(validation.messages.required ?? "")"))
                                            return
                                        }
                                    }
                                }
                                
                                // Check for minLength validation
                                if let minMessage = value.validation?.messages.min, let minLength = templateOptions.min, let fieldValue = answer {
                                    if fieldValue.count <= minLength {
                                        self.alertItem = AlertItem(title: Text("ERR018 \n \(minMessage)"))
                                        return
                                    }
                                }
                                           
                                           // Check for maxLength validation
                                if let maxMessage = value.validation?.messages.max, let maxLength = templateOptions.max, let fieldValue = answer {
                                    if fieldValue.count >= maxLength {
                                        self.alertItem = AlertItem(title: Text("ERR018 \n \(maxMessage)"))
                                        return
                                    }
                                }
                                
                            }
                            
                            if excessVisibilityKeys.contains(formField.expressionProperties?.hide ?? "") {
                                if templateOptions.required && (answer?.isEmpty ?? true) {
                                    if let validation = value.validation {
                                        if ((validation.messages.required?.isEmpty) != nil) {
                                            self.alertItem = AlertItem(title: Text("ERR018 \n \(validation.messages.required ?? "")"))
                                            return
                                        }
                                    }
                                }
                                
                                // Check min length
                                if let validation = value.validation, let minMessage = validation.messages.min {
                                    
                                    let minLength = templateOptions.min
                                    
                                    // Convert the extracted substring to an integer value
                                    if let minValue = minLength, let intValue = Int(answer ?? ""), intValue <= minValue {
                                        self.alertItem = AlertItem(title: Text("ERR018 \n \(minMessage)"))
                                        return
                                    }
                                }
                                
                                // Check max length
                                if let validation = value.validation, let maxMessage = validation.messages.max {
                                    
                                    
                                    let maxLength = templateOptions.max
                                    
                                    // Convert the extracted substring to an integer value
                                    if let maxValue = maxLength, let intValue = Int(answer ?? ""), intValue >= maxValue {
                                        self.alertItem = AlertItem(title: Text("ERR018 \n \(maxMessage)"))
                                        return
                                    }
                                }
                                
                            }

                        }
                    }
                }
            }
            
        }
        
        
        withAnimation {
            fetchInsertQuotationSearch()
        }
    }

    
    
    func fetchGetCustomForm() {
        
        isLoading = true
        
        let parameters: [String: Any?] = [
            "quotationRequestID": productQuotationRequestID,
            "isFormalyJson":false
//            "a8b6b395-a0d2-424b-90e0-1d8b3c41767e"
//            "c09c8103-561c-402e-9e90-cc0fb11d44a3"
        ]
        
        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(BaseURL)")!,
                                         path: "api/prodconfig/Quotation/GetQuotationForms",
                                         method: "POST",bodyData:parameters)
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<GetCustomFormResponse, Error>) in
            switch result {
            case .success(let getProductsResponse):
                // Handle success
                DispatchQueue.main.async {
                    
                    if getProductsResponse.rcode == 200 {
                        print(getProductsResponse.rcode)
                        
//                        for formField in getCustomFormArray {
//                            // Iterate through each option in the current product
//                            for option in formField.templateOptions?.options ?? [] {
//                                // Construct the hide condition dynamically based on the selected option
//                                let hideCondition = formField.expressionProperties?.hide
//                                
//                                // Check if the hide condition is not nil and contains the product key and selected option value
//                                if let hideCondition = hideCondition, hideCondition.contains("\(formField.key ?? "")!==\(option.value)") {
//                                    // Find the field to hide based on the constructed hide condition
//                                    if let fieldToHide = getCustomFormArray.first(where: { $0.expressionProperties?.hide?.replacingOccurrences(of: "'", with: "") == hideCondition }) {
//                                        print("Hide Keys --- > \(fieldToHide.key ?? "NO")")
//                                    }
//                                }
//                            }
//                        }


                       
                        print("decoding visibility data: \(getProductsResponse.rObj.getAllAPIFormalyJson)")
                       
                        if let visibilityData =  getProductsResponse.rObj.getAllAPIFormalyJson.data(using: .utf8) {
                            do {
                                let visibilityModel = try JSONDecoder().decode([GetAllAPIFormalyJsonResponse].self, from: visibilityData)

                                print("Success")
                                
                                let allFieldGroups = visibilityModel.flatMap { $0.fieldGroup }
                                       getCustomFormArray = allFieldGroups
                            

                                // Find the index of "Excess" template
                                if let excessIndex = getCustomFormArray.firstIndex(where: { $0.template?.contains("Excess") ?? false }) {
                                    // Iterate through the array starting from the index following "Excess"
                                    for index in (excessIndex + 1)..<getCustomFormArray.count {
                                        let formField = getCustomFormArray[index]
                                        if let templateOptions = formField.templateOptions {
                                            
                                            let label = templateOptions.label
                                            let key = formField.key
                                            let type = formField.type
                                            let placeholder = templateOptions.placeholder
                                            let required = templateOptions.required
                                            let options = templateOptions.options
                                            let hide = formField.expressionProperties?.hide
                                            let validation = formField.validation
                                            
                                            
                                            excessVisibilityArray.append((label: label, key: key, type: type, hide: hide, required: required, options: options, placeholder: placeholder, validation: validation))
                                        }
                                        
                                        
                                        
                                        if let key = formField.key, key.hasPrefix("ADDON") {
                                            excessKeys.append(key)
                                        }
                                    }
                                }

                                
                                for formField in getCustomFormArray {
                                    
                                
                                    if shouldContinueLoop {
                                        
                                        
                                        if let templateOptions = formField.templateOptions {
                                            print("Label: \(templateOptions.label ?? "N/A")")
                                            
                                            let label = templateOptions.label
                                            let key = formField.key
                                            let type = formField.type
                                            let placeholder = templateOptions.placeholder
                                            let required = templateOptions.required
                                            let options = templateOptions.options
                                            let hide = formField.expressionProperties?.hide
                                            let validation = formField.validation
                                          
                                            addonVisibilityArray.append((label: label, key: key, type: type, hide: hide, required: required, options: options, placeholder: placeholder, validation: validation))
                                        }
                                        
                                        if let key = formField.key, key.hasPrefix("ADDON") {
                                            addonsTextDisplayed = true
                                            addonKeys.append(key)
                                        }
                                        
                                        if let template = formField.template, template.contains("Excess") {
                                            excessTextDisplayed = true
                                            shouldContinueLoop = false
                                        }
                                        
                                        
                                        if let fieldGroup = formField.fieldGroup {
                                            for field in fieldGroup {
                                                
                                                if let key = field.key {
                                                    print("Field Key: \(key)")
                                                }
                                                
                                                if let templateOptions = field.templateOptions {
                                                    print("Label: \(templateOptions.label ?? "N/A")")
                                                }
                                                
                                            }
                                        }
                                    }
                                }
                                
                                // Separately handle Excess template
                                if let excessFormField = getCustomFormArray.first(where: { $0.template?.contains("Excess") ?? false }),
                                   let templateOptions = excessFormField.templateOptions {
                                    
                                    print("Labels : \(templateOptions.label ?? "N/A")")
                                    let label = templateOptions.label
                                    let key = excessFormField.key
                                    let type = excessFormField.type
                                    let placeholder = templateOptions.placeholder
                                    let required = templateOptions.required
                                    let options = templateOptions.options
                                    let hide = excessFormField.expressionProperties?.hide
                                    let validation = excessFormField.validation
                                    
                                    addonVisibilityArray.append((label: label, key: key, type: type, hide: hide, required: required, options: options, placeholder: placeholder, validation: validation))
                                }

                                
                            } catch {
                                print("Error decoding visibility data: \(error)")
                            }
                        } else {
                            print("Error converting 'viewJson' to data")
                        }
                        
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
    }
    
    
    func fetchMasterData(vehicleMakeID : String) {
        
        isLoading = true
        
        let parameters: [String: Any?] = [
            masterDataInputParameter : "\(vehicleMakeID)"
        ]
        
        print(parameters)
        
        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(BaseURL)")!,
                                         path: "\(masterDataApiUrl)",
                                         method: "POST",bodyData:parameters)
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<MasterDataResponse, Error>) in
            switch result {
            case .success(let getProductsResponse):
                // Handle success
                DispatchQueue.main.async {
                    
                    if getProductsResponse.rcode == 200 {
                        print(getProductsResponse.rcode)
                        
                        masterDataArray = getProductsResponse.rObj.fetchMasterData
                        
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
    }
    
    
    func fetchInsertQuotationSearch() {
        
        isLoading = true
        
        var parameters: [String: Any?] = [
            "quotationRequestID":  productQuotationRequestID,
            "viewJson": ""
        ]
        
        parameters.merge(textAnswersParameters) { (_, new) in new }
        parameters.merge(selectedAddonAnswers) { (_, new) in new }
        parameters.merge(textAnswersValueParameters) { (_, new) in new }
        
        print("InsertQuotationSearch \(parameters)")
        
        
        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(BaseURL)")!,
                                         path: "api/prodconfig/Quotation/InsertQuotationSearch",
                                         method: "POST",bodyData:parameters as [String : Any])
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<InsertCustomFormResponse, Error>) in
            switch result {
            case .success(let insertResponse):
                // Handle success
                DispatchQueue.main.async {
                    
                    if insertResponse.rcode == 200 {
                        print(insertResponse.rcode)
                       
                        withAnimation {
                            navigateQuotationPage = true
                        }
                        
                        quotationSearchID = insertResponse.rObj.quotationSearchID
                        
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
    }
    
    
//    func fetchGetCustomForm() {
//
//        isLoading = true
//
//        let parameters: [String: Any?] = [
////            "productIDs": Array(selectedProductIds),
////            "productIDs": NSNull(),
////            "quotationSearchID":"\(productQuotationRequestID)",
////            "premiumCategoryIDs": [],
//
////            "productIDs": [
////                  "529"
////              ],
////              "premiumCategoryIDs": []
//
//            "quotationRequestID": productQuotationRequestID,
//            "isFormalyJson":false
//        ]
//
//        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(BaseURL)")!,
//                                         path: "api/prodconfig/Quotation/GetQuotationForms",
//                                         method: "POST",bodyData:parameters)
//
//        APIService.request(endpoint: dynamicEndpoint) { (result: Result<GetProductsResponse, Error>) in
//            switch result {
//            case .success(let getProductsResponse):
//                // Handle success
//                DispatchQueue.main.async {
//
//                    if getProductsResponse.rcode == 200 {
//                        print(getProductsResponse.rcode)
//
//                        getProductDetailArray = getProductsResponse.rObj.getAllAPIFormaly
//
//                        isLoading = false
//
//                        for productValues in getProductDetailArray {
//                            for formField in productValues.fieldGroup {
//
//                                    if let key = formField.key, key.hasPrefix("ADDON") {
//                                        addonsTextDisplayed = true
//                                        addonKeys.append(key)
//                                    }
//                                }
//                            }
//
//                    } else {
//                        self.alertItem = AlertItem(title: Text(getProductsResponse.rmsg.first?.errorText ?? ""))
//                        isLoading = false
//                    }
//                }
//
//            case .failure(let error):
//                // Handle error
//                print(error)
//                self.alertItem = AlertItem(title: Text("An unexpected error occurred"))
//                isLoading = false
//            }
//        }
//
//
////        isLoading = true
////        let url = URL(string: "\(BaseURL)api/digital/core/PremiumLogic/GetProducts")!
////        print(url)
////        let request = NSMutableURLRequest(url: url)
////        request.httpMethod = "POST"
////
////        let authToken:String! = "Bearer " + Extensions.token
////
////        request.addValue(authToken, forHTTPHeaderField: "Authorization")
////        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
////
////        print(authToken as Any)
////
////        let parameters: [String: Any?] = [
//////            "productIDs": Array(selectedProductIds),
////            "productIDs": NSNull(),
////            "quotationSearchID":"\(productQuotationSearchId)",
////            "premiumCategoryIDs": []
////
//////            "productIDs": [
//////                  "529"
//////              ],
//////              "premiumCategoryIDs": []
////        ]
////
////        print("GetProducts Parameters = \(parameters)")
////
////        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
////
////        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
////            guard let data = data else {
////                print("\("Error No data returned from server") \(error?.localizedDescription ?? "")")
////                self.alertItem = AlertItem(title: Text("\("Error No data returned from server") \(error?.localizedDescription ?? "")"))
////                isLoading = false
////                return
////            }
////
////            do {
////
////                var resultDictionary:NSDictionary! = NSDictionary()
////                resultDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
////                print("Get Products Response = \(String(describing: resultDictionary))")
////
////                let decoder = JSONDecoder()
////                let getProductsResponse = try decoder.decode(GetProductsResponse.self, from: data)
////
////                DispatchQueue.main.async {
////
////                    if getProductsResponse.rcode == 200 {
////                        print(getProductsResponse.rcode)
////
////                        getProductDetailArray = getProductsResponse.rObj.getAllAPIFormaly
////
////                        isLoading = false
////
////                        for productValues in getProductDetailArray {
////                            for formField in productValues.fieldGroup {
////
////                                    if let key = formField.key, key.hasPrefix("ADDON") {
////                                        addonsTextDisplayed = true
////                                        addonKeys.append(key)
////                                    }
////                                }
////                            }
////
////                    } else {
////                        self.alertItem = AlertItem(title: Text(getProductsResponse.rmsg.first?.errorText ?? ""))
////                        isLoading = false
////                    }
////                }
////            } catch {
////                print("\("Error decoding response") \(error.localizedDescription)")
////                self.alertItem = AlertItem(title: Text("An unexpected error occurred"))
////                isLoading = false
////            }
////        }
////        task.resume()
//    }
}


struct CustomForms_Previews: PreviewProvider {
    static var previews: some View {
        CustomForms(navigateCustomPage: .constant(false))
    }
}





//if let fieldGroup = product.fieldGroup {
//                                    ForEach(fieldGroup, id: \.key) { field in
//                                        if let key = field.key {
//                                            Text("Field Key: \(key)")
//                                        }
//                                    }
//                                }
