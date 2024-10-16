

import SwiftUI
import MobileCoreServices

var proposalFormTextAnswers: [String: String] = [:]
var proposalFormTextAnswersParameters: [String: String] = [:]
var proposalFormTextAddonAnswers: [[String]: [String]] = [:]
var proposalFormSelectedItems = Set<String>()
//var proposalFormAddonKeys: [String] = []
var proposalFormSelectedAddonAnswers: [String: Bool] = [:]
var proposalFormAddonVisibility = Set<String>()



struct ProposalForms: View {
    
    @Binding var navigateProposalForm: Bool
    
    @State private var isOverlayVisible = false
    
    @State private var selectedIndex: Int = 0
    @State var isDefaultValue = false

    @State var proposalFormSelectedItem = Set<String>()
    @State var proposalFormAddonKeys: [String] = []
    @State var proposalFormDefaultValues: [String] = []
    @State var getProposalDetailArray: [GetProposalResponse.GetProposalValues.FormField.FieldGroup] = []
    
    @State private var fetchAllProposalformArray: [FetchAllProposalFormResponse.FetchAllProposalFormRObj.ProposalForm] = []
    
    @State var getProposalFormDataArray: [ProposalFormDataResponse.ProposalFormDataValues.FetchFormData.FormDataField] = []
    
    @State var masterDataArray: [MasterDataResponse.MasterDataRObj.MasterData] = []
    @State var masterDatavalue: [(label: String, value: String, categoryID: Int)] = []
    @State var masterCatagoryID = 0
    @State var selectedMasterData = ""
    @State var masterDataApiUrl = ""
    @State var masterDataInputParameter = ""
    @State var cascadingParentControlValue = ""
    
    @State private var currentPageIndex = 0
    @State private var showPreviousButton = false
    
    @State private var addonsTextDisplayed = false
    @State var showAddonPopup = false
    @State private var selectedOption: String? = nil
    
    @State var selectedProposalFormField = ""
    @State var selectedProposalRadio = ""
    @State private var isDropdownOpen = false
    @State private var isChecked: Bool = false
    @State var selectedItem = Set<String>()
    
    @State var selectedDate: Date?
    let previousYear = Calendar.current.date(byAdding: .year, value: -18, to: Date())!
    
