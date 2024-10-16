
import SwiftUI
import Foundation

var quoationSearchProductIDValue = ""
var productQuotationRefId = ""


var quotationArrayList: [QuotationResponse.QuotationResponseObject.QuotationSearch] = []
var quotationSelectedProduct = ""

var firstSelectedProduct: QuotationResponse.QuotationResponseObject.QuotationSearch.ProductCompare?
var secondSelectedProduct: QuotationResponse.QuotationResponseObject.QuotationSearch.ProductCompare?

struct QuotationPage: View {
    
    @Binding var navigateQuotationPage: Bool
    
    @State private var showCompare = false
    @State private var showCompareSelectedPopup = false
    
    @State private var navigateCompareProduct = false
    @State private var selectedIndices: Set<String> = []
    @State private var showCompareButton = false
    @State private var selectedProductIDs: Set<String> = Set()
    @State private var selectedCompareIndex: Set<String> = Set()

    
        
//    @State var quotationArrayList: [QuotationResponse.QuotationResponseObject.QuotationSearch] = []
    
    @State private var selectedItems = Set<String>()
    @State var showNextButton = false
    
    @State private var selectedProduct = false
    
    @State private var showViewCheckList = false
    
    @State private var showQuotationBreakage = false
//    @State private var quotationSelectedProduct = ""
    
    @State private var showQuotationInstallment = false
    
    @State private var showBlackSheet = false
    
    @State private var showProductPopUp = false
    
    @State var navigateCustomFormPage = false
    
    @State var navigateLineofBusiness = false
    @State var navigateProposalForm = false
    
