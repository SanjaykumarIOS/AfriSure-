



import SwiftUI

var quoationSearchProductIDValue = ""
var productQuotationRefId = ""

struct QuotationPage: View {
    
    @State var quotationList: [QuotationSearchResponse.QuotationSearchObject.QuotationSearchProductItem] = []
    
    @State private var selectedItems = Set<String>()
    @State var showNextButton = false
    
    @State private var showViewCheckList = false
    
    @State private var showQuotationBreakage = false
    @State private var quotationSelectedProduct = 0
    
    @State private var showBlackSheet = false
    
    @State private var showProductPopUp = false
    
    @State var navigateCustomFormPage = false
    
    @State var navigateProposalForm = false
    @State private var alertItem: AlertItem?
    @State private var isLoading = false
    
    
    var body: some View {
        NavigationStack {
            LoadingView(isShowing: $isLoading) {
                VStack {
                    
                    ZStack {
                        
                        HStack {
                            
                            Spacer()
                            VStack(alignment: .center) {
                                Text("Quotation ID")
                                    .font(isFontMedium(size: 20))
                                
                                Text("AA-A410001")
                                    .font(isFontMedium(size: 18))
                                    .foregroundColor(inkBlueColour)
                                    .padding(.top,1)
                            }
                            .padding(.leading)
                            
                            Spacer()
                            
                            Image(systemName: "square.and.pencil")
                                .bold()
                                .font(.system(size: 24))
                                .foregroundColor(inkBlueColour)
                                .padding(.trailing)
                            
                        }
                    }
                    .frame(width:360)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top,10)
                    .padding(.bottom,10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.top,10)
                    
                    HStack(alignment: .top) {
                        ZStack {
                            VStack {
                                Text("Line of Business")
                                    .font(isFontMedium(size: 21))
                                
                                Text(Extensions.selectedLineOfBusiness)
                                    .font(isFontMedium(size: 18))
                                    .foregroundColor(inkBlueColour)
                                    .padding(2)
                            }
                            
                        }
                        .frame(width:175,height: 70,alignment: .top)
                        .padding(.top,10)
                        .padding(.bottom,10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.leading)
                        
                        ZStack {
                            VStack {
                                Text("Products")
                                    .font(isFontMedium(size: 21))
                                
                                if Extensions.selectedItem.count == 1 {
                                    
                                    Text(Array(Extensions.selectedItem).first!)
                                        .font(isFontMedium(size: 18))
                                        .foregroundColor(inkBlueColour)
                                        .padding(2)
                                } else {
                                    HStack {
                                        
                                        if let firstSelectedItem = Extensions.selectedItem.first {
                                            Text(firstSelectedItem)
                                                .font(isFontMedium(size: 18))
                                                .foregroundColor(.black)
                                                .padding(.leading,10)
                                                .lineLimit(1)
                                        }
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.down")
                                            .font(isFontMedium(size: 20))
                                            .padding(.trailing,10)
                                        
                                    }
                                    .frame(width: 160,height: 40)
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(6)
                                    .onTapGesture {
                                        showProductPopUp = true
                                    }
                                }
                                
                            }
                            
                        }
                        .frame(width:175,height: 70,alignment: .top)
                        .padding(.top,10)
                        .padding(.bottom,10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.trailing)

                    }
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            
                            ForEach(quotationList, id: \.productName) { quotation in
                                
                                ZStack {
                                    
                                    Text("VIEW BREAKAGE")
                                        .padding(.top)
                                        .font(isFontMedium(size: 18))
                                        .foregroundColor(.white)
                                        .frame(width: 150,height:35)
                                        .background(fontOrangeColour)
                                        .cornerRadius(10)
                                        .padding(.top,320)
                                        .onTapGesture {
                                            if !quotation.getAllByQuotationBreakage.isEmpty {
                                                showQuotationBreakage = true
                                                quotationSelectedProduct = quotation.productID
                                            } else {
                                                showBlackSheet = true
                                            }
                                        }
                                    
                                    VStack {
                                        
                                        ZStack {
                                            Color.white
                                            
                                            VStack {
                                                
                                                HStack {
                                                    
                                                    Text(quotation.productName)
                                                        .bold()
                                                        .font(isFontMedium(size: 20))
                                                        .foregroundColor(fontOrangeColour)
                                                    
                                                }
                                                .fixedSize(horizontal: false, vertical: true)
                                                
                                                Divider()
                                                    .frame(width: 400,height: 2)
                                                    .background(Color(.gray).opacity(0.3))
                                                
                                                
                                                VStack {
                                                    
                                                    HStack(alignment: .top) {
                                                        Text("Basic premium")
                                                            .font(isFontMedium(size: 17))
                                                            .foregroundColor(.black)
                                                            .frame(width: 170,alignment: .leading)
                                                            .padding(.leading)
                                                        
                                                        Text(quotation.sBasicPremium)
                                                            .font(isFontMedium(size: 18))
                                                            .frame(width: 170,alignment: .leading)
                                                    }
                                                    .padding(3)
                                                    .padding(.leading)
                                                    
                                                    Divider()
                                                        .frame(width: 320,height: 1,alignment:.center)
                                                    
                                                    HStack(alignment: .top) {
                                                        Text("Add ons premium")
                                                            .font(isFontMedium(size: 17))
                                                            .foregroundColor(.black)
                                                            .frame(width: 170,alignment: .leading)
                                                            .padding(.leading)
                                                        
                                                        Text(quotation.sAddOnsPremium)
                                                            .font(isFontMedium(size: 18))
                                                            .frame(width: 170,alignment: .leading)
                                                    }
                                                    .padding(3)
                                                    .padding(.leading)
                                                    
                                                    Divider()
                                                        .frame(width: 320,height: 1,alignment:.center)
                                                    
//                                                    HStack(alignment: .top) {
//                                                        Text("Discount premium")
//                                                            .font(isFontMedium(size: 17))
//                                                            .foregroundColor(.black)
//                                                            .frame(width: 170,alignment: .leading)
//                                                            .padding(.leading)
//
//                                                        Text(quotation.sDiscountPremium)
//                                                            .font(isFontMedium(size: 18))
//                                                            .frame(width: 170,alignment: .leading)
//                                                    }
//                                                    .padding(3)
//                                                    .padding(.leading)
//
//                                                    Divider()
//                                                        .frame(width: 320,height: 1,alignment:.center)
                                                    
                                                    HStack(alignment: .top) {
                                                        Text("Before Tax")
                                                            .font(isFontMedium(size: 17))
                                                            .foregroundColor(.black)
                                                            .frame(width: 170,alignment: .leading)
                                                            .padding(.leading)
                                                        
                                                        Text(quotation.sBeforeTax)
                                                            .font(isFontMedium(size: 18))
                                                            .frame(width: 170,alignment: .leading)
                                                    }
                                                    .padding(3)
                                                    .padding(.leading)
                                                    
                                                    Divider()
                                                        .frame(width: 320,height: 1,alignment:.center)
                                                    
                                                    HStack(alignment: .top) {
                                                        Text("Tax premium")
                                                            .font(isFontMedium(size: 17))
                                                            .foregroundColor(.black)
                                                            .frame(width: 170,alignment: .leading)
                                                            .padding(.leading)
                                                        
                                                        Text(quotation.sTaxPremium)
                                                            .font(isFontMedium(size: 18))
                                                            .frame(width: 170,alignment: .leading)
                                                    }
                                                    .padding(3)
                                                    .padding(.leading)
                                                    
                                                }
                                                
                                                HStack {
                                                    VStack(alignment:.leading) {
                                                        
                                                        Text("Total premium")
                                                            .font(isFontMedium(size: 18))
                                                            .foregroundColor(.black)
                                                        
                                                        Text(quotation.sTotalPremium)
                                                            .bold()
                                                            .font(isFontMedium(size: 22))
                                                            .foregroundColor(inkBlueColour)
                                                            .padding(.top,1)
                                                    }
                                                    .padding(.leading,10)
                                                    
                                                    Spacer()
                                                    
                                                    VStack(alignment:.center,spacing:10) {
                                                        Button(action:{
                                                            if selectedItems.contains(quotation.productName) {
                                                                selectedItems.remove(quotation.productName)
                                                                showNextButton = false
                                                            } else {
                                                                selectedItems.removeAll()
                                                                selectedItems.insert(quotation.productName)
                                                            }
                                                            
                                                            showNextButton = !selectedItems.isEmpty
                                                            
                                                            Extensions.productID = quotation.productID
                                                            
                                                            for quote in quotationList {
                                                                for value in quote.getAllByQuotationBreakage {
                                                                    Extensions.quoationSearchProductID = value.quoationSearchProductID
                                                                }
                                                            }
                                                            
                                                        })
                                                        {
                                                            Text(selectedItems.contains(quotation.productName) ? "Selected" : "Select")
                                                                .foregroundColor(.white)
                                                                .font(isFontMedium(size: 19))
                                                                .frame(width: 120, height:45)
                                                                .background(selectedItems.contains(quotation.productName) ? Color.gray.opacity(0.7) : fontOrangeColour)
                                                                .cornerRadius(8)
                                                                .padding(.trailing)
                                                        }
                                                        
                                                        
                                                        Button(action:{
                                                            showViewCheckList = true
                                                        })
                                                        {
                                                            Text("View Checklist")
                                                                .underline()
                                                                .font(isFontMedium(size: 16))
                                                                .foregroundColor(inkBlueColour)
                                                                .padding(.trailing)
                                                        }
                                                        
                                                    }
                                                }
                                                .frame(width:330)
                                                .fixedSize(horizontal: false, vertical: true)
                                                .padding(.top,10)
                                                .padding(.bottom,10)
                                                .background(Color.gray.opacity(0.2))
                                                .cornerRadius(8)
                                                .padding(.top,10)
                                                
                                            }
                                            .padding(.top,10)
                                            .padding(.bottom,10)
                                            .padding(.leading,10)
                                            .padding(.trailing,10)
                                            
                                        }
                                        .frame(width: 350)
                                        .cornerRadius(14)
                                        .shadow(radius: 4)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .padding(.leading,10)
                                        .padding(.trailing,10)
                                        .padding(.top,17)
                                        
                                        Spacer()
                                    }
                                }
                                
                            }
                            
                        }
                        .onAppear {
                            fetchQuotation()
                        }
                    }
                    
                    VStack {
                        
                        if showNextButton {
                            Button(action:{
                                navigateProposalForm = true
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
                            
                            NavigationLink("", destination: ProposalForms(), isActive: $navigateProposalForm)
                        }
                    }
                }
                .onAppear {
                    //                    fetchGetAllProduct()
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
                                navigateCustomFormPage = true
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
                            
                            NavigationLink("", destination: CustomForms(), isActive: $navigateCustomFormPage)

                        }
                    }
                }
                .toolbarBackground(toolbarcolor, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
                
            }
        }.navigationBarBackButtonHidden()
        .overlay {
            
            if showProductPopUp {
                ZStack {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showProductPopUp = false
                        }
                    VStack {
                        ForEach(Array(Extensions.selectedItem), id: \.self) {
                            
                            Text($0)
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
            
            if showViewCheckList {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showViewCheckList = false
                    }
                ZStack {
                    Color.white
                    VStack {
                        HStack {
                            Image(systemName: "multiply")
                                .foregroundColor(.white)
                                .font(.system(size: 22))
                                .bold()
                                .padding(.leading)
                                .onTapGesture {
                                    showViewCheckList = false
                                }
                            
                            Spacer()
                            
                            Text("Check List")
                                .foregroundColor(.white)
                                .font(isFontMedium(size: 20))
                            
                            Spacer()
                        }
                        .frame(width:320,height:50)
                        .background(fontOrangeColour)
                        
                        VStack {
                            Text("jsgkngjekgnevnvoeingienveve")
                        }
                        
                    }
                    
                }
                .frame(width:320)
                .fixedSize(horizontal: false, vertical: true)
                .cornerRadius(8)
                
            }
            
            if showQuotationBreakage {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showQuotationBreakage = false
                    }
                ZStack {
                    Color.white
                    VStack {
                        HStack {
                            Image(systemName: "multiply")
                                .foregroundColor(.white)
                                .font(.system(size: 22))
                                .bold()
                                .padding(.leading)
                                .onTapGesture {
                                    showQuotationBreakage = false
                                }
                            
                            Spacer()
                            
                            Text("Quotation Breakage")
                                .foregroundColor(.white)
                                .font(isFontMedium(size: 20))
                                .padding(.trailing)
                            
                            Spacer()
                        }
                        .frame(width:350,height:50)
                        .background(fontOrangeColour)
                        
                        VStack(spacing: 0) {
                            HStack(spacing: 0) {
                                VStack(spacing: 0) {
                                    
                                    Text("S.No")
                                        .bold()
                                        .font(.system(size: 18))
                                        .foregroundColor(fontOrangeColour)
                                        .frame(width: 50, height: 30, alignment: .center)
                                        .background(Color.gray.opacity(0.3))
                                    
                                    Divider()
                                        .frame(width:50,height:2)
                                        .background(Color.white)
                                    
                                }
                                
                                VStack(spacing: 0) {
                                    Text("Premium Category")
                                        .bold()
                                        .font(.system(size: 18))
                                        .foregroundColor(fontOrangeColour)
                                        .frame(width: 189, height: 30, alignment: .center)
                                    
                                    Divider()
                                        .frame(width:189,height:1)
                                        .background(Color.gray.opacity(0.3))
                                }
                                
                                VStack(spacing: 0) {
                                    Text("Amount")
                                        .bold()
                                        .font(.system(size: 18))
                                        .foregroundColor(fontOrangeColour)
                                        .frame(width: 100, height: 30, alignment: .center)
                                        .background(Color.gray.opacity(0.3))
                                    
                                    Divider()
                                        .frame(width:100)
                                }
                            }
                            
                            ScrollView(showsIndicators:false) {
                                VStack(spacing:0) {
                                    ForEach(quotationList, id:\.sTaxPremium) { quotation in
                                        
                                        if quotationSelectedProduct == quotation.productID {
                                            ForEach(quotation.getAllByQuotationBreakage, id:\.productBreakageID) { value in
                                                
                                                if value.premiumCategoryName != "Total" {
                                                    
                                                    HStack(spacing: 0) {
                                                        
                                                        VStack(alignment: .leading, spacing: 0) {
                                                            Text("\(value.serialNumber)")
                                                                .modifier(TextModifier())
                                                                .background(Color.gray.opacity(0.3))
                                                            
                                                            Divider()
                                                                .frame(width: 50, height: 2)
                                                                .background(Color.white)
                                                        }
                                                        .frame(width: 50)
                                                        
                                                        VStack(spacing: 0) {
                                                            Text("\(value.premiumCategoryName) - \(value.premiumCustomText)")
                                                                .modifier(TextModifier())
                                                                .background(Color.white)
                                                            
                                                            Divider()
                                                                .frame(width: 189, height: 1)
                                                                .background(Color.gray.opacity(0.3))
                                                        }
                                                        .frame(width: 189)
                                                        
                                                        VStack(spacing: 0) {
                                                            Text(value.sAmount)
                                                                .modifier(TextModifier())
                                                                .background(Color.gray.opacity(0.3))
                                                            
                                                            Divider()
                                                                .frame(width: 100, height: 2)
                                                                .background(Color.white)
                                                        }
                                                        .frame(width: 100)
                                                    }
                                                    .padding(.leading, 10)
                                                    .padding(.trailing, 10)
                                                    
                                                   
                                                    
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            
                            ForEach(quotationList, id:\.sTaxPremium) { quotation in
                                
                                if quotationSelectedProduct == quotation.productID {
                                    ForEach(quotation.getAllByQuotationBreakage, id:\.productBreakageID) { value in
                                        if value.premiumCustomText == "Total" {
                                            HStack {
                                                Text(value.premiumCustomText)
                                                    .bold()
                                                    .font(isFontMedium(size: 22))
                                                    .foregroundColor(.green)
                                                    .padding(.leading)
                                                
                                                Spacer()
                                                
                                                Text(value.sAmount)
                                                    .bold()
                                                    .font(isFontBold(size: 21))
                                                    .padding(.trailing)
                                            }
                                            .frame(width:340, height:50)
                                            .background(Color.gray.opacity(0.3))
                                            .cornerRadius(5)
                                        }
                                    }
                                }
                            }
                            
                        }
                        .padding(.bottom,10)
                        
                    }
                }
                .frame(width:350)
                .fixedSize(horizontal: false, vertical: true)
                .cornerRadius(8)
                
            }
            
            if showBlackSheet {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showBlackSheet = false
                    }
            }
        }
        
    }
    
    func fetchQuotation() {
        isLoading = true
        let url = URL(string: "\(BaseURL)api/digital/core/PremiumLogic/GetPremium")!
        print(url)
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        
        let authToken:String! = "Bearer " + Extensions.token
        
        request.addValue(authToken, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("6130", forHTTPHeaderField: "orgAppID")
        
        
        print(authToken as Any)
        
        var parameters: [String: Any] = [
            
            "productIDs": Array(selectedProductIds),
            "quotationSearchID": productQuotationSearchId,
            "quotationRefID": productQuotationRefId
//            "quotationSearchID": "a5f4289e-8c0b-4555-be77-11dc8aed6d85",
//            "quotationRefID": "5d2867e8-6d10-4b33-a7df-b1cb328416d3"
        ]
        
        parameters.merge(textAnswersParameters) { (_, new) in new }
        parameters.merge(selectedAddonAnswers) { (_, new) in new}
        
        print("view json-\(parameters)")
        
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
                print("Quotation Response = \(String(describing: resultDictionary))")
                
                let decoder = JSONDecoder()
                let quotationResponse = try decoder.decode(QuotationSearchResponse.self, from: data)
                
                DispatchQueue.main.async {
                    
                    if quotationResponse.rcode == 200 {
                        print(quotationResponse.rcode)
                        quotationList = quotationResponse.rObj.getAllQuotationSearchProduct
                        isLoading = false
                        
                    } else {
                        self.alertItem = AlertItem(title: Text(quotationResponse.rmsg.first?.errorText ?? ""))
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

//#Preview {
//    QuotationPage()
//}


struct TextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(isFontMedium(size: 18))
            .modifier(EquallySized())
    }
}

struct EquallySized: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
                .frame(maxHeight: .infinity)
                .frame(height: .infinity)
                .background(GeometryReader { proxy in
                    Color.clear.preference(key: HeightPreferenceKey.self, value: proxy.size.height)
                })
                .onPreferenceChange(HeightPreferenceKey.self) { height in
                    content.frame(height: height)
                }
            Spacer()
        }
    }
}

struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}




