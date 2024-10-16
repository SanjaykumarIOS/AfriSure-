

import SwiftUI
import MobileCoreServices
import UIKit


var assessmentTitle = ""
var objectActionRequirementID = ""

struct OnTabCompleteSelfAssessment: View {
    
    @Binding var onTabCompleteAssessment: Bool
    
    @State private var completeGetTaskDetailArray: [GetTaskDetailJSONModel.GetTaskDetailField] = []
    
    @State private var alertItem: AlertItem?
    @State private var isLoading = false
    
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some View {
        NavigationStack {
            LoadingView(isShowing: $isLoading) {
                VStack {
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            
                            ForEach(completeGetTaskDetailArray.indices, id: \.self) { index in
                                let value = completeGetTaskDetailArray[index]
                                
                                if let templateOption = value.templateOptions {
                                    
                                    if value.type == "view-upload-file" {
                                        
                                        Text(templateOption.label ?? "")
                                            .font(isFontMedium(size: 18))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading)
                                            .padding(.top,10)
                                        
                                        if let files = templateOption.files, !files.isEmpty {
                                            
                                            ZStack {
                                                Color.gray.opacity(0.2)
                                                
                                                ScrollView(.horizontal,showsIndicators:false) {
                                                    HStack {
                                                        ForEach(files, id: \.fileName) { file in
                                                            
                                                            ZStack(alignment:.center) {
                                                                Color.white
                                                                VStack {
                                                                    
                                                                    Text(file.fileName ?? "")
                                                                        .multilineTextAlignment(.center)
                                                                        .font(isFontMedium(size: 16))
                                                                        .padding(10)
                                                                        .onTapGesture {
                                                                            openFile(fileURLString: file.href ?? "")
                                                                        }
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

                                            
                                            
//                                            ForEach(files, id: \.fileName) { file in
////
//                                                Button(action: {
//                                                    openFile(fileURLString: file.href ?? "")
//
//                                                })
//                                                {
//                                                    Text(file.fileName ?? "")
//                                                        .font(isFontMedium(size: 18))
//                                                        .frame(maxWidth: .infinity, alignment: .leading)
//                                                        .padding(.leading,30)
//                                                        .padding(.top,10)
//                                                       
//                                                }
//                                                
////                                                Link(destination: URL(string: file.href ?? "")!) {
////                                                    Text(file.fileName ?? "")
////                                                        .font(isFontMedium(size: 18))
////                                                        .frame(maxWidth: .infinity, alignment: .leading)
////                                                        .padding(.leading, 30)
////                                                        .padding(.top, 10)
////                                                }
//
//                                            }
                                        }
                                    }
                                    
                                   

                                    if value.type == "input" {
                                        
                                        Text(templateOption.label ?? "")
                                            .font(isFontMedium(size: 18))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading)
                                            .padding(.top,10)
                                        
                                        if let defaultValue = value.defaultValue {
                                            switch defaultValue {
                                            case .string(let stringValue):
                                                TextField("", text:.constant(stringValue))
                                                    .disabled(value.templateOptions?.disabled ?? false)
                                                    .padding(10)
                                                    .frame(width: 350,height: 50)
                                                    .font(isFontMedium(size: 18))
                                                    .autocapitalization(.none)
                                                    .autocorrectionDisabled()
                                                    .background(Color.gray.opacity(0.2))
                                                    .foregroundColor(.black)
                                                    .cornerRadius(8)
                                                
                                            case .dictionary(let dictionaryValue):
                                                // Handle dictionary value if needed
                                                Text("Dictionary Value")
                                            case .other:
                                                // Handle other cases if needed
                                                Text("Other")
                                            }
                                        }

                                    }
                                }
                                
                            }
                            

                        }
                    }
                }
                .onAppear {
                    fetchCompletedGetTaskDetails()
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
                                    onTabCompleteAssessment = false
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
    
    func openFile(fileURLString: String) {
        if let url = URL(string: fileURLString) {
            UIApplication.shared.open(url)
        }
    }
    
    func fetchCompletedGetTaskDetails() {
        
        isLoading = true
        
        let parameters: [String: Any?] = [
            "objectActionRequirementID":  objectActionRequirementID
        ]
        
//        "68de6b58-8864-4592-9a4c-3d9ba02329ea"
        
        print(parameters)
        
        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(loginBaseURL)")!,
                                         path: "api/digital/core/ObjectTask/GetTaskDetails",
                                         method: "POST",bodyData:parameters as [String : Any])
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<GetTaskDetailResponseData, Error>) in
            switch result {
            case .success(let response):
                // Handle success
                DispatchQueue.main.async {
                    
                    if response.rcode == 200 {
                        print(response.rcode)
                        
                        if let visibilityData =  response.rObj.taskDetails.viewJson?.data(using: .utf8) {
                            do {
                                let visibilityModel = try JSONDecoder().decode(GetTaskDetailJSONModel.self, from: visibilityData)
                                
                                completeGetTaskDetailArray = visibilityModel.filed
                                print(visibilityModel.filed.first?.key ?? "")
                                
                                print("Success")
                                
                            } catch {
                                print("Error decoding visibility data: \(error)")
                                
                                if let errorDict = Extensions.getValidationDict() as? [String: String] {
                                    if let errorMessage = errorDict["ERR014"] {
                                        self.alertItem = AlertItem(title: Text("ERR014 \n \(errorMessage.localized())"))
                                    }
                                }
                            }
                        } else {
                            print("Error converting 'viewJson' to data")
                            if let errorDict = Extensions.getValidationDict() as? [String: String] {
                                if let errorMessage = errorDict["ERR014"] {
                                    self.alertItem = AlertItem(title: Text("ERR014 \n \(errorMessage.localized())"))
                                }
                            }
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
    OnTabCompleteSelfAssessment(onTabCompleteAssessment: .constant(false))
}