    @State private var isShowingDatePicker = false
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        return formatter
    }()
    
    @State private var showProductPopUp = false
    
    @State var navigateGeneratePolicyPage = false
    @State var navigateQuotationPage = false
    
    @State var navigateLineofBusiness = false
    
    @State private var getCountry: [Country] = []
    @State private var selectedCountryCode = "KE (+254)"
    @State private var showCountryCodePopUp = false
    @State private var phoneNumberCount: Int  = 0
    @State private var blocksOfPhoneNo = [3,3,3]
    
    @State var selectedFileURL: URL?
    @State private var isShowingFilePicker = false
    @State private var isDocumentPickerPresented = false
    @State private var isMultipleDocumentPickerPresented = false
    @State private var selectedFileName: String? = nil
    @State private var selectedSingleFileName: [String] = []
    @State private var selectedMultipleFileName: [String] = []
    @State var proposalisMultiple = false
    @State var proposalFileslength = 0
    
    @State var navigateUserInformationPage = false
    @State private var alertItem: AlertItem?
    @State private var isLoading = false
    @State private var isSingleFileCircleLoading = false
    @State private var isFileUploadCircleLoading: [String: Bool] = [:]

    @State private var navigateSelfAssessment = false
    
    @StateObject var networkMonitor = NetworkMonitor()

    var body: some View {
        NavigationStack {
            LoadingView(isShowing: $isLoading) {
               
                    VStack {
                        
//                        ZStack {
//                            
//                            HStack {
//                                
//                                Spacer()
//                                VStack(alignment: .center) {
//                                    Text("Quotation ID")
//                                        .font(isFontMedium(size: 19))
//                                    
//                                    Text(Extensions.quotationID)
//                                        .font(isFontMedium(size: 17))
//                                        .foregroundColor(inkBlueColour)
//                                        .padding(.top,1)
//                                }
//                                .padding(.leading)
//                                
//                                Spacer()
//                                
////                                NavigationLink("",destination: InsuranceOptionView(navigateInsuranceOptiondPage: .constant(false)), isActive: $navigateLineofBusiness)
//                                
//                                Image(systemName: "square.and.pencil")
//                                    .bold()
//                                    .font(.system(size: 24))
//                                    .foregroundColor(inkBlueColour)
//                                    .padding(.trailing)
//                                    .onTapGesture {
//                                        
//                                        withAnimation {
//                                            navigateLineofBusiness = true
//                                        }
//                                        
//                                        Extensions.selectedItem = Set<String>()
//                                        
//                                        textAnswers = [:]
//                                        textAnswersParameters = [:]
//                                        textAddonAnswers = [:]
//                                        selectedItems = Set<String>()
//                                        addonVisibilityKeys = Set<String>()
//                                        selectedAddonAnswers = [:]
//                                    }
//                                
//                            }
//                        }
//                        .frame(width:360)
//                        .fixedSize(horizontal: false, vertical: true)
//                        .padding(.top,8)
//                        .padding(.bottom,8)
//                        .background(Color.gray.opacity(0.2))
//                        .cornerRadius(8)
//                        .padding(.top,10)
//                        
//                        HStack(alignment: .top,spacing:8) {
//                            ZStack {
//                                VStack(spacing: 5){
//                                    Text("Line of Business")
//                                        .font(isFontMedium(size: 19))
//                                    
//                                    Text(Extensions.selectedLineOfBusiness)
//                                        .font(isFontMedium(size: 17))
//                                        .foregroundColor(inkBlueColour)
//                                        .padding(2)
//                                    
//                                }
//                                
//                            }
//                            .frame(width:175,height: Extensions.selectedItem.count == 1 ? 40 : 50,alignment: .top)
//                            .padding(.top,10)
//                            .padding(.bottom,10)
//                            .background(Color.gray.opacity(0.2))
//                            .cornerRadius(8)
//                            .padding(.leading)
//                            
//                            ZStack {
//                                VStack(spacing: 3) {
//                                    
//                                    Text("Products")
//                                        .font(isFontMedium(size: 19))
//                                   
//                                    if productArray.count == 1 {
//                                        
//                                        Text(Array(productArray).first!)
//                                            .font(isFontMedium(size: 17))
//                                            .foregroundColor(inkBlueColour)
//                                            .padding(2)
//                                        
//                                    } else {
//                                        HStack {
//                                            
//                                            if let firstCharacter = productArray.first {
//                                                Text(String(firstCharacter))
//                                                    .font(isFontMedium(size: 17))
//                                                    .foregroundColor(.black)
//                                                    .padding(.leading, 10)
//                                                    .lineLimit(1)
//                                            }
//                                            
//                                            Spacer()
//                                            
//                                            Image(systemName: "chevron.down")
//                                                .font(isFontMedium(size: 17))
//                                                .padding(.trailing,10)
//                                            
//                                        }
//                                        .frame(width: 160,height: 30)
//                                        .background(Color.white)
//                                        .cornerRadius(6)
//                                        .onTapGesture {
//                                            showProductPopUp = true
//                                        }
//                                    }
//                                  
//                                    
//                                }
//                                
//                                
//                            }
//                            .frame(width:175,height: Extensions.selectedItem.count == 1 ? 40 : 50,alignment: .top)
//                            .padding(.top,10)
//                            .padding(.bottom,10)
//                            .background(Color.gray.opacity(0.2))
//                            .cornerRadius(8)
//                            .padding(.trailing)
//                            
//                        }
                        
                        
                        VStack {
                            
                            ForEach(getProposalFormDataArray.indices ,id: \.self) { index in
                                let value = getProposalFormDataArray[index]
                                
                                if currentPageIndex == index {
                                    Text("Step \(index + 1) of \(getProposalFormDataArray.count)")
                                        .bold()
                                        .font(isFontMedium(size: 25))
                                        .foregroundColor(inkBlueColour)
                                    
                                    Text("\(fetchAllProposalformArray.first?.formName ?? "") :")
                                        .bold()
                                        .font(isFontMedium(size: 18))
                                        .foregroundColor(fontOrangeColour)
                                        .padding(.top,5)
                                    
                                    
                                    ScrollView(showsIndicators: false) {
                                        VStack {
                                            
                                            ForEach(value.fieldGroup.indices, id: \.self) { indexvalue in
                                                let field = value.fieldGroup[indexvalue]
                                                
                                                VStack(spacing:10) {
                                                    if let templateOptions = field.templateOptions {
                                                        
                                                        if let key = field.key, key.lowercased().contains("phonenumber") {
                                                            Text("\(templateOptions.label ) \(templateOptions.required ? "*" : "")")
                                                                .halfTextColorChange(fullText: "\(templateOptions.label ) \(templateOptions.required ? "*" : "")", changeText: "*")
                                                                .font(isFontMedium(size: 18))
                                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                                .padding(.leading)
                                                                .padding(.top, 10)
                                                            
                                                            HStack {
                                                                Text(selectedCountryCode)
                                                                    .frame(maxWidth:.infinity, alignment: .leading)
                                                                    .padding(.leading,10)
                                                                    .font(isFontMedium(size: 18))
                                                                    .frame(width:130, height: 50)
                                                                    .background(Color.gray.opacity(0.2))
                                                                    .cornerRadius(8)
                                                                    .overlay {
                                                                        Image(systemName: "chevron.down")
                                                                            .font(isFontMedium(size: 20))
                                                                            .bold()
                                                                            .frame(maxWidth:.infinity, alignment: .trailing)
                                                                            .padding(.trailing,10)
                                                                    }
                                                                    .onTapGesture {
                                                                        self.showCountryCodePopUp = true
                                                                    }
                                                                
                                                                TextField("Enter phone number", text: Binding<String>(
                                                                    get: {
                                                                        
                                                                        field.defaultValue ?? ""
                                                                    },
                                                                    set: { newValue in
                                                                        proposalFormTextAnswers[field.key ?? ""] = newValue
                                                                        proposalFormDefaultValues.append(newValue)
                                                                        field.defaultValue = newValue
                                                                        
                                                                    }
                                                                ))
                                                                .padding(10)
                                                                .frame(width: 210,height: 50)
                                                                .font(isFontMedium(size: 18))
                                                                .autocapitalization(.none)
                                                                .autocorrectionDisabled()
                                                                .background(Color.gray.opacity(0.2))
                                                                .foregroundColor(.black)
                                                                .cornerRadius(8)
                                                                //                                                        .onChange(of: field.defaultValue ?? "") { newValue in
                                                                //                                                            let formattedPhoneNumber = formatPhoneNumber(phoneNumber: field.defaultValue ?? "", blocks: blocksOfPhoneNo)
                                                                //                                                            field.defaultValue = formattedPhoneNumber
                                                                //
                                                                //                                                        }
                                                                
                                                            }
                                                        }
                                                        
                                                        
                                                        if field.type == "input" && templateOptions.type == nil {
                                                            
                                                            if let allowedFileTypes = templateOptions.allowedFileTypes, !allowedFileTypes.isEmpty {
                                                                
                                                                if let isMultiple = templateOptions.isMultiple, !isMultiple {
                                                                    
                                                                    HStack {
                                                                        
                                                                        Text("\(templateOptions.label) \(templateOptions.required ? "*" : "")")
                                                                            .halfTextColorChange(fullText: "\(templateOptions.label ) \(templateOptions.required ? "*" : "")", changeText: "*")
                                                                            .font(isFontMedium(size: 18))
                                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                                            .padding(.leading)
                                                                            .padding(.top,10)
                                                                        
                                                                        Button(action:{
                                                                            
                                                                            if let isMultiple = templateOptions.isMultiple {
                                                                                proposalisMultiple = isMultiple
                                                                            }
                                                                            
                                                                            if let fileslength = Int(templateOptions.fileslength ?? "" ) {
                                                                                proposalFileslength = fileslength
                                                                                fileUploadlength = fileslength
                                                                            }
                                                                            
                                                                            print(field.key ?? "")
                                                                            
                                                                            selectedProposalFormField = field.key ?? ""
                                                                            
                                                                            if selectedSingleFileName.count >= proposalFileslength {
                                                                                self.alertItem = AlertItem(title: Text("ERR022 \n Oops! You've hit the maximum limit of \(proposalFileslength) files. Please remove some files and try again"))
                                                                            } else {
                                                                                
                                                                                isDocumentPickerPresented = true
                                                                                
                                                                            }
                                                                            
                                                                            
                                                                        })
                                                                        {
                                                                            Text("Add File +")
                                                                                .font(isFontMedium(size: 17))
                                                                                .foregroundColor(.white)
                                                                                .frame(width:100,height:35)
                                                                                .background(fontOrangeColour)
                                                                                .cornerRadius(8)
                                                                                .padding(10)
                                                                        }
                                                                        
                                                                    }
                                                                    .sheet(isPresented: $isDocumentPickerPresented) {
                                                                        UIKitDocumentPickerViewController (
                                                                            allowedFileTypes: allowedFileTypes,
                                                                            filelength: proposalFileslength,
                                                                            isMultiple: proposalisMultiple,
                                                                            completion: { urls in
                                                                                
                                                                                // Print the selected URLs
                                                                                print(urls)
                                                                                
                                                                                let numberOfSelectedFiles = urls.count
                                                                                print("Number of selected files: \(numberOfSelectedFiles)")
                                                                                
                                                                                
                                                                                var foundOversizedFile = false
                                                                                
                                                                                for selectedURL in urls {
                                                                                    
                                                                                    if foundOversizedFile {
                                                                                        print("Oversized file found. Skipping the rest.")
                                                                                        break
                                                                                    }
                                                                                    
                                                                                    let fileSize = fileSizeInMB(for: selectedURL)
                                                                                    if fileSize <=  Double(templateOptions.maxSize ?? 0) {
                                                                                        
                                                                                        let fileName = selectedURL.lastPathComponent
                                                                                        selectedSingleFileName.append(fileName)
                                                                                        
                                                                                        field.defaultValue = fileName
                                                                                       
                                                                                        
                                                                                        print(selectedSingleFileName)
                                                                                        
                                                                                        
                                                                                        fetchUploadFile(currentFile: selectedURL)
                                                                                        
                                                                                        isSingleFileCircleLoading = true

                                                                                        
                                                                                    } else {
                                                                                        
                                                                                        foundOversizedFile = true
                                                                                        
                                                                                        self.alertItem = AlertItem(title: Text("ERR020 \n Oops! Your file is too big. Please select a file under \(templateOptions.maxSize ?? 0) MB."))
                                                                                    }
                                                                                }
                                                                            },
                                                                            alertItem: $alertItem
                                                                        )
                                                                    }
                                                                    
                                                                    
                                                                    if !selectedSingleFileName.isEmpty {
                                                                        ZStack {
                                                                            Color.gray.opacity(0.2)
                                                                            
                                                                            ScrollView(.horizontal,showsIndicators:false) {
                                                                                HStack {
                                                                                    ForEach(selectedSingleFileName.indices, id: \.self) { index in
                                                                                        let fileName = selectedSingleFileName[index]
                                                                                        
                                                                                        ZStack(alignment:.top) {
                                                                                            Color.white
                                                                                            VStack {
                                                                                                
                                                                                                if isSingleFileCircleLoading {
                                                                                                    CircleLoadingView()
                                                                                                        .frame(maxWidth:.infinity , alignment: .trailing)
                                                                                                        .padding(10)
                                                                                                } else {
                                                                                                    Image(systemName: "xmark")
                                                                                                        .bold()
                                                                                                        .font(isFontMedium(size: 22))
                                                                                                        .foregroundColor(.black)
                                                                                                        .frame(maxWidth:.infinity , alignment: .trailing)
                                                                                                        .padding(10)
                                                                                                        .onTapGesture {
                                                                                                            selectedSingleFileName.remove(at: index)
                                                                                                            
                                                                                                            if selectedSingleFileName.isEmpty {
                                                                                                                field.defaultValue = ""
                                                                                                            }
                                                                                                        }
                                                                                                }
                                                                                                
                                                                                                
                                                                                                
                                                                                                Text(fileName)
                                                                                                    .multilineTextAlignment(.center)
                                                                                                    .font(isFontMedium(size: 16))
                                                                                                    .padding(10)
                                                                                            }
                                                                                        }
                                                                                        .frame(width:140, height:125)
                                                                                        .cornerRadius(6)
                                                                                       
                                                                                    }
                                                                                }.padding(5)
                                                                            }
                                                                            .padding(5)
                                                                        }
                                                                        .frame(width:350, height:140)
                                                                        .cornerRadius(8)
                                                                    }
                                                                    
                                                                    
                                                                    
                                                                }
                                                                
                                                                
                                                                if let isMultiple = templateOptions.isMultiple, isMultiple {
                                                                    
                                                                    HStack {
                                                                        
                                                                        Text("\(templateOptions.label) \(templateOptions.required ? "*" : "")")
                                                                            .halfTextColorChange(fullText: "\(templateOptions.label ) \(templateOptions.required ? "*" : "")", changeText: "*")
                                                                            .font(isFontMedium(size: 18))
                                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                                            .padding(.leading)
                                                                            .padding(.top,10)
                                                                        
                                                                        Button(action:{
                                                                            
                                                                            
                                                                            if let isMultiple = templateOptions.isMultiple {
                                                                                proposalisMultiple = isMultiple
                                                                            }
                                                                            
                                                                            if let fileslength = Int(templateOptions.fileslength ?? "" ) {
                                                                                proposalFileslength = fileslength
                                                                                fileUploadlength = fileslength
                                                                            }
                                                                            
                                                                            
                                                                            print(field.key ?? "")
                                                                            
                                                                            selectedProposalFormField = field.key ?? ""
                                                                            
                                                                            if selectedMultipleFileName.count >= proposalFileslength {
                                                                                self.alertItem = AlertItem(title: Text("ERR022 \n Oops! You've hit the maximum limit of \(proposalFileslength) files. Please remove some files and try again"))
                                                                            } else {
                                                                                isMultipleDocumentPickerPresented = true
                                                                                
                                                                            }
                                                                            
                                                                        })
                                                                        {
                                                                            Text("Add File +")
                                                                                .font(isFontMedium(size: 17))
                                                                                .foregroundColor(.white)
                                                                                .frame(width:100,height:35)
                                                                                .background(fontOrangeColour)
                                                                                .cornerRadius(8)
                                                                                .padding(10)
                                                                        }
                                                                        
                                                                    }
                                                                    .sheet(isPresented: $isMultipleDocumentPickerPresented) {
                                                                        UIKitDocumentPickerViewController (
                                                                            allowedFileTypes: allowedFileTypes,
                                                                            filelength: proposalFileslength - selectedMultipleFileName.count,
                                                                            isMultiple: proposalisMultiple,
                                                                            completion: { urls in
                                                                                // Print the selected URLs
                                                                                print(urls)
                                                                                
                                                                                // Determine the number of selected files
                                                                                let numberOfSelectedFiles = urls.count
                                                                                print("Number of selected files: \(numberOfSelectedFiles)")
                                                                                
                                                                                
                                                                                var foundOversizedFile = false // Boolean flag to track if an oversized file has been found
                                                                                
                                                                                for selectedURL in urls {
                                                                                    
                                                                                    // Check if an oversized file has been found
                                                                                    if foundOversizedFile {
                                                                                        // Display an alert or perform any other action as needed
                                                                                        print("Oversized file found. Skipping the rest.")
                                                                                        break // Exit the loop to prevent adding more files
                                                                                    }
                                                                                    
                                                                                    let fileSize = fileSizeInMB(for: selectedURL)
                                                                                    if fileSize <=  Double(templateOptions.maxSize ?? 0) {
                                                                                        
                                                                                        let fileName = selectedURL.lastPathComponent
                                                                                        selectedMultipleFileName.append(fileName)
                                                                                        
                                                                                        field.defaultValue = fileName
                                                                                        
                                                                                        fetchUploadFile(currentFile: selectedURL)
                                                                                       
                                                                                       
                                                                                        isFileUploadCircleLoading[fileName] = true
                                                                                        
                                                                                    } else {
                                                                                        
                                                                                        foundOversizedFile = true
                                                                                        
                                                                                        self.alertItem = AlertItem(title: Text("ERR020 \n Oops! Your file is too big. Please select a file under \(templateOptions.maxSize ?? 0) MB."))
                                                                                    }
                                                                                }
                                                                            },
                                                                            alertItem: $alertItem
                                                                        )
                                                                    }
                                                                    
                                                                 
                                                                    if !selectedMultipleFileName.isEmpty {
                                                                        ZStack {
                                                                            Color.gray.opacity(0.2)
                                                                            
                                                                            ScrollView(.horizontal,showsIndicators:false) {
                                                                                HStack {
                                                                                    ForEach(selectedMultipleFileName.indices, id: \.self) { index in
                                                                                        let fileName = selectedMultipleFileName[index]
                                                                                        
                                                                                        ZStack(alignment:.top) {
                                                                                            Color.white
                                                                                            VStack {
                                                                                                
                                                                                                if isFileUploadCircleLoading[fileName] == true {
                                                                                                    CircleLoadingView()
                                                                                                        .frame(maxWidth:.infinity , alignment: .trailing)
                                                                                                        .padding(10)
                                                                                                    
                                                                                                } else {
                                                                                                    Image(systemName: "xmark")
                                                                                                        .bold()
                                                                                                        .font(isFontMedium(size: 22))
                                                                                                        .foregroundColor(.black)
                                                                                                        .frame(maxWidth:.infinity , alignment: .trailing)
                                                                                                        .padding(10)
                                                                                                        .onTapGesture {
                                                                                                            selectedMultipleFileName.remove(at: index)
                                                                                                            
                                                                                                            if selectedMultipleFileName.isEmpty {
                                                                                                                field.defaultValue = ""
                                                                                                            }
                                                                                                        }
                                                                                                }
                                                                                                
                                                                                                Text(fileName)
                                                                                                    .multilineTextAlignment(.center)
                                                                                                    .font(isFontMedium(size: 16))
                                                                                                    .padding(10)
                                                                                            }
                                                                                        }
                                                                                        .frame(width:140, height:125)
                                                                                        .cornerRadius(6)
                                                                                        
                                                                                    }
                                                                                }
                                                                                .padding(5)
                                                                            }
                                                                            .padding(5)
                                                                        }
                                                                        .frame(width:350, height:140)
                                                                        .cornerRadius(8)
                                                                    }
                                                                }
                                                                
                                                            } else {
                                                                
                                                                
                                                                Text("\(templateOptions.label) \(templateOptions.required ? "*" : "")")
                                                                    .halfTextColorChange(fullText: "\(templateOptions.label ) \(templateOptions.required ? "*" : "")", changeText: "*")
                                                                    .font(isFontMedium(size: 18))
                                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                                    .padding(.leading)
                                                                    .padding(.top,10)
                                                                
                                                                TextField("\(templateOptions.placeholder ?? "")", text: Binding<String>(
                                                                    get: {
                                                                        field.defaultValue ?? ""
                                                                        
                                                                    },
                                                                    set: { newValue in
                                                                        proposalFormTextAnswers[field.key ?? ""] = newValue
                                                                        proposalFormDefaultValues.append(newValue)
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
                                                            
                                                        }
                                                        
                                                        

                                                            

                                                        if templateOptions.type == "password" {
                                                            Text("\(templateOptions.label) \(templateOptions.required ? "*" : "")")
                                                                .halfTextColorChange(fullText: "\(templateOptions.label ) \(templateOptions.required ? "*" : "")", changeText: "*")
                                                                .font(isFontMedium(size: 18))
                                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                                .padding(.leading)
                                                                .padding(.top,10)
                                                            
                                                            SecureField("\(templateOptions.placeholder ?? "")", text: Binding<String>(
                                                                get: {
                                                                    field.defaultValue ?? ""
                                                                    
                                                                },
                                                                set: { newValue in
                                                                    proposalFormTextAnswers[field.key ?? ""] = newValue
                                                                    proposalFormDefaultValues.append(newValue)
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
                                                        
                                                        if field.type == "checkbox" {
                                                            HStack(spacing: 10) {
                                                                Button(action: {
                                                                    isChecked.toggle()
                                                                    
                                                                    if isChecked {
                                                                        field.defaultValue = field.key ?? ""
                                                                    } else {
                                                                        field.defaultValue = ""
                                                                    }
                                                                    
                                                                }) {
                                                                    Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                                                                        .bold()
                                                                        .font(isFontMedium(size: 25))
                                                                        .foregroundColor(fontOrangeColour)
                                                                }
                                                                
                                                                Text("\(templateOptions.label) \(templateOptions.required ? "*" : "")")
                                                                    .halfTextColorChange(fullText: "\(templateOptions.label) \(templateOptions.required ? "*" : "")", changeText: "*")
                                                                    .font(isFontMedium(size: 18))
                                                            }
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                            .padding(.leading)
                                                            .padding(.top, 10)
                                                        }
                                                        
                                                        if field.type == "datepicker" {
                                                            Text("\(templateOptions.label ) \(templateOptions.required ? "*" : "")")
                                                                .halfTextColorChange(fullText: "\(templateOptions.label ) \(templateOptions.required ? "*" : "")", changeText: "*")
                                                                .font(isFontMedium(size: 18))
                                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                                .padding(.leading)
                                                                .padding(.top,10)
                                                            
                                                            TextField("Choose Date", text: Binding<String>(
                                                                get: {
                                                                    field.defaultValue ?? ""
                                                                    
                                                                },
                                                                set: { newValue in
                                                                    proposalFormTextAnswers[field.key ?? ""] = newValue
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
                                                                // Reset selectedDate when the text field is tapped
                                                                selectedDate = nil
                                                                
                                                                isShowingDatePicker = true
                                                                selectedProposalFormField = field.key ?? ""
                                                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                                            }
                                                            
                                                            
                                                            if selectedProposalFormField == field.key ?? ""  {
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
                                                                                proposalFormTextAnswers[field.key ?? ""]  = dateFormatter.string(from: newValue)
                                                                                field.defaultValue = dateFormatter.string(from: newValue)
                                                                                
                                                                                
                                                                            }
                                                                        ),
                                                                        in: getDateRange(templateOptions: templateOptions, formFields: value.fieldGroup),
                                                                        displayedComponents: [.date]
                                                                    )
                                                                    .datePickerStyle(.wheel)
                                                                    .labelsHidden()
                                                                    .onChange(of: selectedDate) { newValue in
                                                                        if let date = newValue {
                                                                            proposalFormTextAnswers[field.key ?? ""]  = dateFormatter.string(from: date)
                                                                            field.defaultValue = dateFormatter.string(from: date)
                                                                            
                                                                        } else {
                                                                            proposalFormTextAnswers[field.key ?? ""]  = ""
                                                                            
                                                                        }
                                                                    }
                                                                    .onTapGesture {
                                                                        isShowingDatePicker = false
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                        
                                                        
                                                        if field.type == "select" {
                                                            Text("\(templateOptions.label ) \(templateOptions.required ? "*" : "")")
                                                                .halfTextColorChange(fullText: "\(templateOptions.label ) \(templateOptions.required ? "*" : "")", changeText: "*")
                                                                .font(isFontMedium(size: 18))
                                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                                .padding(.leading)
                                                                .padding(.top,10)
                                                            
                                                            TextField("\(templateOptions.placeholder ?? "")", text: Binding<String>(
                                                                get: {
                                                                    field.defaultValue ?? ""
                                                                },
                                                                set: { newValue in
                                                                    proposalFormTextAnswers[field.key ?? ""] = newValue
                                                                    field.defaultValue = newValue
                                                                }
                                                            ))
                                                            .disabled(true)
                                                            .padding(10)
                                                            //                                                                .frame(maxWidth:.infinity)
                                                            .frame(width: 350,height:50)
                                                            .autocapitalization(.none)
                                                            .autocorrectionDisabled()
                                                            .font(isFontMedium(size: 18))
                                                            .autocapitalization(.none)
                                                            .autocorrectionDisabled()
                                                            .background(Color.gray.opacity(0.2))
                                                            .foregroundColor(.black)
                                                            .cornerRadius(8)
                                                            .overlay (
                                                                
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
                                                                    selectedProposalFormField = field.key ?? ""
                                                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                                                    masterCatagoryID = templateOptions.categoryID ?? 0
                                                                    
                                                                    cascadingParentControlValue = templateOptions.cascadingParentControl ?? ""
                                                                    
                                                                    
                                                                    if indexvalue + 1 < value.fieldGroup.count {
                                                                        let nextProduct = value.fieldGroup[indexvalue + 1]
                                                                        
                                                                        // Access properties of nextProduct's templateOptions safely
                                                                        if let nextTemplateOptions = nextProduct.templateOptions,
                                                                           field.key == nextTemplateOptions.cascadingParentControl {
                                                                            masterDataApiUrl = nextTemplateOptions.apiUrl ?? ""
                                                                            masterDataInputParameter = nextTemplateOptions.inputParameter ?? ""
                                                                            
                                                                            print("apiUrl ---> \(nextTemplateOptions.apiUrl ?? "")")
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                            
                                                        }
                                                        
                                                        
                                                        
                                                        if field.type == "radio" {
                                                            
                                                            Text("\(templateOptions.label ) \(templateOptions.required ? "*" : "")")
                                                                .halfTextColorChange(fullText: "\(templateOptions.label ) \(templateOptions.required ? "*" : "")", changeText: "*")
                                                                .font(isFontMedium(size: 18))
                                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                                .padding(.leading)
                                                                .padding(.top,10)
                                                            
                                                            VStack {
                                                                if let options = templateOptions.options {
                                                                    
                                                                    if let isOnloadAPICall = templateOptions.isOnloadAPICall, isOnloadAPICall && options.isEmpty {
                                                                        
                                                                        ForEach(masterDatavalue.indices, id: \.self) { index in
                                                                            let option = masterDatavalue[index]
                                                                            if templateOptions.categoryID == option.categoryID {
                                                                                Button(action: {
                                                                                    
                                                                                    proposalFormTextAnswers[field.key ?? ""]  = option.label
                                                                                    field.defaultValue = option.label
                                                                                    
                                                                                    selectedMasterData = option.label
                                                                                    
                                                                                }) {
                                                                                    
                                                                                    HStack(spacing:10) {
                                                                                        
                                                                                        Image(systemName: selectedMasterData == option.label ? "smallcircle.fill.circle" : "circle")
                                                                                            .foregroundColor(fontOrangeColour)
                                                                                            .font(isFontMedium(size: 22))
                                                                                            .bold()
                                                                                        
                                                                                        Text(option.label)
                                                                                            .foregroundColor(.black)
                                                                                            .font(isFontMedium(size: 17))
                                                                                        
                                                                                    }
                                                                                    .frame(maxWidth:.infinity,alignment:.leading)
                                                                                    .padding(2)
                                                                                    
                                                                                    
                                                                                }
                                                                            }
                                                                        }
                                                                    } else {
                                                                        
                                                                        ForEach(options, id: \.label) { option in
                                                                            
                                                                            
                                                                            Button(action: {
                                                                                
                                                                                proposalFormTextAnswers[field.key ?? ""]  = option.label
                                                                                field.defaultValue = option.label
                                                                                
                                                                                selectedProposalRadio = option.label
                                                                                
                                                                            }) {
                                                                                
                                                                                HStack(spacing:10) {
                                                                                    
                                                                                    Image(systemName: selectedProposalRadio == option.label ? "smallcircle.fill.circle" : "circle")
                                                                                        .foregroundColor(fontOrangeColour)
                                                                                        .font(isFontMedium(size: 22))
                                                                                        .bold()
                                                                                    
                                                                                    Text(option.label)
                                                                                        .foregroundColor(.black)
                                                                                        .font(isFontMedium(size: 17))
                                                                                    
                                                                                }
                                                                                .frame(maxWidth:.infinity,alignment:.leading)
                                                                                .padding(2)
                                                                                
                                                                                
                                                                            }
                                                                        }
                                                                    }
                                                                    
                                                                }
                                                            }
                                                            .padding(5)
                                                            .frame(width:350)
                                                            .background(Color.gray.opacity(0.2))
                                                            .cornerRadius(8)
                                                        }
                                                        
                                                        
                                                        if field.type == "textarea" {
                                                            
                                                            Text("\(templateOptions.label ) \(templateOptions.required ? "*" : "")")
                                                                .halfTextColorChange(fullText: "\(templateOptions.label ) \(templateOptions.required ? "*" : "")", changeText: "*")
                                                                .font(isFontMedium(size: 18))
                                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                                .padding(.leading)
                                                                .padding(.top,10)
                                                            
                                                            
                                                            TextField("\(templateOptions.placeholder ?? "")", text: Binding<String>(
                                                                get: {
                                                                    
                                                                    field.defaultValue ?? ""
                                                                    
                                                                },
                                                                set: { newValue in
                                                                    proposalFormTextAnswers[field.key ?? ""] = newValue
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
                                                        
                                                        
                                                        if field.type == "quill-editor" {
                                                            
                                                            Text("\(templateOptions.label ) \(templateOptions.required ? "*" : "")")
                                                                .halfTextColorChange(fullText: "\(templateOptions.label ) \(templateOptions.required ? "*" : "")", changeText: "*")
                                                                .font(isFontMedium(size: 18))
                                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                                .padding(.leading)
                                                                .padding(.top,10)
                                                            
                                                            TextField("\(templateOptions.placeholder ?? "")", text: Binding<String>(
                                                                get: {
                                                                    
                                                                    field.defaultValue ?? ""
                                                                    
                                                                },
                                                                set: { newValue in
                                                                    proposalFormTextAnswers[field.key ?? ""] = newValue
                                                                    field.defaultValue = newValue
                                                                    
                                                                }
                                                            ),axis: .vertical)
                                                            .padding(10)
                                                            .frame(width: 350)
                                                            .frame(minHeight:50)
                                                            .autocapitalization(.none)
                                                            .autocorrectionDisabled()
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
                                   
                                    
                                    VStack(spacing:10) {
                                        if addonsTextDisplayed {
                                            Text("Addons")
                                                .font(isFontMedium(size: 18))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(.leading)
                                                .padding(.top,10)
                                            
                                            TextField("Select", text: Binding<String>(
                                                get: {
                                                    proposalFormTextAddonAnswers[proposalFormAddonKeys]?.joined(separator: ",") ?? ""
                                                },
                                                set: { newValue in
                                                    proposalFormTextAddonAnswers[proposalFormAddonKeys] = newValue.components(separatedBy: ",")
                                                    
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
                                                    showAddonPopup.toggle()
                                                    
                                                }
                                            }
                                        }
                                        
                                        
                                        ForEach(getProposalDetailArray, id: \.key) { field in
                                            if let fieldValue = field.fieldGroup {
                                                ForEach(fieldValue, id: \.key) { value in
                                                    let templateOptions = value.templateOptions
                                                    if proposalFormAddonVisibility.contains("\(templateOptions?.label ?? "")") {
                                                        
                                                        if value.type ?? "" == "select" {
                                                            Text("\(templateOptions?.label ?? "") \(templateOptions?.required ?? false ? "*" : "")")
                                                                .halfTextColorChange(fullText: "\(templateOptions?.label ?? "") \(templateOptions?.required ?? false ? "*" : "")", changeText: "*")
                                                                .font(isFontMedium(size: 18))
                                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                                .padding(.leading)
                                                                .padding(.top,10)
                                                            
                                                            TextField("\(templateOptions?.placeholder ?? "")", text: Binding<String>(
                                                                get: {
                                                                    //                                                                proposalFormTextAnswers[value.key ?? ""] ?? ""
                                                                    value.defaultValue ?? ""
                                                                    
                                                                },
                                                                set: { newValue in
                                                                    //                                                                proposalFormTextAnswers[value.key ?? ""] = newValue
                                                                    value.defaultValue = newValue
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
                                                                    selectedProposalFormField = value.key ?? ""
                                                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                                                }
                                                            }
                                                        }
                                                        
                                                        if value.type ?? "" == "input" {
                                                            Text("\(templateOptions?.label ?? "") \(templateOptions?.required ?? false ? "*" : "")")
                                                                .halfTextColorChange(fullText: "\(templateOptions?.label ?? "") \(templateOptions?.required ?? false ? "*" : "")", changeText: "*")
                                                                .font(isFontMedium(size: 18))
                                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                                .padding(.leading)
                                                                .padding(.top,10)
                                                            
                                                            TextField("\(templateOptions?.placeholder ?? "")", text: Binding<String>(
                                                                get: {
                                                                    value.defaultValue ?? ""
                                                                    
                                                                },
                                                                set: { newValue in
                                                                    proposalFormTextAnswers[value.key ?? ""] = newValue
                                                                    value.defaultValue = newValue
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
                            .frame(maxWidth:.infinity, alignment:.leading)
                            .padding(5)
                        
                        
                        VStack {
//                            NavigationLink("", destination: GeneratePolicy(), isActive: $navigateGeneratePolicyPage)
                            
                            Button(action: {
                                proposalFormValidation()
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
//                        fetchGetProposalForm()
//                        proposalFormSelectedItem = proposalFormSelectedItems
                        
                        fetchAllProposalForm()
                        getPhoneCode()
                        
//                        fetchJsonData()
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
//                                navigateQuotationPage = true
                                
                                withAnimation {
                                    navigateProposalForm = false
                                }
                            })
                            {
                                
                                Image(systemName: "arrow.backward")
                                    .bold()
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .padding(.bottom)
                                
                            }
                            
                            Text("Proposal Forms")
                                .bold()
                                .font(isFontBlack(size: 22))
                                .foregroundColor(.white)
                                .padding(.bottom,8)
                            
//                            NavigationLink("", destination: QuotationPage(), isActive: $navigateQuotationPage)
                        }
                    }
                }
                .toolbarBackground(toolbarcolor,for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .navigationBarBackButtonHidden()
        
        .overlay {
            isOverlayVisible ? GeneratePolicy(isOverlayVisible: $isOverlayVisible) : nil
            
            navigateSelfAssessment ? SelfAssessment(navigateSelfAssessment: $navigateSelfAssessment) : nil
        }
       
        .overlay {
            navigateLineofBusiness ? LineOfBusinessView(navigateInsuranceOptiondPage: .constant(false)) : nil
        }
        
        .overlay {
            !networkMonitor.isConnected ? ErrorView() : nil
            
            
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
        }
        
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
                        .ignoresSafeArea()
                        .onTapGesture {
                            isDropdownOpen = false
                        }
                    
                    VStack {
                        Spacer()
                        List {
                            
                            ForEach(getProposalFormDataArray.indices ,id: \.self) { index in
                                let value = getProposalFormDataArray[index]
                                
                                ForEach(value.fieldGroup.indices, id: \.self) { indexvalue in
                                    let field = value.fieldGroup[indexvalue]
                                    
                                    if let templateOptions = field.templateOptions,
                                       let options = templateOptions.options {
                                        
                                        if selectedProposalFormField == field.key ?? ""  {
                                            ForEach(options, id: \.value) { option in
                                                
                                                if let multiple = templateOptions.multiple, multiple {
                                                    
                                                    HStack(spacing: 10) {
                                                        Button(action: {
                                                            
                                                            if selectedItem.contains(option.label) {
                                                                selectedItem.remove(option.label)
                                                            } else {
                                                                selectedItem.insert("\(option.label)")
                                                            }
                                                            
                                                            field.defaultValue = selectedItem.joined(separator: ", ")
                                                            
                                                        }) {
                                                            Image(systemName: selectedItem.contains(option.label) ? "checkmark.square.fill" : "square")
                                                                .bold()
                                                                .font(isFontMedium(size: 25))
                                                                .foregroundColor(fontOrangeColour)
                                                            
                                                        }
                                                        
                                                        Text(option.label)
                                                            .padding(10)
                                                            .foregroundColor(.black)
                                                            .frame(maxWidth:.infinity,alignment:.leading)
                                                    }
                                                    
                                                } else {
                                                    
                                                    Button(action: {
                                                        
                                                        isDropdownOpen = false
                                                        proposalFormTextAnswers[field.key ?? ""]  = option.label
                                                        field.defaultValue = option.label
                                                        
                                                        
                                                    }) {
                                                        Text(option.label)
                                                            .padding(10)
                                                            .foregroundColor(.black)
                                                            .frame(maxWidth:.infinity,alignment:.leading)
                                                    }
                                                }
                                            }
                                            
                                            if let multiple = templateOptions.multiple, multiple {
                                                Text("OK")
                                                    .font(isFontMedium(size: 20))
                                                    .frame(maxWidth:.infinity, alignment:.trailing)
                                                    .padding(.trailing)
                                                    .padding(.bottom)
                                                    .foregroundColor(toolbarcolor)
                                                    .onTapGesture {
                                                        isDropdownOpen = false
                                                    }
                                            }
                                            
                                            
                                            if let isOnloadAPICall = templateOptions.isOnloadAPICall, isOnloadAPICall && options.isEmpty {
                                                
                                                ForEach(masterDatavalue.indices, id: \.self) { index in
                                                    let option = masterDatavalue[index]
                                                    if masterCatagoryID == option.categoryID {
                                                        
                                                        Button(action: {
                                                            
                                                            isDropdownOpen = false
                                                            proposalFormTextAnswers[field.key ?? ""]  = option.label
                                                            field.defaultValue = option.label
                                                            
                                                            
                                                            if indexvalue + 1 < value.fieldGroup.count {
                                                                let nextProduct = value.fieldGroup[indexvalue + 1]
                                                                
                                                                // Access properties of nextProduct's templateOptions safely
                                                                if let nextTemplateOptions = nextProduct.templateOptions,
                                                                   field.key == nextTemplateOptions.cascadingParentControl {
                                                                    
                                                                    cascadingParentControlValue = option.value
                                                                    
                                                                    fetchMasterData(vehicleMakeID: option.value)
                                                                    
                                                                }
                                                            }
                                                                
                                                            
                                                            
                                                        }) {
                                                            Text(option.label)
                                                                .padding(10)
                                                                .foregroundColor(.black)
                                                                .frame(maxWidth:.infinity,alignment:.leading)
                                                        }
                                                    }
                                                }
                                                
                                            }
                                            
                                            
                                            ForEach(masterDataArray, id: \.masterDataID) { masterData in
                                                
                                                if cascadingParentControlValue == field.templateOptions?.cascadingParentControl {
                                                    Button(action: {
                                                        
                                                        field.defaultValue = masterData.mdTitle
                                                        textAnswersParameters[field.key ?? ""] = masterData.masterDataID
                                                        
                                                        if var key = field.key {
                                                            key = key.replacingOccurrences(of: "ID", with: "")
                                                            proposalFormTextAnswers[key] = masterData.mdTitle
                                                        }
                                                        
                                                        if indexvalue + 1 < value.fieldGroup.count {
                                                            let nextProduct = value.fieldGroup[indexvalue + 1]
                                                            
                                                            // Access properties of nextProduct's templateOptions safely
                                                            if let nextTemplateOptions = nextProduct.templateOptions,
                                                               field.key == nextTemplateOptions.cascadingParentControl {
                                                                
                                                                cascadingParentControlValue = masterData.masterDataID
                                                                
                                                                fetchMasterData(vehicleMakeID: masterData.masterDataID)
                                                                
                                                            }
                                                        }
                                                        
                                                        isDropdownOpen = false
                                                    }) {
                                                        Text(masterData.mdTitle)
                                                            .padding(10)
                                                            .foregroundColor(.black)
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                            .listRowSeparator(.hidden)
                                                    }
                                                }
                                            }
                                            
                                        }
                                    }
                                    
                                    
                                    if let fieldValue = field.fieldGroup {
                                        ForEach(fieldValue, id: \.key) { value in
                                            let templateOptions = value.templateOptions
                                            if proposalFormAddonVisibility.contains("\(templateOptions?.label ?? "")") {
                                                if let option = templateOptions?.options {
                                                    ForEach(option, id: \.label) { item in
                                                        
                                                        Button(action: {
                                                            isDropdownOpen = false
                                                            proposalFormTextAnswers[value.key ?? ""] = item.label
                                                            value.defaultValue = item.label
                                                        })
                                                        {
                                                            Text(item.label)
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
                            
                         
                            ForEach(getProposalDetailArray, id: \.key) { field in
                                if let fieldValue = field.fieldGroup {
                                    ForEach(fieldValue, id: \.key) { value in
                                        let templateOptions = value.templateOptions
                                        if proposalFormAddonVisibility.contains("\(templateOptions?.label ?? "")") {
                                            if let option = templateOptions?.options {
                                                ForEach(option, id: \.label) { item in
                                                    
                                                    Button(action: {
                                                        isDropdownOpen = false
                                                        proposalFormTextAnswers[value.key ?? ""] = item.label
                                                        value.defaultValue = item.label
                                                    })
                                                    {
                                                        Text(item.label)
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
                        .listStyle(.plain)
                        .frame(width: 300)
                        .cornerRadius(0)
                        .shadow(radius: 3)
                        
                        Spacer()
                    }
                    .frame(height: 500)
                    .offset(y: isDropdownOpen ? 125 : 0)
                    
                }
                
            }
            
            
            
            if showAddonPopup {
                ZStack {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showAddonPopup = false
                        }
                    VStack {
                        List {
                            ForEach(getProposalDetailArray, id: \.key) { field in
                                if let fieldValue = field.fieldGroup {
                                    ForEach(fieldValue, id: \.key) { value in
                                        
                                        let templateOptions = value.templateOptions
                                        if value.type == "checkbox" {
                                            if let key = value.key, key.hasPrefix("ADDON") {
                                                
                                                Button(action:{
                                                    
                                                    if proposalFormSelectedItem.contains("\(templateOptions?.label ?? "")") {
                                                        proposalFormSelectedItem.remove("\(templateOptions?.label ?? "")")
                                                        proposalFormSelectedItems.remove("\(templateOptions?.label ?? "")")
                                                        proposalFormSelectedAddonAnswers[key] = false
                                                        
                                                        // Checkbox is selected, hide the next label
                                                        if let selectedIndex = getIndexOfSelectedItem(label: templateOptions?.label ?? "") {
                                                            let nextIndex = (selectedIndex + 1) % fieldValue.count
                                                            if nextIndex < fieldValue.count {
                                                                let nextLabel = fieldValue[nextIndex].templateOptions?.label ?? ""
                                                                proposalFormAddonVisibility.remove(nextLabel)
                                                                print("Next Label Hidden: \(nextLabel)")
                                                            }
                                                        }
                                                        
                                                        
                                                    } else {
                                                        proposalFormSelectedItem.insert("\(templateOptions?.label ?? "")")
                                                        proposalFormSelectedItems.insert("\(templateOptions?.label ?? "")")
                                                        proposalFormSelectedAddonAnswers[key] = true
                                                        
                                                        // Checkbox is selected, show the next label
                                                        if let selectedIndex = getIndexOfSelectedItem(label: templateOptions?.label ?? "") {
                                                            let nextIndex = (selectedIndex + 1) % fieldValue.count
                                                            if nextIndex < fieldValue.count {
                                                                let nextLabel = fieldValue[nextIndex].templateOptions?.label ?? ""
                                                                proposalFormAddonVisibility.insert(nextLabel)
                                                                print("Next Label Shown: \(nextLabel)")
                                                            }
                                                        }
                                                    }
                                                    
                                                    proposalFormTextAddonAnswers[proposalFormAddonKeys] = Array(proposalFormSelectedItem)
                                                    
                                                })
                                                {
                                                    HStack {
                                                        
                                                        Image(systemName: proposalFormSelectedItem.contains("\(templateOptions?.label ?? "")") ? "checkmark.square.fill" : "square")
                                                            .bold()
                                                            .font(isFontMedium(size: 20))
                                                            .foregroundColor(.black)
                                                            .padding(.top)
                                                        
                                                        Text(templateOptions?.label ?? "")
                                                            .font(isFontMedium(size: 18))
                                                            .foregroundColor(.black)
                                                            .frame(maxWidth:.infinity,alignment:.leading)
                                                            .padding(.top)
                                                        
                                                    }.padding(.leading)
                                                }
                                                
                                            }
                                        }
                                    }
                                }
                            }.listRowSeparator(.hidden)
                            
                            Text("OK")
                                .font(isFontMedium(size: 20))
                                .frame(maxWidth:.infinity, alignment:.trailing)
                                .padding(.trailing)
                                .padding(.top)
                                .foregroundColor(toolbarcolor)
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
        }
        
       
    }


    
    private func getDateRange(templateOptions: ProposalFormDataResponse.ProposalFormDataValues.FetchFormData.FormDataField.FieldGroup.TemplateOptions,formFields: [ProposalFormDataResponse.ProposalFormDataValues.FetchFormData.FormDataField.FieldGroup]) -> ClosedRange<Date> {
        
        var isReturnMax = ""
        var minDate = Date()
        var maxDate = Date()
        
        var isDependencyReturn = ""
        var dependCalendar = Date()
        
        var defaultDate = Date()
        
        // Calculate minDate and maxDate based on isDependency flag
        if templateOptions.isDependency ?? false {
            if let dateParentControl = templateOptions.dateParentControl, !dateParentControl.isEmpty {
                if let field = formFields.first(where: { $0.key == dateParentControl }) {
                    if let answerValue = field.defaultValue, !answerValue.isEmpty {
                        let dateFormat = DateFormatter()
                        dateFormat.dateFormat = "dd-MMM-yyyy"
                        if let date = dateFormat.date(from: answerValue) {
                            // Use the parent control date as the minimum date
                            dependCalendar = date
                            print("Dependent Date: \(date )")
                            
                            
                            if let dateMinType = templateOptions.dateTypeMinDepent, let dateMaxType = templateOptions.dateTypeMaxDepent {
                                                                
                                minDate = dependencyCalculateDate(type: dateMinType, value: templateOptions.countMinDepent ?? 0, fromDate: dependCalendar)
                                maxDate = dependencyCalculateDate(type: dateMaxType, value: templateOptions.countMaxDepent ?? 0, fromDate: dependCalendar)
                                
                                isDependencyReturn = "Min"
                                
                            } else {
                                if let dateMaxType = templateOptions.dateTypeMaxDepent {
                                    
                                    maxDate = dependencyCalculateDate(type: dateMaxType, value: templateOptions.countMaxDepent ?? 0, fromDate: dependCalendar)
                                    
                                    isDependencyReturn = "Max"
                                    
                                }
                            }
                            
                            if isDependencyReturn == "Min" {
                                // Ensure minDate is earlier than or equal to maxDate
                                let rangeStart = min(minDate, maxDate)
                                let rangeEnd = max(minDate, maxDate)
                                return rangeStart...rangeEnd
                            } else {
                                return dependCalendar...maxDate
                            }
                        }
                    }
                }
            }
            
        }
        
        if let dateMinType = templateOptions.dateMinType, let dateMaxType = templateOptions.dateMaxType {
            // Calculate minDate based on the provided type
            minDate = calculateDate(type: dateMinType, value: templateOptions.countMin ?? 0)
            maxDate = calculateDate(type: dateMaxType, value: templateOptions.countMax ?? 0)
            isReturnMax = "no"
        } else {
            if let dateMaxType = templateOptions.dateMaxType {
                // Calculate maxDate based on the provided type
                maxDate = getMaxDate(templateOptions: templateOptions)
                isReturnMax = "yes"
            }
        }
        
        if isReturnMax == "no" {
            // Ensure minDate is earlier than or equal to maxDate
            let rangeStart = min(minDate, maxDate)
            let rangeEnd = max(minDate, maxDate)
            return rangeStart...rangeEnd
        } else {
            
            if isReturnMax == "yes" {
                // Return a range with any date before maxDate as start and maxDate as end
                let startDate = Calendar.current.date(byAdding: .year, value: -100, to: maxDate)! // Adjust the start date as needed
                return startDate...maxDate
            } else {

                let startDate = Date.distantPast
                let endDate = Date.distantFuture
                return startDate...endDate
            }
            
        }
    }
    
    
    private func dependencyCalculateDate(type: String, value: Int, fromDate: Date) -> Date {
        let calendar = Calendar.current
        switch type {
        case "date_forward":
            return calendar.date(byAdding: .day, value: value, to: fromDate) ?? Date()
        case "month_forward":
            return calendar.date(byAdding: .month, value: value, to: fromDate) ?? Date()
        case "year_forward":
            return calendar.date(byAdding: .year, value: value, to: fromDate) ?? Date()
        case "date_backward":
            return calendar.date(byAdding: .day, value: -value, to: fromDate) ?? Date()
        case "month_backward":
            return calendar.date(byAdding: .month, value: -value, to: fromDate) ?? Date()
        case "year_backward":
            return calendar.date(byAdding: .year, value: -value, to: fromDate) ?? Date()
        default:
            return Date()
        }
    }
    
    private func calculateDate(type: String, value: Int) -> Date {
        let calendar = Calendar.current
        var date = Date()
        
        switch type {
        case "date_forward":
            date = calendar.date(byAdding: .day, value: value, to: date) ?? Date()
        case "month_forward":
            date = calendar.date(byAdding: .month, value: value, to: date) ?? Date()
        case "year_forward":
            date = calendar.date(byAdding: .year, value: value, to: date) ?? Date()
        case "date_backward":
            date = calendar.date(byAdding: .day, value: -value, to: date) ?? Date()
        case "month_backward":
            date = calendar.date(byAdding: .month, value: -value, to: date) ?? Date()
        case "year_backward":
            date = calendar.date(byAdding: .year, value: -value, to: date) ?? Date()
        default:
            break
        }
        return date
    }

    private func getMaxDate(templateOptions: ProposalFormDataResponse.ProposalFormDataValues.FetchFormData.FormDataField.FieldGroup.TemplateOptions) -> Date {
        var maxDate = Date()
        
        if let dateMinType = templateOptions.dateMinType {
            // Calculate minDate based on the provided type (but we won't use it)
            _ = calculateDate(type: dateMinType, value: templateOptions.countMin ?? 0)
        }

        if let dateMaxType = templateOptions.dateMaxType {
            // Calculate maxDate based on the provided type
            maxDate = calculateDate(type: dateMaxType, value: templateOptions.countMax ?? 0)
        }
        
        return maxDate
    }
    
    
//    private func getDateRange(templateOptions: ProposalFormDataResponse.ProposalFormDataValues.FetchFormData.FormDataField.FieldGroup.TemplateOptions,formFields: [ProposalFormDataResponse.ProposalFormDataValues.FetchFormData.FormDataField.FieldGroup]) -> ClosedRange<Date> {
//        var isReturnMax = ""
//        var minDate = Date()
//        var maxDate = Date()
//        
//        var dependCalendar = Date()
//        
//        
//        // Calculate minDate and maxDate based on isDependency flag
//        if templateOptions.isDependency ?? false {
//            if let dateParentControl = templateOptions.dateParentControl, !dateParentControl.isEmpty {
//                if let field = formFields.first(where: { $0.key == dateParentControl }) {
//                    if let answerValue = field.defaultValue, !answerValue.isEmpty {
//                        let dateFormat = DateFormatter()
//                        dateFormat.dateFormat = "dd-MMM-yyyy"
//                        if let date = dateFormat.date(from: answerValue) {
//                            // Use the parent control date as the minimum date
//                            dependCalendar = date
//                            print("Dependent Date: \(dependCalendar )")
//                            
//                        }
//                    }
//                }
//            }
//        }
//        
//        if let dateMinType = templateOptions.dateMinType, let dateMaxType = templateOptions.dateMaxType {
//            // Calculate minDate based on the provided type
//            minDate = calculateDate(type: dateMinType, value: templateOptions.countMin ?? 0)
//            maxDate = calculateDate(type: dateMaxType, value: templateOptions.countMax ?? 0)
//            isReturnMax = "no"
//        } else {
//            if let dateMaxType = templateOptions.dateMaxType {
//                // Calculate maxDate based on the provided type
//                maxDate = getMaxDate(templateOptions: templateOptions)
//                isReturnMax = "yes"
//            }
//        }
//        
//        if isReturnMax == "no" {
//            // Ensure minDate is earlier than or equal to maxDate
//            let rangeStart = min(minDate, maxDate)
//            let rangeEnd = max(minDate, maxDate)
//            return rangeStart...rangeEnd
//        } else {
//            // Return a range with any date before maxDate as start and maxDate as end
//            let startDate = Calendar.current.date(byAdding: .year, value: -100, to: maxDate)! // Adjust the start date as needed
//            return startDate...maxDate
//            
//        }
//    }
        
    
   
    
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
                    getCountry = countries
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }

        dataTask.resume()
    }
    
    
    // Helper function to get the index of the selected item
    func getIndexOfSelectedItem(label: String) -> Int? {
        return getProposalDetailArray
            .flatMap { $0.fieldGroup ?? [] }
            .enumerated()
            .first(where: { $0.element.templateOptions?.label == label })?
            .offset
    }
    
    
    func proposalFormValidation() {
        
        for product in getProposalFormDataArray {
            for fieldGroup in product.fieldGroup {
                if let key = fieldGroup.key, let templateOptions = fieldGroup.templateOptions {
                    let answer = fieldGroup.defaultValue?.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    if templateOptions.required && (answer?.isEmpty ?? true) && !templateOptions.label.isEmpty && ((fieldGroup.type?.isEmpty) != nil) {
                        if let validation = fieldGroup.validation {
                            self.alertItem = AlertItem(title: Text("ERR018 \n \(validation.messages.required ?? "")"))
                            return
                        }
                    }
                    
                    if key.lowercased().contains("phonenumber") && templateOptions.required && (answer?.isEmpty ?? true) {
                        
                        if let validation = fieldGroup.validation {
                            self.alertItem = AlertItem(title: Text("ERR018 \n \(validation.messages.required ?? "")"))
                            return
                        }
                    }
                    
                    // Check for minLength validation
                    if let minLengthMessage = fieldGroup.validation?.messages.minLength,
                       let fieldValue = answer {
                        switch templateOptions.minLength {
                        case .int(let minLengthInt)?:
                            if fieldValue.count <= minLengthInt {
                                self.alertItem = AlertItem(title: Text("ERR018 \n \(minLengthMessage)"))
                                return
                            }
                        case .string(let minLengthString)?:
                            if let minLengthInt = Int(minLengthString), fieldValue.count <= minLengthInt {
                                self.alertItem = AlertItem(title: Text("ERR018 \n \(minLengthMessage)"))

                                return
                            }
                        case .none:
                            break // No minLength specified
                        }
                    }

                    // Check for maxLength validation
                    if let maxLengthMessage = fieldGroup.validation?.messages.maxLength,
                       let fieldValue = answer {
                        switch templateOptions.maxLength {
                        case .int(let maxLengthInt)?:
                            if fieldValue.count >= maxLengthInt {
                                self.alertItem = AlertItem(title: Text("ERR018 \n \(maxLengthMessage)"))
                                return
                            }
                        case .string(let maxLengthString)?:
                            if let maxLengthInt = Int(maxLengthString), fieldValue.count >= maxLengthInt {
                                self.alertItem = AlertItem(title: Text("ERR018 \n \(maxLengthMessage)"))
                                return
                            }
                        case .none:
                            break // No maxLength specified
                        }
                    }

                    
                }
            }
        }
        
        fetchInsertFormStep()
    }


    func fetchJsonData() {
        guard let visibilityData = proposalFormJsonData.data(using: .utf8) else {
            print("Error converting 'viewJson' to data")
            return
        }

        // Print the JSON data before decoding
        if let jsonString = String(data: visibilityData, encoding: .utf8) {
            print("JSON Data: \(jsonString)")
        } else {
            print("Error converting data to string")
        }

        do {
            let visibilityModel = try JSONDecoder().decode(ProposalFormDataResponse.self, from: visibilityData)
            
            getProposalFormDataArray = visibilityModel.rObj.fetchFormData.formData
            
            fetchGetAllMasterData()
            
            print("Success")
        } catch {
            print("Error decoding visibility data: \(error)")
        }
    }

    
    func fetchAllProposalForm() {
        
        isLoading = true
        
        let parameters: [String: Any?] = [
            "quotationDetailRefID":  Extensions.quotationDetailRefID
//            "388ed80b-62c0-4b9e-b77f-e646a9ac9c67"
        ]
        
        print("AllProposalForm \(parameters)")
        
        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(BaseURL)")!,
                                         path: "api/prodconfig/Quotation/FetchAllProposalForm",
                                         method: "POST",bodyData:parameters as [String : Any])
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<FetchAllProposalFormResponse, Error>) in
            switch result {
            case .success(let proposalFormResponse):
                
                // Handle success
                DispatchQueue.main.async {
                    
                    if proposalFormResponse.rcode == 200 {
                        print(proposalFormResponse.rcode)
                        isLoading = false
                        

                        fetchAllProposalformArray = proposalFormResponse.rObj.fetchAllProposalForm
                       
                        if let formRefID = fetchAllProposalformArray.first?.formRefID {
                            fetchProposalFormData(formRefID: formRefID)
                        }
                        
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
    
    
    func fetchProposalFormData(formRefID: String) {
        
        isLoading = true
        
        let parameters: [String: Any] = [
            "formRefID": "c5b27131-bbf9-4541-bdf9-25944664ad7e" /*formRefID*/
        ]
        
        print("ProposalFormData \(parameters)")
        
        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(loginBaseURL)")!,
                                         path: "api/digital/core/Organization/FetchFormData",
                                         method: "POST",bodyData:parameters)
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<ProposalFormDataResponse, Error>) in
            switch result {
            case .success(let proposalFormResponse):
                // Handle success
                DispatchQueue.main.async {
                    
                    if proposalFormResponse.rcode == 200 {
                        print(proposalFormResponse.rcode)
                        isLoading = false
                        
                        getProposalFormDataArray = proposalFormResponse.rObj.fetchFormData.formData
                        
                        fetchGetAllMasterData()
                        
                        
                        
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
    
 
    
    
    func fetchUploadFile(currentFile: URL) {
       
        let postUrl = "\(loginBaseURL)api/digital/core/Document/UploadFile"
        let authToken = "Bearer " + Extensions.token
        
        // Create the multipart form data
        let boundary = UUID().uuidString
        
        var request = URLRequest(url: URL(string: postUrl)!)
        request.httpMethod = "POST"
        request.setValue(authToken, forHTTPHeaderField: "Authorization")
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        // Add fileName parameter
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"fileName\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(currentFile.lastPathComponent)\r\n".data(using: .utf8)!)
        
        // Add title parameter
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"title\"\r\n\r\n".data(using: .utf8)!)
        body.append("self assessment file upload\r\n".data(using: .utf8)!)
        
        // Add description parameter
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"description\"\r\n\r\n".data(using: .utf8)!)
        body.append("self assessment file upload\r\n".data(using: .utf8)!)
        
        // Add file data
        do {
            let fileData = try Data(contentsOf: currentFile)
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"image\"; fileName=\"\(currentFile.lastPathComponent)\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
            body.append(fileData)
            
            body.append("\r\n".data(using: .utf8)!)
           
        } catch {
            print("Error loading file data: \(error)")
            return
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        // Set the request body
        request.httpBody = body
        
        // Perform the request
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                isSingleFileCircleLoading = false
                isFileUploadCircleLoading[currentFile.lastPathComponent] = false
                return
            }
            
            if let data = data {
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let rcode = json?["rcode"] as? Int {
                        
                        if rcode == 200 {
                            print("Response Code: \(rcode)")
                        } else {
                            if let errorDict = Extensions.getValidationDict() as? [String: String] {
                                if let errorMessage = errorDict["API001"] {
                                    self.alertItem = AlertItem(title: Text("API001 \n \(errorMessage.localized())"))
                                }
                            }
                        }
                        
                    } else {
                        print("Error: Unable to fetch rcode from response")
                        
                        if let errorDict = Extensions.getValidationDict() as? [String: String] {
                            if let errorMessage = errorDict["ERR014"] {
                                self.alertItem = AlertItem(title: Text("ERR014 \n \(errorMessage.localized())"))
                            }
                        }
                    }
                    
                    isSingleFileCircleLoading = false
                   
                    isFileUploadCircleLoading[currentFile.lastPathComponent] = false
                } catch {
                    print("Error parsing JSON: \(error)")
                    isSingleFileCircleLoading = false
                    isFileUploadCircleLoading[currentFile.lastPathComponent] = false
                    
                    if let errorDict = Extensions.getValidationDict() as? [String: String] {
                        if let errorMessage = errorDict["ERR014"] {
                            self.alertItem = AlertItem(title: Text("ERR014 \n \(errorMessage.localized())"))
                        }
                    }
                }
            }
            
            do {
                if let responseString = String(data: data!, encoding: .utf8) {
                    print("Response: \(responseString)")
                   
                }
                
                isSingleFileCircleLoading = false
                isFileUploadCircleLoading[currentFile.lastPathComponent] = false
            } catch {
                print("Error decoding response: \(error)")
               
                isSingleFileCircleLoading = false
                isFileUploadCircleLoading[currentFile.lastPathComponent] = false
                
                if let errorDict = Extensions.getValidationDict() as? [String: String] {
                    if let errorMessage = errorDict["ERR014"] {
                        self.alertItem = AlertItem(title: Text("ERR014 \n \(errorMessage.localized())"))
                    }
                }
            }
           
        }.resume()
    }


    func fetchGetAllMasterData() {
        
        isLoading = true
        
        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(BaseURL)")!,
                                         path: "api/prodconfig/MST/MasterData/FetchMasterData",
                                         method: "POST",bodyData: [:])
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<MasterDataResponse, Error>) in
            switch result {
            case .success(let getProductsResponse):
                // Handle success
                DispatchQueue.main.async {
                    
                    if getProductsResponse.rcode == 200 {
                        print(getProductsResponse.rcode)
                        
                        masterDataArray = getProductsResponse.rObj.fetchMasterData
                        
                        isLoading = false
                        
                        
                        for value in getProposalFormDataArray {
                            for fieldGroup in value.fieldGroup {
                                if let templateOptions = fieldGroup.templateOptions,
                                   let categoryID = templateOptions.categoryID {
                                    print("categoryID --- > \(categoryID)")
                                    
                                    for masterData in masterDataArray {
                                        // Unwrap mdCategoryID with if-let or default to 0 if it's nil
                                        if categoryID == masterData.mdCategoryID {
                                            print("mdTitle --- > \(masterData.mdTitle)")
                                            
                                            masterDatavalue.append((label: masterData.mdTitle, value: masterData.masterDataID, categoryID: masterData.mdCategoryID))
                                            
                                            print(masterDatavalue)
                                          
                                        }
                                    }
                                }
                            }
                        }
                        
                        
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

    
    func fetchInsertFormStep() {
        
        isLoading = true
        
        var informationsParameters: [String: Any] = [:]
        
        informationsParameters.merge(proposalFormTextAnswers) { (_, new) in new }
        informationsParameters.merge(proposalFormSelectedAddonAnswers) { (_, new) in new }
        
        let formRefID = fetchAllProposalformArray.first?.formRefID ?? ""
        let quotationFormID = fetchAllProposalformArray.first?.quoationFormID ?? ""
        
        let parameters: [String: Any?] = [
            "information": informationsParameters,
            "viewJson": "{}",
            "formRefID": formRefID,
            "quotationFormID": quotationFormID,
            "quotationDetailRefID": Extensions.quotationDetailRefID,

        ]
        
        print(parameters)
        
        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(BaseURL)")!,
                                         path: "api/prodconfig/Quotation/InsertFormStep",
                                         method: "POST",bodyData:parameters as [String : Any])
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<InsertProposalFormResponse, Error>) in
            switch result {
            case .success(let insertResponse):
                // Handle success
                DispatchQueue.main.async {
                    
                    if insertResponse.rcode == 200 {
                        print(insertResponse.rcode)
                        
                        fetchInsertProposalFormv2()
                        
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
    
    
    func fetchInsertProposalFormv2() {
        
        isLoading = true
      
        
        let parameters: [String: Any?] = [
           
            "quotationDetailRefID": Extensions.quotationDetailRefID

        ]
        
        print(parameters)
        
        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(BaseURL)")!,
                                         path: "api/prodconfig/Quotation/InsertProposalFormv2",
                                         method: "POST",bodyData:parameters as [String : Any])
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<InsertProposalFormv2Response, Error>) in
            switch result {
            case .success(let insertResponse):
                // Handle success
                DispatchQueue.main.async {
                    
                    if insertResponse.rcode == 200 {
                        print(insertResponse.rcode)
                        
                        if insertResponse.rObj.isSelfTask ?? false {
                            navigateSelfAssessment = true
                            selfAssessmentObjectID = insertResponse.rObj.policyID ?? ""
                        } else {
                            isOverlayVisible = true
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

    
    
    func fetchGetProposalForm() {
        
        isLoading = true
        
        let parameters: [String: Any] = [
            "productID": Extensions.productID,
            "quotationSearchProductID": Extensions.quotationDetailRefID
                ]

        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(BaseURL)")!,
                                         path: "api/digital/core/Product/GetProposalForm",
                                         method: "POST",bodyData:parameters)
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<GetProposalResponse, Error>) in
            switch result {
            case .success(let getProposalResponse):
                // Handle success
                DispatchQueue.main.async {
                    
                    if getProposalResponse.rcode == 200 {
                        print(getProposalResponse.rcode)
                        
                        getProposalDetailArray = getProposalResponse.rObj.getProposalForm.fieldGroup
                        
                        for productValues in getProposalDetailArray {
                            if let fieldGroup = productValues.fieldGroup {
                                for formField in fieldGroup {
                                    if let key = formField.key, key.hasPrefix("ADDON") {
                                        addonsTextDisplayed = true
                                        proposalFormAddonKeys.append(key)
                                    }
                                }
                            }
                        }

                        isLoading = false
                        
                        
                    } else {
                        self.alertItem = AlertItem(title: Text(getProposalResponse.rmsg.first?.errorText ?? ""))
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
    }
    
    
    
    func callInsertProposalFormAPI() {
        
        isLoading = true
        
        var informationsParameters: [String: Any] = [:]
        var viewJsonParametersList: [[String: Any]] = []

      for productValues in getProposalDetailArray {
          
          let templateOptionsParameters: [String: Any] = [
              "label": productValues.templateOptions?.label ?? "",
              "disabled": isDefaultValue
          ]
          
          let viewJsonParameters = [
              "Key": productValues.key ?? "" ,
              "defaultValue": productValues.defaultValue ?? "",
              "type": productValues.type ?? "",
              "templateOptions": templateOptionsParameters,
              "wrappers": productValues.wrappers,
              "className": productValues.className ?? ""
          ] as [String : Any]
          
          
          viewJsonParametersList.append(viewJsonParameters)
          
          if let fieldGroup = productValues.fieldGroup {
              for formField in fieldGroup {
                  
                  let templateOptionsParameters: [String: Any] = [
                      "label": formField.templateOptions?.label ?? "",
                      "disabled": isDefaultValue
                  ]
                  
                  let viewJsonParameters = [
                      "Key": formField.key ?? "" ,
                      "defaultValue": formField.defaultValue ?? "",
                      "type": formField.type ?? "",
                      "templateOptions": templateOptionsParameters,
                      "wrappers": formField.wrappers,
                      "className": formField.className ?? ""
                  ] as [String : Any]
                  
                  viewJsonParametersList.append(viewJsonParameters)
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
      
      
        informationsParameters.merge(proposalFormTextAnswers) { (_, new) in new }
        informationsParameters.merge(proposalFormSelectedAddonAnswers) { (_, new) in new }
      
        let parameters: [String: Any] = [
            "productID": Extensions.productID,
            "quoationSearchProductID": Extensions.quotationDetailRefID,
            "information": informationsParameters,
            "viewJson":viewJsonStringForInput]

        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(BaseURL)")!,
                                         path: "api/digital/core/ProposalForm/InsertProposalForm",
                                         method: "POST",bodyData:parameters)
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<InsertProposalFormResponse, Error>) in
            switch result {
            case .success(let getInsertProposalResponse):
                // Handle success
                DispatchQueue.main.async {
                    
                    if getInsertProposalResponse.rcode == 200 {
                        print(getInsertProposalResponse.rcode)
                        
//                        Extensions.policyID = getInsertProposalResponse.rObj.policyID
                        isLoading = false
                        withAnimation {
                            isOverlayVisible = true
                        }
                        
                        
                    } else {
                        self.alertItem = AlertItem(title: Text(getInsertProposalResponse.rmsg.first?.errorText ?? ""))
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
  
       }
    
}

struct ProposalForms_Previews: PreviewProvider {
    static var previews: some View {
        ProposalForms(navigateProposalForm: .constant(false))
    }
}
