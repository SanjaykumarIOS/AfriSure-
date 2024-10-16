

import SwiftUI
import Firebase

var selfAssessmentObjectID = ""

struct SelfAssessment: View {
    @Binding var navigateSelfAssessment: Bool
    
    @State private var onTabSelfAssessment = false
    @State private var onTabCompleteAssessment = false
    
    @State private var objectSelfTasksArray: [GetObjectSelfTasksResponse.GetObjectSelfTasksRObj.ObjectData] = []
    
    @State private var screenConfigArray: [ScreenConfig.FieldGroup] = []
    
    @State var selectedFileURL: URL?
    @State private var isShowingFilePicker = false
    @State private var isDocumentPickerPresented = false
    @State private var isMultipleDocumentPickerPresented = false
    @State private var selectedFileName: String? = nil
    @State private var selectedSingleFileName: [String] = []
    @State private var selectedMultipleFileName: [String] = []
    @State var proposalisMultiple = false
    @State var proposalFileslength = 0
    @State private var isSingleFileCircleLoading = false
    @State private var isFileUploadCircleLoading: [String: Bool] = [:]
    
    @State private var fileUploadArray: [FileUploadResponse.FileUploadRObj] = []
    
    @State private var alertItem: AlertItem?
    @State private var isLoading = false
    
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some View {
        NavigationStack {
            LoadingView(isShowing: $isLoading) {
                
                VStack {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
                            
                            ForEach(objectSelfTasksArray.indices, id: \.self) { index in
                                let task = objectSelfTasksArray[index]
                                
                                let backgroundColor: Color = (index > 0 && objectSelfTasksArray[index - 1].isCompleted == false && objectSelfTasksArray[index].isMandatory != false) ? .gray.opacity(0.2) : .white
                                
                                if let isMandatory = task.isMandatory {
                                    Text("\(task.requirement ?? "") \(isMandatory ? "*" : "")")
                                        .halfTextColorChange(fullText: "\(task.requirement ?? "") \(isMandatory ? "*" : "")", changeText: "*")
                                        .padding(5)
                                        .font(isFontMedium(size: 18))
                                        .multilineTextAlignment(.center)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 150)
                                        .background(backgroundColor)
                                        .cornerRadius(8)
                                        .shadow(radius: 2)
                                        .padding(5)
                                        .onTapGesture {
                                            assessmentTitle = task.requirement ?? ""
                                            
                                            objectActionRequirementID = task.objectActionRequirementID ?? ""
                                            
                                            if index > 0 && objectSelfTasksArray[index - 1].isCompleted == false && objectSelfTasksArray[index].isMandatory != false {
                                                
                                                self.alertItem = AlertItem(title: Text("Please complete \(objectSelfTasksArray[index - 1].requirement ?? "") to continue!"))
                                            } else {
                                                withAnimation {
                                                    onTabSelfAssessment = true
                                                }
                                            }

 
//                                            if task.isCompleted == true {
//                                                onTabCompleteAssessment = true
//                                                
//                                            } else {
//                                                
//                                                if index > 0 && objectSelfTasksArray[index - 1].isCompleted == false && objectSelfTasksArray[index].isMandatory != false {
//                                                    
//                                                    self.alertItem = AlertItem(title: Text("Please complete \(objectSelfTasksArray[index - 1].requirement ?? "") to continue!"))
//                                                } else {
//                                                    withAnimation {
//                                                        onTabSelfAssessment = true
//                                                    }
//                                                }
//                                            }
                                            
                                        }
                                        .overlay {
                                            if task.isCompleted == true {
                                                ZStack(alignment:.top) {
                                                    VStack {
                                                        Image(systemName: "checkmark.circle.fill")
                                                            .font(isFontMedium(size: 24))
                                                            .foregroundColor(.green)
                                                            .frame(maxWidth: .infinity, alignment:.trailing)
                                                            .padding(13)
                                                        
                                                        Spacer()
                                                    }
                                                }
                                            }
                                        }
                                }
                            }
                            
                            
                        }
                        .padding()
                    }
                    
                    VStack {
                        if objectSelfTasksArray.allSatisfy({ $0.isCompleted ?? false}) {
                            Button(action: {
                               
                            }) {
                                Text("NEXT >>")
                                    .padding(.top)
                                    .frame(maxWidth: .infinity)
                                    .background(toolbarcolor)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .font(isFontBold(size: 20))
                            }
                        }
                    }

                    
                }
                .onAppear {
                    fetchGetObjectSelfTasks()
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
                                
                                withAnimation {
                                    navigateSelfAssessment = false
                                }
                            })
                            {
                                
                                Image(systemName: "arrow.backward")
                                    .bold()
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .padding(.bottom)
                                
                            }
                            
                            Text("Self Assessment")
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
        }
        
        .overlay {
            !networkMonitor.isConnected ? ErrorView() : nil
            
            onTabCompleteAssessment ? OnTabCompleteSelfAssessment(onTabCompleteAssessment: $onTabCompleteAssessment) : nil
            
        }
        
        .overlay {
            if onTabSelfAssessment {
                VStack {
                    NavigationStack {
                        LoadingView(isShowing: $isLoading) {
                            
                            VStack {
                                
                                ScrollView(showsIndicators: false) {
                                    VStack {
                                        
                                        ForEach(Array(screenConfigArray.enumerated()), id: \.element.key) { index, field in
                                            
                                            if let templateOptions = field.templateOptions {
                                                
                                                if field.type == "input", let allowedFileTypes = templateOptions.allowedFileTypes, !allowedFileTypes.isEmpty {
                                                    
                                                    if let isMultiple = templateOptions.IsMultiple, !isMultiple {
                                                        
                                                        HStack {
                                                            
                                                            Text("\(templateOptions.label ?? "") \(templateOptions.required ? "*" : "")")
                                                                .halfTextColorChange(fullText: "\(templateOptions.label ?? "") \(templateOptions.required ? "*" : "")", changeText: "*")
                                                                .font(isFontMedium(size: 18))
                                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                                .padding(.leading)
                                                                .padding(.top,10)
                                                            
                                                            Button(action:{
                                                                
                                                                if let isMultiple = templateOptions.IsMultiple {
                                                                    proposalisMultiple = isMultiple
                                                                }
                                                                
                                                                let fileslength = templateOptions.fileslength ?? 0
                                                                proposalFileslength = fileslength
                                                                fileUploadlength = fileslength
                                                                
                                                                
                                                                print(field.key ?? "")
                                                                
                                                                //                                                        selectedProposalFormField = field.key ?? ""
                                                                
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
                                                                filelength: templateOptions.fileslength ?? 0,
                                                                isMultiple: templateOptions.IsMultiple ?? false,
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
                                                                                                fileUploadArray.remove(at: index)
                                                                                                
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
                                                    
                                                    
                                                    
                                                    if let isMultiple = templateOptions.IsMultiple, isMultiple {
                                                        
                                                        HStack {
                                                            
                                                            Text("\(templateOptions.label ?? "") \(templateOptions.required ? "*" : "")")
                                                                .halfTextColorChange(fullText: "\(templateOptions.label ?? "") \(templateOptions.required ? "*" : "")", changeText: "*")
                                                                .font(isFontMedium(size: 18))
                                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                                .padding(.leading)
                                                                .padding(.top,10)
                                                            
                                                            Button(action:{
                                                                
                                                                
                                                                if let isMultiple = templateOptions.IsMultiple {
                                                                    proposalisMultiple = isMultiple
                                                                }
                                                                
                                                                let fileslength = templateOptions.fileslength ?? 0
                                                                proposalFileslength = fileslength
                                                                fileUploadlength = fileslength
                                                                
                                                                
                                                                print(proposalFileslength)
                                                                
                                                                //                                                            selectedProposalFormField = field.key ?? ""
                                                                
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
                                                                filelength: fileUploadlength - selectedMultipleFileName.count,
                                                                isMultiple: templateOptions.IsMultiple ?? false,
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
                                                                                                
                                                                                                fileUploadArray.remove(at: index)
                                                                                                
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
                                                    
                                                    if templateOptions.label != "Api Url" {
                                                        Text("\(templateOptions.label ?? "") \(templateOptions.required ? "*" : "")")
                                                            .halfTextColorChange(fullText: "\(templateOptions.label ?? "") \(templateOptions.required ? "*" : "")", changeText: "*")
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
                                                                //                                                proposalFormDefaultValues.append(newValue)
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
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                }
                                
                                VStack {
                                    
                                    Button(action: {
                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                            
                                        onTabSelfAssessmentValidation()
                                        
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
                                fetchGetTask()
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
                                            
                                            withAnimation {
                                                onTabSelfAssessment = false
                                                selectedMultipleFileName = []
                                                selectedSingleFileName = []
                                                fileUploadArray = []
                                            }
                                        })
                                        {
                                            Image(systemName: "arrow.backward")
                                                .bold()
                                                .font(.system(size: 20))
                                                .foregroundColor(.white)
                                                .padding(.bottom)
                                        }
                                        
                                        Text(assessmentTitle)
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
                    }
                }
            }
        }

    }
    
    
    func onTabSelfAssessmentValidation() {
        
        for value in screenConfigArray {
            if let templateOptions = value.templateOptions {
                let answer = value.defaultValue?.trimmingCharacters(in: .whitespacesAndNewlines)
                if templateOptions.required && (answer?.isEmpty ?? true) && ((templateOptions.label?.isEmpty) != nil) && ((value.type?.isEmpty) != nil) {
                    if let validation = value.validation {
                        self.alertItem = AlertItem(title: Text("ERR018 \n \(validation.messages?.required ?? "")"))
                        return
                    }
                    
                }
                
                if let minLengthMessage = value.validation?.messages?.minLength {
                    if answer?.count ?? 0 <= templateOptions.minLength ?? 0 {
                        self.alertItem = AlertItem(title: Text("ERR018 \n \(minLengthMessage)"))
                        return
                    }
                }
                
                if let maxLengthMessage = value.validation?.messages?.maxLength {
                    if answer?.count ?? 0 >= templateOptions.maxLength ?? 0 {
                        self.alertItem = AlertItem(title: Text("ERR018 \n \(maxLengthMessage)"))
                        return
                    }
                }
            }
        }
        
        for data in screenConfigArray {
            if let templateOptions = data.templateOptions, templateOptions.label == "Api Url" {
                fetchSubmitTask(apiUrl: data.apiUrl ?? "")
            }
        }
    }
            
   
    func fetchGetObjectSelfTasks() {
        
        isLoading = true
      
        let parameters: [String: Any?] = [
           
            "objectID": selfAssessmentObjectID
            
//            "990fbae0-3301-43d7-9509-bc74975d4837"

        ]
        
        print(parameters)
        
        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(loginBaseURL)")!,
                                         path: "api/digital/core/ObjectTask/GetObjectSelfTasks",
                                         method: "POST",bodyData:parameters as [String : Any])
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<GetObjectSelfTasksResponse, Error>) in
            switch result {
            case .success(let response):
                // Handle success
                DispatchQueue.main.async {
                    
                    if response.rcode == 200 {
                        print(response.rcode)
                        
                        objectSelfTasksArray = response.rObj?.getObjectSelfTasks ?? []
                                               
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
    
    
    func fetchGetTask() {
        
        isLoading = true
        
        let parameters: [String: Any?] = [
            "objectActionRequirementID": objectActionRequirementID
        ]
        
        print(parameters)
        
        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(loginBaseURL)")!,
                                         path: "api/digital/core/ObjectTask/GetTask",
                                         method: "POST",bodyData:parameters as [String : Any])
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<TaskResponse, Error>) in
            switch result {
            case .success(let response):
                // Handle success
                DispatchQueue.main.async {
                    
                    if response.rcode == 200 {
                        print(response.rcode)
                        
                        objectActionRequirementID = response.rObj.taskData.objectActionRequirementID ?? ""
                        
                        if let visibilityData =  response.rObj.screenConfig?.data(using: .utf8) {
                            do {
                                let visibilityModel = try JSONDecoder().decode(ScreenConfig.self, from: visibilityData)

                                print("Success")
                                
                                screenConfigArray = visibilityModel.fieldGroup
                            
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
                    let fileUploadResponse = try JSONDecoder().decode(FileUploadResponse.self, from: data)
                    fileUploadArray.append(fileUploadResponse.rObj)
                    
                    print("File Array : \(fileUploadArray)")
                } catch {
                    // Handle decoding error
                    print("Error decoding JSON: \(error)")
                    
                    if let errorDict = Extensions.getValidationDict() as? [String: String] {
                        if let errorMessage = errorDict["ERR014"] {
                            self.alertItem = AlertItem(title: Text("ERR014 \n \(errorMessage.localized())"))
                        }
                    }
                }
                
                
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let rcode = json["rcode"] as? Int {
                        
                        if rcode == 200 {
                            print("Response Code: \(rcode)")
                            
                            if let rObj = json["rObj"] as? [String: Any],
                               let attachmentID = rObj["attachmentID"] as? String {
                                
                                // You can use the attachmentID here
                                print("Attachment ID: \(attachmentID)")
                            }
                            
                        } else {
                            if let errorDict = Extensions.getValidationDict() as? [String: String],
                               let errorMessage = errorDict["API001"] {
                                self.alertItem = AlertItem(title: Text("API001 \n \(errorMessage.localized())"))
                            }
                        }
                    }

                    else {
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
    
    
    func fetchSubmitTask(apiUrl: String) {
        
        isLoading = true
        
        var parameters: [String: Any] = [:]
        
        var information: [String: Any] = [:]

        for values in screenConfigArray {
            if let label = values.templateOptions?.label, label != "Api Url" {
                if values.templateOptions?.allowedFileTypes == nil {
                    information[values.key ?? ""] = values.defaultValue ?? NSNull()
                }
            }
        }

     
        for values in screenConfigArray {
            if let key = values.key,
               let label = values.templateOptions?.label,
               label != "Api Url",
               let allowedFileTypes = values.templateOptions?.allowedFileTypes,
               !allowedFileTypes.isEmpty {
                
                guard let isMultiple = values.templateOptions?.IsMultiple,
                      fileUploadArray.count == (isMultiple ? selectedMultipleFileName.count : selectedSingleFileName.count) else {
                    return
                }
                
                var attachments: [[String: Any]] = []
                
                for (file, fileName) in zip(fileUploadArray, values.templateOptions?.IsMultiple ?? false ? selectedMultipleFileName : selectedSingleFileName) {
                    let attachment: [String: Any] = [
                        "attachmentID": [
                            "attachmentID": file.attachmentID,
                            "fileName": fileName,
                            "blopUploadLocation": values.templateOptions?.blopUploadLocation,
                            "uploadedURL": file.SASURL
                        ]
                    ]
                    
                    attachments.append(attachment)
                    
                }
                
                information[key] = attachments.isEmpty ? NSNull() : attachments
                
            }
        }


        parameters["information"] = information
        parameters["viewJson"] = "{}"
        parameters["assessorTypeID"] = 10
        parameters["objectActionRequirementID"] = objectActionRequirementID

        print(parameters)
        
        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(loginBaseURL)")!,
                                         path: apiUrl,
                                         method: "POST",bodyData:parameters as [String : Any])
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<SelfAssessmentSubmitResponseModel, Error>) in
            switch result {
            case .success(let response):
                // Handle success
                DispatchQueue.main.async {
                    
                    if response.rcode == 200 {
                        print(response.rcode)
                        fetchGetObjectSelfTasks()

                        withAnimation {
                            onTabSelfAssessment = false
                            selectedMultipleFileName = []
                            selectedSingleFileName = []
                            fileUploadArray = []
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
    
}

#Preview {
    SelfAssessment(navigateSelfAssessment: .constant(false))
}


