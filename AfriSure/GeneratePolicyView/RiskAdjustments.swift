//


import SwiftUI

struct RiskAdjustments: View {
    
    @Binding var navigateRiskAdjustmentsPage: Bool
    
    @State private var selectedRiskAdjustment: RiskAdjustmentResponse.RiskAdjustmentObject.RiskAdjustmentvalue?
    @State var riskAdjustmentDetailArray: [RiskAdjustmentResponse.RiskAdjustmentObject.RiskAdjustmentvalue] = []
    
    @State var RiskAssessmentsDetailArray: [RiskAssessmentsResponse.RiskAssessmentsObject.RiskAssessmentsObjectRequirement] = []
    
    @State var RiskAdjustmentLimitDetailArray: [RiskAdjustmentLimitResponse.ResponseObjectRiskAdjustmentLimit.RiskAdjustmentLimit] = []
    
    @State private var showAddRiskAdjustmentPopup = false
    @State private var adjustmentTypeText = ""
    @State private var assessmentsText = ""
    @State private var riskCategoryText = ""
    @State private var amountText = ""
    @State private var commentsText = ""
    @State private var maxAmountAllowed = 0
    
    @State private var adjustmentTypeList = ["Risk" , "Discount"]
    @State private var showAdjustmentTypeList = false
    
    @State private var showRiskAssessmentsList = false
    
    @State private var showRiskCategoryList = false
    
    @State private var assessmentID: String? = nil
    @State private var adjustmentTypeID = ""
    @State private var riskCategoryID = ""
    @State private var riskAdjustmentLimitID = 0
    
    @State private var showDeletePopup = false
    @State private var riskAdjustmentId = ""
    
    @State var navigateGeneratePolicyPage = false
    
