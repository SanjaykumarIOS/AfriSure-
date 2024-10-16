
import Foundation
import SwiftUI

extension QuotationHistoryResponse.QuotationHistoryrObj.QuotationHistoryDetail: Equatable {
    static func == (lhs: QuotationHistoryResponse.QuotationHistoryrObj.QuotationHistoryDetail, rhs: QuotationHistoryResponse.QuotationHistoryrObj.QuotationHistoryDetail) -> Bool {
        // Implement equality check based on your requirements
        // For example, you might compare properties like quotationRequestID
        return lhs.quotationRequestID == rhs.quotationRequestID
    }
}



//extension Notification.Name {
//    static let scrollToBottom = Notification.Name("scrollToBottom")
//}
//
//extension View {
//    func onScrollToEnd(perform action: @escaping () -> Void) -> some View {
//        self.onAppear {
//            NotificationCenter.default.addObserver(forName: .scrollToBottom, object: nil, queue: .main) { _ in
//                action()
//            }
//        }
//    }
//}





struct QuotationHistory: View {
    
    @Binding var navigateQuotationHistory: Bool
    
    @State private var quotationHistoryArray: [QuotationHistoryResponse.QuotationHistoryrObj.QuotationHistoryDetail] = []
    
    @State private var pageNo = 1
    