    @State private var alertItem: AlertItem?
    @State private var isLoading = false
    
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some View {
        NavigationStack {
            LoadingView(isShowing: $isLoading) {
                VStack {
                    ZStack {

                            VStack(alignment: .center) {
                                Text("Quotation ID")
                                    .font(isFontMedium(size: 19))
                                
                                Text(Extensions.quotationID)
                                    .font(isFontMedium(size: 17))
                                    .foregroundColor(inkBlueColour)
                                    .padding(.top,1)
                            }

                            if showCompare {
                                VStack {
                                    
                                    Image("compare")
                                        .resizable()
                                        .frame(width:28, height: 28)
                                        .padding(5)
                                        .background(Color.white)
                                        .cornerRadius(6)
                                        .shadow(radius: 1)
                                    
                                    Text("Compare")
                                        .font(isFontMedium(size: 15))
                                        .foregroundColor(.black)
                                    
                                }
                                .frame(maxWidth: .infinity,alignment:.trailing)
                                .padding(.trailing,10)
                                .onTapGesture {
                                    showCompareSelectedPopup.toggle()
                                }
                            }
                            
//                            Image(systemName: "square.and.pencil")
//                                .bold()
//                                .font(.system(size: 24))
//                                .foregroundColor(inkBlueColour)
//                                .padding(.trailing)
//                                .onTapGesture {
//                                    
//                                    withAnimation {
//                                        navigateLineofBusiness = true
//                                    }
//                                    
//                                    Extensions.selectedItem = Set<String>()
//                                    
//                                    textAnswers = [:]
//                                    textAnswersParameters = [:]
//                                    textAddonAnswers = [:]
//                                    selectedItems = Set<String>()
//                                    addonVisibilityKeys = Set<String>()
//                                    selectedAddonAnswers = [:]
//                                    
//                                }
                            
                    }
                    .frame(width:345)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.top,10)
                    
                    HStack(alignment: .top,spacing:8) {
                        ZStack {
                            VStack(spacing: 5) {
                                Text("Line of Business")
                                    .font(isFontMedium(size: 19))
                                
                                Text(Extensions.selectedLineOfBusiness)
                                    .font(isFontMedium(size: 17))
                                    .foregroundColor(inkBlueColour)
                                    .padding(2)
                            }
                        }
                        .frame(width:160,height: productArray.count == 1 ? 40 : 50,alignment: .top)
                        .padding(8)
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
                        .frame(width:160,height: productArray.count == 1 ? 40 : 50,alignment: .top)
                        .padding(8)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.trailing)
                        
                    }
                    
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            
                            ForEach(quotationArrayList.indices, id: \.self) { quotationvalue in
                                let quotation = quotationArrayList[quotationvalue]
                                
                                ForEach(quotation.quotationProduct, id: \.quoationSearchProductID) { quotationProduct in
                                    if let quotationDetails = quotationProduct.quotationDetails {
                                        ForEach(quotationDetails, id: \.sTotalPremium) { quotationDetail in
                                            VStack(spacing:0) {
                                                ZStack {
                                                    VStack {
                                                        VStack(spacing:0) {
                                                            VStack(alignment:.center, spacing:0) {
                                                                Text(quotationDetail.products.productName)
                                                                    .padding(12)
                                                                    .bold()
                                                                    .font(isFontMedium(size: 20))
//                                                                    .multilineTextAlignment(.center)
                                                            }
                                                            .frame(width:350)
                                                            .fixedSize(horizontal: false, vertical: true)
                                                            .background(Color(.white))
                                                            
                                                            Divider()
                                                                .frame(width:350,height:1)
                                                                .background(Color.secondary)
                                                            
                                                            Spacer()
                                                        }
                                                        
                                                        if let totalPremium = quotationDetail.sTotalPremium, !totalPremium.isEmpty {
                                                            HStack {
                                                                
                                                                VStack(alignment:.leading,spacing:10) {
                                                                    
                                                                    Text("Total Premium")
                                                                        .bold()
                                                                        .font(isFontMedium(size: 20))
                                                                    
                                                                    Text(quotationDetail.sTotalPremium ?? "")
                                                                        .bold()
                                                                        .font(isFontMedium(size: 20))
                                                                        .foregroundColor(inkBlueColour)
                                                                        .fixedSize(horizontal: false, vertical: true)
                                                                }.padding(.leading)
                                                                
                                                                Spacer()
                                                                
                                                                VStack(spacing:10) {
                                                                    
                                                                    Button(action:{
                                                                        if selectedItems.contains(quotationDetail.productUniqueID) {
                                                                            selectedItems.remove(quotationDetail.productUniqueID)
                                                                            showNextButton = false
                                                                            
                                                                        } else {
                                                                            selectedItems.removeAll()
                                                                            selectedItems.insert(quotationDetail.productUniqueID)
                                                                            
                                                                        }
                                                                        
                                                                        Extensions.quotationDetailRefID = quotationDetail.quotationDetailRefID
                                                                        
                                                                        showNextButton = !selectedItems.isEmpty
                                                                        
                                                                    })
                                                                    {
                                                                        Text(selectedItems.contains(quotationDetail.productUniqueID) ? "Selected" : "Select")
                                                                            .foregroundColor(.white)
                                                                            .font(isFontMedium(size: 19))
                                                                            .frame(width: 120, height:45)
                                                                            .background(selectedItems.contains(quotationDetail.productUniqueID) ? Color.gray.opacity(0.7) : fontOrangeColour)
                                                                            .cornerRadius(8)
                                                                            .padding(.trailing)
                                                                    }
                                                                    
                                                                    if let checkList = quotationDetail.checklist, !checkList.isEmpty {
                                                                        Button(action:{
                                                                            showViewCheckList = true
                                                                            
                                                                            quotationSelectedProduct = quotationDetail.productUniqueID
                                                                        })
                                                                        {
                                                                            Text("View Checklist")
                                                                                .underline()
                                                                                .font(isFontMedium(size: 16))
                                                                                .foregroundColor(inkBlueColour)
                                                                                .padding(.trailing)
                                                                        }
                                                                    } else {
                                                                        Text("No Checklist Available")
                                                                            .underline()
                                                                            .font(isFontMedium(size: 15))
                                                                            .foregroundColor(.black)
                                                                            .padding(.trailing,10)
                                                                    }
                                                                    
                                                                    
                                                                }
                                                                
                                                            }
                                                            .padding(.bottom,10)

                                                        } else {
                                                            
                                                            Text("Based on the criteria you have selected, this product is not eligible for you.")
                                                                .font(isFontMedium(size: 16))
                                                                .foregroundColor(.gray)
                                                                .multilineTextAlignment(.center)
                                                                .padding(8)
                                                            
                                                        }
                                                        
                                                    }
                                                }
                                                .frame(width:350)
                                                .fixedSize(horizontal: false, vertical: true)
                                                .background(Color(.secondarySystemBackground))
                                                .cornerRadius(15)
                                                .shadow(radius: 2)
                                                
                                                HStack {
                                                    
                                                    if let installment = quotationDetail.installment, !installment.isEmpty {
                                                        
                                                        Text("INSTALLMENTS")
                                                            .font(isFontMedium(size: 18))
                                                            .foregroundColor(.white)
                                                            .frame(width: quotationDetail.breakdown?.isEmpty ?? true ? 250 : 150, height: 25)
                                                            .background(sykBlueColour)
                                                            .mask(RoundedCorner(radius: 10, corners: [.bottomLeft]))
                                                            .mask(RoundedCorner(radius: 10, corners: [.bottomRight]))
                                                            .onTapGesture {
                                                                
                                                                quotationSelectedProduct = quotationDetail.productUniqueID
                                                                
                                                                showQuotationInstallment = true
                                                            }
                                                    }
                                                    
                                                    if let breakDown = quotationDetail.breakdown, !breakDown.isEmpty {
                                                        Text("BREAK-DOWN")
                                                            .font(isFontMedium(size: 18))
                                                            .foregroundColor(.white)
                                                            .frame(width: quotationDetail.installment?.isEmpty ?? true ? 250 : 150, height: 25)
                                                            .background(sykBlueColour)
                                                            .mask(RoundedCorner(radius: 10, corners: [.bottomLeft]))
                                                            .mask(RoundedCorner(radius: 10, corners: [.bottomRight]))
                                                            .onTapGesture {
                                                                quotationSelectedProduct = quotationDetail.productUniqueID
                                                                showQuotationBreakage = true
                                                            }
                                                    }
                                                }
                                            }
                                            .padding(5)
                                        }
                                    }
                                }
                            }
                            
                        }
                        .onAppear {
                            fetchQuotationResponse()
                        }
                    }
                    