    @State private var alertItem: AlertItem?
    @State private var isLoading = false
    
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some View {
        NavigationStack {
            LoadingView(isShowing: $isLoading) {
                VStack {
                    
                    Button(action: {
                        showAddRiskAdjustmentPopup = true
                    })
                    {
                        
                        Image(systemName: "plus")
                            .font(isFontMedium(size: 25))
                            .foregroundColor(.white)
                            .frame(width: 45,height: 45)
                            .background(toolbarcolor)
                            .cornerRadius(10)
                            .frame(maxWidth:.infinity, alignment:.trailing)
                            .padding(15)
                    }
                    
                    ScrollView {
                        VStack {
                            if riskAdjustmentDetailArray.isEmpty {
                                Text("It seems you haven't added any yet. Take the first step and add a risk adjustment.")
                                    .font(isFontMedium(size: 18))
                                    .padding()
                            } else {
                                
                                VStack {
                                    Spacer()
                                    VStack {
                                        
                                        ForEach(riskAdjustmentDetailArray, id: \.policyID) { value in
                                            Image(systemName: "trash")
                                                .font(isFontMedium(size: 24))
                                                .foregroundColor(.red)
                                                .frame(maxWidth: .infinity, alignment:.trailing)
                                                .padding(.trailing)
                                                .padding(.top,10)
                                                .onTapGesture {
                                                    showDeletePopup = true
                                                    riskAdjustmentId = value.riskAdjustmentID
                                                    selectedRiskAdjustment = value
                                                }
                                            
                                            
                                            VStack(alignment:.leading,spacing:10) {
                                                HStack(alignment:.top) {
                                                    
                                                    VStack {
                                                        Text("Adjustment Type")
                                                            .font(isFontMedium(size: 19))
                                                            .foregroundColor(fontOrangeColour)
                                                            .frame(maxWidth:.infinity, alignment:.leading)
                                                    }
                                                    .frame(width:150)
                                                    
                                                    VStack {
                                                        if value.adjustmentTypeID == 1 {
                                                            Text(": Risk")
                                                                .font(isFontMedium(size: 19))
                                                                .foregroundColor(.black)
                                                        } else {
                                                            Text(": Discount")
                                                                .font(isFontMedium(size: 19))
                                                                .foregroundColor(.black)
                                                        }
                                                    }
                                                    .frame(maxWidth:.infinity, alignment:.leading)
                                                }
                                                .fixedSize(horizontal: false, vertical: true)
                                                
                                                
                                                HStack(alignment:.top) {
                                                    
                                                    VStack {
                                                        Text("Risk Category")
                                                            .font(isFontMedium(size: 19))
                                                            .foregroundColor(fontOrangeColour)
                                                            .frame(maxWidth:.infinity, alignment:.leading)
                                                        
                                                    }
                                                    .frame(width:150)
                                                    
                                                    VStack {

                                                        if let assessmentTitle = value.assessmentTitle {
                                                            Text(": \(value.riskCategoryTitle) \("(\(assessmentTitle))")")
                                                                .font(isFontMedium(size: 19))
                                                                .foregroundColor(.black)
                                                                .fixedSize(horizontal: false, vertical: true)
                                                        } else {
                                                            Text(": \(value.riskCategoryTitle)")
                                                                .font(isFontMedium(size: 19))
                                                                .foregroundColor(.black)
                                                                .fixedSize(horizontal: false, vertical: true)
                                                        }

                                                    }
                                                    .frame(maxWidth:.infinity, alignment:.leading)
                                                    
                                                }
                                                .fixedSize(horizontal: false, vertical: true)
                                                
                                                
                                                HStack(alignment:.top) {
                                                    VStack {
                                                        Text("Adjustment Amount")
                                                            .font(isFontMedium(size: 19))
                                                            .foregroundColor(fontOrangeColour)
                                                            .frame(maxWidth:.infinity, alignment:.leading)
                                                        
                                                    }
                                                    .frame(width:150)
                                                    
                                                    VStack {
                                                        Text(": \(value.sAdjustmentAmount)")
                                                            .font(isFontMedium(size: 19))
                                                            .foregroundColor(.black)
                                                            .fixedSize(horizontal: false, vertical: true)
                                                    }
                                                    .frame(maxWidth:.infinity, alignment:.leading)
                                                }
                                                .fixedSize(horizontal: false, vertical: true)
                                                
                                            }
                                            .padding(.bottom,10)
                                            .padding(.leading,10)
                                            
                                        }
                                        
                                    }
                                    .frame(width:350)
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .shadow(radius: 3)
                                    .padding(5)
                                    
                                    
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                
                .onAppear {
                    fetchRiskAdjustment()
                    fetchAssessment()
                    fetchProductRiskAdjustmentLimit()
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
                                    navigateRiskAdjustmentsPage = false
                                }
                            })
                            {
                                
                                Image(systemName: "arrow.backward")
                                    .bold()
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .padding(.bottom)
                                
                            }
                           
                            Text("Risk Adjustments")
                                .bold()
                                .font(isFontBlack(size: 22))
                                .foregroundColor(.white)
                                .padding(.bottom,8)
                            
                            NavigationLink("", destination: GeneratePolicy(isOverlayVisible: .constant(false)), isActive: $navigateGeneratePolicyPage)
                            
                                .alert(isPresented: $showDeletePopup) {
                                    Alert(
                                        title: Text("Are you sure you want to delete this risk/adjustment entry?"),
                                        primaryButton: .default(Text("Yes")) {
                                            
                                            deleteItem(selectedRiskAdjustment!)
                                            showDeletePopup = false
                                        },
                                        secondaryButton: .cancel(Text("No")) {
                                            showDeletePopup = false
                                        }
                                        
                                    )
                                }
                            
                        }
                    }
                }
                .toolbarBackground(toolbarcolor,for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
            }
        }.navigationBarBackButtonHidden()
        
            .overlay (
                !networkMonitor.isConnected ? ErrorView() : nil
            )
        
            .overlay {
                if showAddRiskAdjustmentPopup {
                    ZStack {
                        Color.black.opacity(0.3)
                            .ignoresSafeArea(.all)
                            .onTapGesture {
                                showAddRiskAdjustmentPopup = false
                                
                                adjustmentTypeText = ""
                                assessmentsText = ""
                                riskCategoryText = ""
                                amountText = ""
                                commentsText = ""
                                
                                showAdjustmentTypeList = false
                                showRiskCategoryList = false
                                showRiskAssessmentsList = false
                            }
                        
                        VStack {
                            HStack {
                                
                                Button(action: {
                                    showAddRiskAdjustmentPopup = false
                                    
                                    adjustmentTypeText = ""
                                    assessmentsText = ""
                                    riskCategoryText = ""
                                    amountText = ""
                                    commentsText = ""
                                    
                                    showAdjustmentTypeList = false
                                    showRiskCategoryList = false
                                    showRiskAssessmentsList = false
                                })
                                {
                                    
                                    Image(systemName: "arrow.backward")
                                        .bold()
                                        .font(.system(size: 20))
                                        .foregroundColor(fontOrangeColour)
                                }
                                
                                Text("Risk Adjustments")
                                    .font(isFontMedium(size: 20))
                                    .foregroundColor(fontOrangeColour)
                                    .padding(.leading,10)
                                Spacer()
                                
                            }
                            .padding(15)
                            
                            ScrollView {
                                VStack {
                                    
                                    Text("Adjustment Type *")
                                        .font(isFontMedium(size: 18))
                                        .frame(maxWidth: .infinity, alignment:.leading)
                                        .padding(.leading)
                                    
                                    VStack {
                                        TextField("Select", text: $adjustmentTypeText)
                                            .disabled(true)
                                            .padding()
                                            .padding(.leading,10)
                                            .padding(.trailing,40)
                                            .foregroundColor(.black)
                                            .font(isFontMedium(size: 18))
                                            .background(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color.black, lineWidth: 1)
                                                    .frame(width: 310)
                                            )
                                        
                                            .overlay{
                                                
                                                Image(systemName: "chevron.down")
                                                    .bold()
                                                    .font(.system(size: 22))
                                                    .frame(maxWidth: .infinity, alignment:.trailing)
                                                    .padding(.trailing,20)
                                                
                                            }
                                            .padding(.horizontal)
                                    }
                                    .onTapGesture {
                                        showAdjustmentTypeList.toggle()
                                    }
                                    
                                    if !RiskAssessmentsDetailArray.isEmpty {
                                        Text("Assessments")
                                            .font(isFontMedium(size: 18))
                                            .frame(maxWidth: .infinity, alignment:.leading)
                                            .padding(.leading)
                                            .padding(.top)
                                        
                                        VStack {
                                            TextField("Select", text: $assessmentsText,axis: .vertical)
                                                .disabled(true)
                                                .padding()
                                                .padding(.leading,10)
                                                .padding(.trailing)
                                                .foregroundColor(.black)
                                                .font(isFontMedium(size: 18))
                                                .background(
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .stroke(Color.black, lineWidth: 1)
                                                        .frame(width: 310)
                                                )
                                            
                                                .overlay{
                                                    
                                                    Image(systemName: "chevron.down")
                                                        .bold()
                                                        .font(.system(size: 22))
                                                        .frame(maxWidth: .infinity, alignment:.trailing)
                                                        .padding(.trailing,20)
                                                    
                                                }
                                                .padding(.horizontal)
                                        }
                                        .onTapGesture {
                                            showRiskAssessmentsList.toggle()
                                        }
                                    }
                                    
                                    if !adjustmentTypeText.isEmpty {
                                        Text("Risk Category *")
                                            .font(isFontMedium(size: 18))
                                            .frame(maxWidth: .infinity, alignment:.leading)
                                            .padding(.leading)
                                            .padding(.top)
                                        
                                        VStack {
                                            TextField("Select", text: $riskCategoryText)
                                                .disabled(true)
                                                .padding()
                                                .padding(.leading,10)
                                                .padding(.trailing,40)
                                                .foregroundColor(.black)
                                                .font(isFontMedium(size: 18))
                                                .background(
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .stroke(Color.black, lineWidth: 1)
                                                        .frame(width: 310)
                                                )
                                            
                                                .overlay{
                                                    
                                                    Image(systemName: "chevron.down")
                                                        .bold()
                                                        .font(.system(size: 22))
                                                        .frame(maxWidth: .infinity, alignment:.trailing)
                                                        .padding(.trailing,20)
                                                    
                                                }
                                                .padding(.horizontal)
                                        }
                                        .onTapGesture {
                                            showRiskCategoryList.toggle()
                                        }
                                    }
                                    
                                    if !riskCategoryText.isEmpty {
                                        Text("Amount *")
                                            .font(isFontMedium(size: 18))
                                            .frame(maxWidth: .infinity, alignment:.leading)
                                            .padding(.leading)
                                            .padding(.top)
                                        
                                        VStack {
                                            TextField("Amount", text: $amountText)
                                                .padding()
                                                .padding(.leading)
                                                .padding(.trailing)
                                                .foregroundColor(.black)
                                                .font(isFontMedium(size: 18))
                                                .background(
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .stroke(Color.black, lineWidth: 1)
                                                        .frame(width: 310)
                                                )
                                            
                                        }
                                    }
                                    
                                    Text("Comments *")
                                        .font(isFontMedium(size: 18))
                                        .frame(maxWidth: .infinity, alignment:.leading)
                                        .padding(.leading)
                                        .padding(.top)
                                    
                                    VStack {
                                        TextField("Comments", text: $commentsText,axis: .vertical)
                                            .padding()
                                            .padding(.leading)
                                            .padding(.trailing)
                                            .foregroundColor(.black)
                                            .font(isFontMedium(size: 18))
                                            .background(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color.black, lineWidth: 1)
                                                    .frame(width: 310)
                                            )
                                        
                                    }
                                    
                                    Button(action: {
                                        
                                        riskAdjustmentValidations()
                                    })
                                    {
                                        Text("Submit")
                                            .bold()
                                            .font(isFontMedium(size: 18))
                                            .foregroundColor(.white)
                                            .frame(width:150, height: 50)
                                            .background(fontOrangeColour)
                                            .cornerRadius(10)
                                            .padding()
                                    }
                                }
                                .frame(width: 350)
                            }
//                            .fixedSize(horizontal: false, vertical: true)
                            .frame(minHeight: 0, maxHeight: 400)
                        }
                        .frame(width: 350)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                    }
                }
            }
        