    @State private var alertItem: AlertItem?
    @State private var isLoading = false
    
    
  @State var totalItemsCount = 0
    
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some View {
       
        NavigationStack {
           
            LoadingView(isShowing: $isLoading) {
                VStack {
                    List {
                    ForEach(quotationHistoryArray, id: \.quotationRequestID) { quotation in
                        VStack(spacing:0) {
                            ZStack {
                                Color.white
                                
                                VStack {
                                    VStack {
                                        ZStack {
                                            fontOrangeColour
                                            
                                            Text("Quotation # \(quotation.quotationID ?? "")")
                                                .font(isFontMedium(size: 17))
                                                .foregroundColor(.white)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(.leading)
                                            
                                            Image(systemName: "eye.fill")
                                                .font(isFontMedium(size: 20))
                                                .foregroundColor(.white)
                                                .frame(maxWidth: .infinity, alignment: .trailing)
                                                .padding(.trailing)
                                        }
                                        .frame(width: 350, height: 40)
                                        
                                        Spacer()
                                    }
                                    
                                    HStack(alignment:.top) {
                                        VStack(alignment:.leading, spacing:10) {
                                            
                                            Text("User Name")
                                                .bold()
                                                .font(isFontMedium(size: 18))
                                            
                                            Text(quotation.customerFullName ?? "---")
                                                .font(isFontMedium(size: 16))
                                            
                                            Text("Created On")
                                                .bold()
                                                .font(isFontMedium(size: 18))
                                            
                                            Text(quotation.quotationCreationDate ?? "---")
                                                .font(isFontMedium(size: 16))
                                            
                                            Text("Policy Type")
                                                .bold()
                                                .font(isFontMedium(size: 18))
                                            
                                            if let groupPolicy = quotation.isGroupPolicy {
                                                Text(groupPolicy ? "Group_Policy_Type" : "Single_Policy_Type")
                                                    .font(isFontMedium(size: 16))
                                            } else {
                                                Text("---")
                                                    .font(isFontMedium(size: 16))
                                            }
                                            
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading)
                                        .frame(width: 180)
                                        
                                        
                                        VStack(alignment:.leading, spacing:10) {
                                            
                                            Text("Account Number")
                                                .bold()
                                                .font(isFontMedium(size: 18))
                                            
                                            Text(quotation.customerAccountNum ?? "---")
                                                .font(isFontMedium(size: 16))
                                            
                                            Text("Expiry Date")
                                                .bold()
                                                .font(isFontMedium(size: 18))
                                            
                                            Text(quotation.quotationExpirationDate ?? "---")
                                                .font(isFontMedium(size: 16))
                                            
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .frame(width: 180)
                                        
                                    }
                                    .padding(5)
                                }
                                
                            }
                            .frame(width:350)
                            .fixedSize(horizontal: false, vertical: true)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            
                            if let groupPolicy = quotation.isGroupPolicy, groupPolicy {
                                
                                Text("CONVERT TO POLICY")
                                    .font(isFontMedium(size: 18))
                                    .foregroundColor(.white)
                                    .frame(width: 280, height: 25)
                                    .background(sykBlueColour)
                                    .mask(RoundedCorner(radius: 10, corners: [.bottomLeft]))
                                    .mask(RoundedCorner(radius: 10, corners: [.bottomRight]))
                                    .onTapGesture {
                                        
                                    }
                            }
                        }
                        .padding(5)
                        .onAppear {
                            if quotation == quotationHistoryArray.last {
                                fetchMoreData()
                            }
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                       
                    
                    
                    
//                    ScrollViewReader { scrollView in
//                        ScrollView(showsIndicators:false) {
//                            VStack {
//                                ForEach(Array(quotationHistoryArray.enumerated()), id: \.element.quotationRequestID) { index, quotation in
//                                    
//                                    VStack(spacing:0) {
//                                        ZStack {
//                                            Color.white
//                                            
//                                            VStack {
//                                                VStack {
//                                                    ZStack {
//                                                        fontOrangeColour
//                                                        
//                                                        Text("Quotation # \(quotation.quotationID ?? "")")
//                                                            .font(isFontMedium(size: 17))
//                                                            .foregroundColor(.white)
//                                                            .frame(maxWidth: .infinity, alignment: .leading)
//                                                            .padding(.leading)
//                                                        
//                                                        Image(systemName: "eye.fill")
//                                                            .font(isFontMedium(size: 20))
//                                                            .foregroundColor(.white)
//                                                            .frame(maxWidth: .infinity, alignment: .trailing)
//                                                            .padding(.trailing)
//                                                    }
//                                                    .frame(width: 350, height: 40)
//                                                    
//                                                    Spacer()
//                                                }
//                                                
//                                                HStack(alignment:.top) {
//                                                    VStack(alignment:.leading, spacing:10) {
//                                                        
//                                                        Text("User Name")
//                                                            .bold()
//                                                            .font(isFontMedium(size: 18))
//                                                        
//                                                        Text(quotation.customerFullName ?? "---")
//                                                            .font(isFontMedium(size: 16))
//                                                        
//                                                        Text("Created On")
//                                                            .bold()
//                                                            .font(isFontMedium(size: 18))
//                                                        
//                                                        Text(quotation.quotationCreationDate ?? "---")
//                                                            .font(isFontMedium(size: 16))
//                                                        
//                                                        Text("Policy Type")
//                                                            .bold()
//                                                            .font(isFontMedium(size: 18))
//                                                        
//                                                        if let groupPolicy = quotation.isGroupPolicy {
//                                                            Text(groupPolicy ? "Group_Policy_Type" : "Single_Policy_Type")
//                                                                .font(isFontMedium(size: 16))
//                                                        } else {
//                                                            Text("---")
//                                                                .font(isFontMedium(size: 16))
//                                                        }
//                                                        
//                                                    }
//                                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                                    .padding(.leading)
//                                                    .frame(width: 180)
//                                                    
//                                                    
//                                                    VStack(alignment:.leading, spacing:10) {
//                                                        
//                                                        Text("Account Number")
//                                                            .bold()
//                                                            .font(isFontMedium(size: 18))
//                                                        
//                                                        Text(quotation.customerAccountNum ?? "---")
//                                                            .font(isFontMedium(size: 16))
//                                                        
//                                                        Text("Expiry Date")
//                                                            .bold()
//                                                            .font(isFontMedium(size: 18))
//                                                        
//                                                        Text(quotation.quotationExpirationDate ?? "---")
//                                                            .font(isFontMedium(size: 16))
//                                                        
//                                                    }
//                                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                                    .frame(width: 180)
//                                                    
//                                                }
//                                                .padding(5)
//                                            }
//                                            
//                                        }
//                                        .frame(width:350)
//                                        .fixedSize(horizontal: false, vertical: true)
//                                        .cornerRadius(10)
//                                        .shadow(radius: 2)
//                                        
//                                        if let groupPolicy = quotation.isGroupPolicy, groupPolicy {
//                                            
//                                            Text("CONVERT TO POLICY")
//                                                .font(isFontMedium(size: 18))
//                                                .foregroundColor(.white)
//                                                .frame(width: 280, height: 25)
//                                                .background(sykBlueColour)
//                                                .mask(RoundedCorner(radius: 10, corners: [.bottomLeft]))
//                                                .mask(RoundedCorner(radius: 10, corners: [.bottomRight]))
//                                                .onTapGesture {
//                                                    
//                                                }
//                                        }
//                                    }
//                                    .padding(5)
//                                    .onAppear {
//                                      
//                                        
//                                    }
//
//                                    
//                                }
//                               
//                            }
//                            
//                        }
//                        .onScrollToEnd {
//                            fetchMoreData()
//                        }
//                        
//                    }
                    
                    
                }
                .onAppear(perform: fetchInitialData)
               
                
                
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
                                    navigateQuotationHistory = false
                                }
                                
                            })
                            {
                                
                                Image(systemName: "arrow.backward")
                                    .bold()
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .padding(.bottom)
                            }
                            
                            Text("Quotation List")
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
        }
        .navigationBarBackButtonHidden()
        .background(Color(.secondarySystemBackground))
        
        .overlay(
            !networkMonitor.isConnected ? ErrorView() : nil
        )
        
    }
    

    
   
    
    func fetchInitialData() {
        fetchQuotationHistory(pageNo: pageNo)
    }

    func fetchMoreData() {
        pageNo += 1
        fetchQuotationHistory(pageNo: pageNo)
    }
    
    func fetchQuotationHistory(pageNo: Int) {
        
        isLoading = true
        
        let parameters: [String: Any?] = [
            "pageNo":pageNo,
            "pageSize":10,
            "quotationRequestID":nil,
            "customerAccountID":nil,
            "customerFullName":nil,
            "customerPhoneNo":nil,
            "customerEmail":nil
        ]
        
        print("quotationSearchID \(parameters)")
        
        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(BaseURL)")!,
                                         path: "api/prodconfig/Quotation/GetAllQuotation",
                                         method: "POST",bodyData:parameters as [String : Any])
        
        APIService.request(endpoint: dynamicEndpoint) { (result: Result<QuotationHistoryResponse, Error>) in
            switch result {
            case .success(let quotationResponse):
                // Handle success
                DispatchQueue.main.async {
                    
                    if quotationResponse.rcode == 200 {
                        print(quotationResponse.rcode)
                        isLoading = false
                        
//                        quotationHistoryArray = quotationResponse.rObj.getAllQuotationDeatails
                        quotationHistoryArray.append(contentsOf: quotationResponse.rObj.getAllQuotationDeatails)
                        
                       
                        
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
    QuotationHistory(navigateQuotationHistory: .constant(false))
}