                    VStack {
                        
                        if showNextButton {
                            Button(action:{
                                withAnimation {
                                    navigateProposalForm = true
                                }
                            })
                            {
                                Text("NEXT")
                                    .padding(.top)
                                    .frame(maxWidth: .infinity)
                                    .background(fontOrangeColour)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .font(isFontBold(size: 20))
                            }
                            
                        }
                    }
                    
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
                                    navigateQuotationPage = false
                                }
                                
                            })
                            {
                                
                                Image(systemName: "arrow.backward")
                                    .bold()
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .padding(.bottom)
                                
                            }
                            
                            Text("Quotation")
                                .bold()
                                .font(isFontBlack(size: 22))
                                .foregroundColor(.white)
                                .padding(.bottom,8)
                            
                        }
                    }
                }
                .toolbarBackground(toolbarcolor, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
            }
        }.navigationBarBackButtonHidden()
        
            .overlay {
                navigateProposalForm ? ProposalForms(navigateProposalForm: $navigateProposalForm) : nil
                
                navigateLineofBusiness ? LineOfBusinessView(navigateInsuranceOptiondPage: .constant(false)) : nil
                
                !networkMonitor.isConnected ? ErrorView() : nil
                
                navigateCompareProduct ?  QuotationCompareProduct(selectedIndices: $selectedIndices, navigateProposalForm: $navigateProposalForm, navigateCompareProduct: $navigateCompareProduct) : nil
                
               
                
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
                
            }
        
            .overlay {
                if showViewCheckList {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showViewCheckList = false
                        }
                    
                    QuotationChecklistPopup(showViewCheckList: $showViewCheckList)
                }
                
                if showQuotationInstallment {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showQuotationInstallment = false
                        }
                    
                    QuotationInstallmentPopup(showQuotationInstallment: $showQuotationInstallment)
                    
                }
                
                if showCompareSelectedPopup {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showCompareSelectedPopup = false
                        }
                                        
                    ZStack {
                        Color(.secondarySystemBackground)
                        VStack {
                            HStack {
                                Image(systemName: "multiply")
                                    .foregroundColor(.white)
                                    .font(.system(size: 22))
                                    .bold()
                                    .padding(.leading)
                                    .onTapGesture {
                                        showCompareSelectedPopup = false
                                    }
                                
                                Spacer()
                                
                                Text("Compare Quotations")
                                    .bold()
                                    .foregroundColor(.white)
                                    .font(isFontMedium(size: 20))
                                    .padding(.trailing)
                                
                                Spacer()
                            }
                            .frame(width:350,height:50)
                            .background(fontOrangeColour)
                            
                            ScrollView {
                                LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
                                    
                                    
                                    ForEach(quotationArrayList.indices, id: \.self) { quotationvalue in
                                        let quotation = quotationArrayList[quotationvalue]
                                        
                                        ForEach(quotation.quotationProduct, id: \.quoationSearchProductID) { quotationProduct in
                                            if let quotationDetails = quotationProduct.quotationDetails {
                                                ForEach(quotationDetails, id: \.sTotalPremium) { quotationDetail in
                                                    if let totalPremium = quotationDetail.sTotalPremium, !totalPremium.description.isEmpty {
                                                        VStack {
                                                            ZStack {
                                                                Color.white
                                                                
                                                                
                                                                VStack {
                                                                    
                                                                    HStack {
                                                                        Image(systemName: selectedIndices.contains(quotationDetail.productUniqueID) ?  "checkmark.square.fill" : "square")
                                                                            .bold()
                                                                            .font(isFontMedium(size: 23))
                                                                            .foregroundColor(selectedIndices.contains(quotationDetail.productUniqueID) ? toolbarcolor : .black)
                                                                            .frame(maxWidth:.infinity, alignment:.trailing)
                                                                            .padding(.trailing,10)
                                                                    }
                                                                    .frame(width: 140, height: 10)
                                                                    
                                                                    
                                                                    Image("CompareProductLogo")
                                                                        .resizable()
                                                                        .frame(width: 100, height: 100)
                                                                    
                                                                    Text(quotationDetail.products.productName)
                                                                        .font(isFontMedium(size: 14))
                                                                        .multilineTextAlignment(.center)
                                                                        .lineLimit(1)
                                                                    
                                                                    Text(quotationDetail.sTotalPremium ?? "")
                                                                        .font(isFontMedium(size: 16))
                                                                        .foregroundColor(inkBlueColour)
                                                                        .multilineTextAlignment(.center)
                                                                        .lineLimit(1)
                                                                    
                                                                }
                                                            }
                                                            .frame(width: 140, height: 180)
                                                            .cornerRadius(15)
                                                            .shadow(radius: 2)
                                                            .onTapGesture {
                                                                
                                                                if selectedIndices.contains(quotationDetail.productUniqueID) {
                                                                    selectedIndices.remove(quotationDetail.productUniqueID)
                                                                    if selectedIndices.count != 2 {
                                                                        showCompareButton = false
                                                                    }
                                                                    
                                                                } else {
                                                                    selectedIndices.insert(quotationDetail.productUniqueID)
                                                                    if selectedIndices.count == 2 {
                                                                        showCompareButton = true
                                                                    }
                                                                }
                                                                
                                                                print(selectedIndices)
                                                                
                                                                for value in quotationArrayList {
                                                                    
                                                                    if let productCompare = value.productCompare {
                                                                        for (_, data) in productCompare.enumerated() {
                                                                            if let benefits = data.mainBenefits {
                                                                                for benefit in benefits {
                                                                                    if selectedIndices.contains(data.productID ?? "") {
                                                                                        if ((benefit.marketingStatement1?.isEmpty) != nil) {
                                                                                            uniqueTitles.insert(benefit.pZBenefitTitle)
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                                print(selectedCompareIndex)
                                                                
                                                            }
                                                            .padding(10)
                                                            
                                                            
                                                        }
                                                    }
                                                }
                                            }
                                            
                                        }
                                    }
                                    
                                }.padding(10)
                                
                                
                            }
                            
                            if showCompareButton {
                                HStack {
                                    Text("Compare")
                                        .bold()
                                        .foregroundColor(.white)
                                        .font(isFontMedium(size: 20))
                                        .padding(.trailing)
                                }
                                .frame(width:350,height:50)
                                .background(fontOrangeColour)
                                .onTapGesture {
                                    if selectedIndices.count != 2 {
                                        self.alertItem = AlertItem(title: Text("ERR019 \n Please select only two products for comparison.".localized()))
                                    } else {
                                        navigateCompareProduct = true
                                        showCompareSelectedPopup = false
                                        showCompareButton = false
                                    }
                                }
                            }
                        }
                    }
                    .frame(width:350, height:.infinity)
                    .cornerRadius(8)

                }
                
            }

            .overlay {

                if showQuotationBreakage {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showQuotationBreakage = false
                        }
                    
                    QuotationBreakdownPopup(showQuotationBreakage: $showQuotationBreakage)
                }
                
            }
        
    }
    
    
    func fetchQuotationResponse() {
        
        isLoading = true
        
        let parameters: [String: Any] = [
            
            "quotationSearchID" :  quotationSearchID
        ]
        
        print("quotationSearchID \(parameters)")
        
        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(BaseURL)")!,
                                         path: "api/prodconfig/Quotation/GetQuotationSearch",
                                         method: "POST",bodyData:parameters)
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<QuotationResponse, Error>) in
            switch result {
            case .success(let quotationResponse):
                // Handle success
                DispatchQueue.main.async {
                    
                    if quotationResponse.rcode == 200 {
                        print(quotationResponse.rcode)
                        
                        quotationArrayList = [quotationResponse.rObj.GetQuotationSearch]
                      
                        isLoading = false
                        
                        for value in quotationArrayList {
                            if value.quotationProduct.count > 1 {
                                showCompare = true
                                
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
    
    
}