            .overlay {
                if showAdjustmentTypeList {
                    ZStack {
                        Color.clear
                            .ignoresSafeArea()
                            .onTapGesture {
                                showAdjustmentTypeList = false
                            }
                        VStack {
                            Spacer()
                            VStack {
                                ForEach(adjustmentTypeList, id: \.self) { value in
                                    
                                    Button(action:{
                                        showAdjustmentTypeList = false
                                        adjustmentTypeText = value
                                        
                                        if adjustmentTypeText == "Risk" {
                                            adjustmentTypeID = "1"
                                        } else {
                                            adjustmentTypeID = "2"
                                        }
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
                
                
                
                if showRiskCategoryList {
                    
                    Color.black.opacity(0.1)
                        .ignoresSafeArea()
                        .onTapGesture {
                            
                            showRiskCategoryList = false
                        }
                    ZStack {
                        
                        VStack {
                            Spacer()
                            VStack {
                                
                                ForEach(RiskAdjustmentLimitDetailArray, id: \.riskAdjustmentLimitId) { value in
                                    
                                    if adjustmentTypeText == "Discount" && value.isDiscountAllowed == true {
                                        Button(action:{
                                            showRiskCategoryList = false
                                            riskCategoryText = value.riskCategoryTitle
                                            riskCategoryID = value.riskCategoryID
                                            riskAdjustmentLimitID = value.riskAdjustmentLimitId
                                            maxAmountAllowed = value.maxDiscountAllowed
                                        })
                                        {
                                            Text(value.riskCategoryTitle)
                                                .font(isFontMedium(size: 18))
                                                .padding(10)
                                                .foregroundColor(.black)
                                                .frame(maxWidth:.infinity,alignment:.leading)
                                        }
                                    } else if adjustmentTypeText == "Risk" {
                                        
                                        Button(action:{
                                            showRiskCategoryList = false
                                            riskCategoryText = value.riskCategoryTitle
                                            riskCategoryID = value.riskCategoryID
                                            riskAdjustmentLimitID = value.riskAdjustmentLimitId
                                            maxAmountAllowed = value.maxLoadingAllowed
                                        })
                                        {
                                            Text(value.riskCategoryTitle)
                                                .font(isFontMedium(size: 18))
                                                .padding(10)
                                                .foregroundColor(.black)
                                                .frame(maxWidth:.infinity,alignment:.leading)
                                        }
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
                
                
                if showRiskAssessmentsList {
                    
                    Color.black.opacity(0.1)
                        .ignoresSafeArea()
                        .onTapGesture {
                            
                            showRiskAssessmentsList = false
                        }
                    ZStack {
                       
                        VStack {
                          
                            VStack {
                                Spacer()
                                List {
                                    ForEach(Array(Set(RiskAssessmentsDetailArray.map { $0.requirement })), id: \.self) { uniqueRequirement in
                                        if let value = RiskAssessmentsDetailArray.first(where: { $0.requirement == uniqueRequirement }) {
                                            Button(action: {
                                                showRiskAssessmentsList = false
                                                assessmentsText = value.requirement
                                                assessmentID = value.objectActionRequirementID
                                            }) {
                                                
                                                VStack(spacing:10) {
                                                    Text(value.requirement)
                                                        .font(isFontMedium(size: 18))
                                                        .padding(10)
                                                        .foregroundColor(.black)
                                                }
                                                
                                            }
                                        }
                                    }
                                    .listRowSeparator(.hidden)
                                }
                                .listStyle(.plain)
                                .frame(width:300)
                                .background(Color.white)
                                .cornerRadius(0)
                                .shadow(radius: 3)
                                
                                Spacer()
                            }
                            .frame(height:400)
                        }
                    }
                }
                
            }
    }
    
    
//    func riskAdjustmentValidations() {
//        if adjustmentTypeText.trimmingCharacters(in: .whitespacesAndNewlines).description.isEmpty {
//            self.alertItem = AlertItem(title: Text("Please select adjustment type to continue!"))
//            return
//        } else if !adjustmentTypeText.isEmpty && riskCategoryText.trimmingCharacters(in: .whitespacesAndNewlines).description.isEmpty {
//            self.alertItem = AlertItem(title: Text("Please select risk category to continue!"))
//            return
//        } else if !riskCategoryText.isEmpty && amountText.trimmingCharacters(in: .whitespacesAndNewlines).description.isEmpty {
//            self.alertItem = AlertItem(title: Text("Please enter amount to continue!"))
//            return
//        } else  if adjustmentTypeText == "Risk" && maxAmountAllowed < Int(amountText) ?? 0 {
//            self.alertItem = AlertItem(title: Text("Amount exceeds the maximum limit of \(maxAmountAllowed)."))
//            return
//        } else if adjustmentTypeText == "Discount" && maxAmountAllowed < Int(amountText) ?? 0 {
//            self.alertItem = AlertItem(title: Text("Amount exceeds the maximum limit of \(maxAmountAllowed)."))
//            return
//        } else if commentsText.trimmingCharacters(in: .whitespacesAndNewlines).description.isEmpty {
//            self.alertItem = AlertItem(title: Text("Please enter comments to continue!"))
//            return
//        } else {
//            
//            fetchInsertRiskAdjustment()
//            showAddRiskAdjustmentPopup = false
//            
//            adjustmentTypeText = ""
//            assessmentsText = ""
//            riskCategoryText = ""
//            amountText = ""
//            commentsText = ""
//            
//            showAdjustmentTypeList = false
//            showRiskCategoryList = false
//            showRiskAssessmentsList = false
//        }
//    }
    
    
    func riskAdjustmentValidations() {
            if adjustmentTypeText.trimmingCharacters(in: .whitespacesAndNewlines).description.isEmpty {
    //            self.alertItem = AlertItem(title: Text("Please select adjustment type to continue!"))
                if let errorDict = Extensions.getValidationDict() as? [String: String] {
                    if let errorMessage = errorDict["ERR008"] {
                        self.alertItem = AlertItem(title: Text("ERR008" + "\n" + errorMessage))
                    }
                }
                return
            } else if !adjustmentTypeText.isEmpty && riskCategoryText.trimmingCharacters(in: .whitespacesAndNewlines).description.isEmpty {
    //            self.alertItem = AlertItem(title: Text("Please select risk category to continue!"))
                if let errorDict = Extensions.getValidationDict() as? [String: String] {
                    if let errorMessage = errorDict["ERR009"] {
                        self.alertItem = AlertItem(title: Text("ERR009" + "\n" + errorMessage))
                    }
                }
                return
            } else if !riskCategoryText.isEmpty && amountText.trimmingCharacters(in: .whitespacesAndNewlines).description.isEmpty {
    //            self.alertItem = AlertItem(title: Text("Please enter amount to continue!"))
                if let errorDict = Extensions.getValidationDict() as? [String: String] {
                    if let errorMessage = errorDict["ERR010"] {
                        self.alertItem = AlertItem(title: Text("ERR010" + "\n" + errorMessage))
                    }
                }
                return
            } else  if adjustmentTypeText == "Risk" && maxAmountAllowed < Int(amountText) ?? 0 {
    //            self.alertItem = AlertItem(title: Text("Amount exceeds the maximum limit of \(maxAmountAllowed)."))
                if let errorDict = Extensions.getValidationDict() as? [String: String] {
                    if let errorMessage = errorDict["ERR012"] {
                        self.alertItem = AlertItem(title: Text("ERR012\n \(errorMessage) \(maxAmountAllowed)"))
                    }
                }
                return
            } else if adjustmentTypeText == "Discount" && maxAmountAllowed < Int(amountText) ?? 0 {
    //            self.alertItem = AlertItem(title: Text("Amount exceeds the maximum limit of \(maxAmountAllowed)."))
                if let errorDict = Extensions.getValidationDict() as? [String: String] {
                    if let errorMessage = errorDict["ERR012"] {
                        self.alertItem = AlertItem(title: Text("ERR012\n \(errorMessage) \(maxAmountAllowed)"))
                    }
                }
                return
            } else if commentsText.trimmingCharacters(in: .whitespacesAndNewlines).description.isEmpty {
    //            self.alertItem = AlertItem(title: Text("Please enter comments to continue!"))
                if let errorDict = Extensions.getValidationDict() as? [String: String] {
                    if let errorMessage = errorDict["ERR013"] {
                        self.alertItem = AlertItem(title: Text("ERR013" + "\n" + errorMessage))
                    }
                }
                return
            } else {
                
                fetchInsertRiskAdjustment()
                showAddRiskAdjustmentPopup = false
                
                adjustmentTypeText = ""
                assessmentsText = ""
                riskCategoryText = ""
                amountText = ""
                commentsText = ""
                
                showAdjustmentTypeList = false
                showRiskCategoryList = false
                showRiskAssessmentsList = false
            }
        }
    
    func fetchRiskAdjustment() {
        
        isLoading = true
        
        let parameters: [String: Any] = [
            "policyID":Extensions.policyID
            ]

        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(BaseURL)")!,
                                         path: "api/digital/core/Policy/FetchAllPolicyRiskAdjustment",
                                         method: "POST",bodyData:parameters)
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<RiskAdjustmentResponse, Error>) in
           
            switch result {
            case .success(let Response):
                // Handle success
                DispatchQueue.main.async {
                    
                    if Response.rcode == 200 {
                        print(Response.rcode)
                        
                        riskAdjustmentDetailArray = Response.rObj.fetchAllPolicyRiskAdjustment
                        
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
//        let url = URL(string: "\(BaseURL)api/digital/core/Policy/FetchAllPolicyRiskAdjustment")!
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
//            "policyID":Extensions.policyID
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
//                print("Risk Adjustment Response = \(String(describing: resultDictionary))")
//                
//                let decoder = JSONDecoder()
//                let Response = try decoder.decode(RiskAdjustmentResponse.self, from: data)
//                
//                DispatchQueue.main.async {
//                    
//                    if Response.rcode == 200 {
//                        print(Response.rcode)
//                        
//                        riskAdjustmentDetailArray = Response.rObj.fetchAllPolicyRiskAdjustment
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
    
    func fetchAssessment() {
        
        isLoading = true
        
        let parameters: [String: Any] = [
            "objectID":Extensions.policyID
            ]
        
        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(BaseURL)")!,
                                         path: "api/digital/core/CNF/GetObjectActionRequirement",
                                         method: "POST",bodyData:parameters)
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<RiskAssessmentsResponse, Error>) in
           
            switch result {
            case .success(let Response):
                // Handle success
                DispatchQueue.main.async {
                    
                    if Response.rcode == 200 {
                        print(Response.rcode)
                        
                        RiskAssessmentsDetailArray = Response.rObj.objectRequirement
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
//        let url = URL(string: "\(BaseURL)api/digital/core/CNF/GetObjectActionRequirement")!
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
//            "objectID":Extensions.policyID
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
//                print("Risk Assessments Response = \(String(describing: resultDictionary))")
//                
//                let decoder = JSONDecoder()
//                let Response = try decoder.decode(RiskAssessmentsResponse.self, from: data)
//                
//                DispatchQueue.main.async {
//                    
//                    if Response.rcode == 200 {
//                        print(Response.rcode)
//                        
//                        RiskAssessmentsDetailArray = Response.rObj.objectRequirement
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
    
    
    func fetchProductRiskAdjustmentLimit() {
        
        isLoading = true
        
        let parameters: [String: Any] = [
            "policyID":Extensions.policyID
            ]
        
        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(BaseURL)")!,
                                         path: "api/digital/core/Policy/FetchProductRiskAdjustmentLimit",
                                         method: "POST",bodyData:parameters)
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<RiskAdjustmentLimitResponse, Error>) in
           
            switch result {
            case .success(let Response):
                // Handle success
                DispatchQueue.main.async {
                    
                    if Response.rcode == 200 {
                        print(Response.rcode)
                        
                        RiskAdjustmentLimitDetailArray = Response.rObj.fetchProductRiskAdjustmentLimit
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
//        let url = URL(string: "\(BaseURL)api/digital/core/Policy/FetchProductRiskAdjustmentLimit")!
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
//            "policyID":Extensions.policyID
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
//                print("Risk Category Response = \(String(describing: resultDictionary))")
//                
//                let decoder = JSONDecoder()
//                let Response = try decoder.decode(RiskAdjustmentLimitResponse.self, from: data)
//                
//                DispatchQueue.main.async {
//                    
//                    if Response.rcode == 200 {
//                        print(Response.rcode)
//                        
//                        RiskAdjustmentLimitDetailArray = Response.rObj.fetchProductRiskAdjustmentLimit
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
    
    
    
    func fetchInsertRiskAdjustment() {
        isLoading = true
        let url = URL(string: "\(BaseURL)api/digital/core/Policy/InsertRiskAdjustment")!
        print(url)
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        
        let authToken:String! = "Bearer " + Extensions.token
        
        request.addValue(authToken, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print(authToken as Any)
        
        let parameters: [String: Any] = [
            "policyID":Extensions.policyID,
            "assessmentID":assessmentID,
            "adjustmentTypeID":adjustmentTypeID,
            "adjustmentAmount":amountText,
            "underwriterComments":commentsText,
            "riskCategoryID":riskCategoryID,
            "riskAdjustmentLimitID":riskAdjustmentLimitID
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
                print("Insert RiskAdjustment Response = \(String(describing: resultDictionary))")
 
                DispatchQueue.main.async {
                    
                    let rcode = resultDictionary["rcode"] as? Int
                    
                    if rcode == 200 {
                      print(rcode)
                        
                        fetchRiskAdjustment()
                        isLoading = false
                        
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
    
    
    func deleteItem(_ item: RiskAdjustmentResponse.RiskAdjustmentObject.RiskAdjustmentvalue) {
        guard let index = riskAdjustmentDetailArray.firstIndex(where: { $0.riskAdjustmentID == item.riskAdjustmentID }) else {
            print("Error: Unable to find the item in the array.")
            return
        }

        let deletedRiskAdjustment = riskAdjustmentDetailArray[index]
        riskAdjustmentDetailArray.remove(at: index)

        fetchDeleteRiskAdjustment(riskAdjustmentID: deletedRiskAdjustment.riskAdjustmentID)
    }

    func fetchDeleteRiskAdjustment(riskAdjustmentID: String) {
        isLoading = true
        let url = URL(string: "\(BaseURL)api/digital/core/Policy/DeleteRiskAdjustment")!
        print(url)
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        
        let authToken:String! = "Bearer " + Extensions.token
        
        request.addValue(authToken, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print(authToken as Any)
        
        let parameters: [String: Any] = [
            "riskAdjustmentID":riskAdjustmentId
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
                print("Delete RiskAdjustment Response = \(String(describing: resultDictionary))")

                DispatchQueue.main.async {
                    
                    let rcode = resultDictionary["rcode"] as? Int
                    
                    if rcode == 200 {
                        print(rcode ?? 0)
                        
                        fetchRiskAdjustment()
                        isLoading = false
                        
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

struct RiskAdjustments_Previews: PreviewProvider {
    static var previews: some View {
        RiskAdjustments(navigateRiskAdjustmentsPage:.constant(false))
    }
}
