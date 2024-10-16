



import SwiftUI



//struct QuotationsPage: View {
//    
////    @Binding var navigateQuotationPage: Bool
//    
////    @State var quotationList: [QuotationSearchResponse.QuotationSearchObject.QuotationSearchProductItem] = []
//    
//    @State var quotationArrayList: [QuotationResponse.QuotationResponseObject.QuotationSearch] = []
//    
//    @State private var selectedItems = Set<String>()
//    @State var showNextButton = false
//    
//    @State private var selectedProduct = false
//    
//    @State private var showViewCheckList = false
//    
//    @State private var showQuotationBreakage = false
//    @State private var quotationSelectedProduct = ""
//    
//    @State private var showQuotationInstallment = false
//    
//    @State private var showBlackSheet = false
//    
//    @State private var showProductPopUp = false
//    
//    @State var navigateCustomFormPage = false
//    
//    @State var navigateLineofBusiness = false
//    
//    @State var navigateProposalForm = false
//    @State private var alertItem: AlertItem?
//    @State private var isLoading = false
//    
//    @StateObject var networkMonitor = NetworkMonitor()
//    
//    
//    var body: some View {
//        NavigationStack {
//            LoadingView(isShowing: $isLoading) {
//                VStack {
//                    
//                    ZStack {
//                        
//                        HStack {
//                            
//                            Spacer()
//                            VStack(alignment: .center) {
//                                Text("Quotation ID")
//                                    .font(isFontMedium(size: 20))
//                                
//                                Text(Extensions.quotationID)
//                                    .font(isFontMedium(size: 18))
//                                    .foregroundColor(inkBlueColour)
//                                    .padding(.top,1)
//                            }
//                            .padding(.leading)
//                            
//                            Spacer()
//                            
////                            NavigationLink("",destination: InsuranceOptionView(navigateInsuranceOptiondPage: .constant(false)),isActive: $navigateLineofBusiness)
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
//                            
//                        }
//                    }
//                    .frame(width:360)
//                    .fixedSize(horizontal: false, vertical: true)
//                    .padding(.top,8)
//                    .padding(.bottom,8)
//                    .background(Color.gray.opacity(0.2))
//                    .cornerRadius(8)
//                    .padding(.top,10)
//                    
//                    HStack(alignment: .top,spacing:8) {
//                        ZStack {
//                            VStack(spacing: 5) {
//                                Text("Line of Business")
//                                    .font(isFontMedium(size: 19))
//                                
//                                Text(Extensions.selectedLineOfBusiness)
//                                    .font(isFontMedium(size: 17))
//                                    .foregroundColor(inkBlueColour)
//                                    .padding(2)
//                            }
//                        }
//                        .frame(width:175,height: Extensions.selectedItem.count == 1 ? 40 : 50,alignment: .top)
//                        .padding(.top,10)
//                        .padding(.bottom,10)
//                        .background(Color.gray.opacity(0.2))
//                        .cornerRadius(8)
//                        .padding(.leading)
//                        
//                        ZStack {
//                            VStack(spacing: 3) {
//                                
//                                Text("Products")
//                                    .font(isFontMedium(size: 19))
//                               
//                                if Extensions.selectedItem.count == 1 {
//                                    
//                                    Text(Array(Extensions.selectedItem).first!)
//                                        .font(isFontMedium(size: 17))
//                                        .foregroundColor(inkBlueColour)
//                                        .padding(2)
//                                    
//                                } else {
//                                    HStack {
//                                        
//                                        if let firstCharacter = Extensions.selectedItem.first {
//                                            Text(String(firstCharacter))
//                                                .font(isFontMedium(size: 17))
//                                                .foregroundColor(.black)
//                                                .padding(.leading, 10)
//                                                .lineLimit(1)
//                                        }
//                                        
//                                        Spacer()
//                                        
//                                        Image(systemName: "chevron.down")
//                                            .font(isFontMedium(size: 17))
//                                            .padding(.trailing,10)
//                                        
//                                    }
//                                    .frame(width: 160,height: 30)
//                                    .background(Color.white)
//                                    .cornerRadius(6)
//                                    .onTapGesture {
//                                        showProductPopUp = true
//                                    }
//                                }
//                                
//                            }
//                            
//                            
//                        }
//                        .frame(width:175,height: Extensions.selectedItem.count == 1 ? 40 : 50,alignment: .top)
//                        .padding(.top,10)
//                        .padding(.bottom,10)
//                        .background(Color.gray.opacity(0.2))
//                        .cornerRadius(8)
//                        .padding(.trailing)
//                        
//                    }
//                    
//                    ScrollView(showsIndicators: false) {
//                        VStack {
//                            
////                            ForEach(quotationArrayList, id: \.quotationID) { quotationSearch in
////                                ForEach(quotationSearch.quotationProduct, id: \.quoationSearchProductID) { quotationProduct in
////                                    ForEach(quotationProduct.quotationDetails, id: \.sTotalPremium) { quotationDetail in
////                                        Text(quotationDetail.sTotalPremium ?? "")
////                                    }
////                                }
////                            }
//
//                            
////                            ForEach(quotationArrayList, id: \.pZLOB) { quotation in
////                                
////                                VStack(spacing:0) {
////                                    ZStack {
////                                        
////                                        VStack {
////                                            VStack(spacing:0) {
////                                                VStack(spacing:0) {
////                                                    
////                                                    if let product = quotation.productCompare {
////                                                        ForEach(product, id: \.productID) { value in
////                                                            Text(value.productTitle ?? "")
////                                                                .bold()
////                                                                .font(isFontMedium(size: 20))
////                                                        }
////                                                        
////                                                    }
////                                                }
////                                                .frame(width:350,height:50)
////                                                .background(Color(.white))
////                                                
////                                                
////                                                Divider()
////                                                    .frame(width:350,height:1)
////                                                    .background(Color.secondary)
////                                                
////                                                Spacer()
////                                                
////                                            }
////                                            
////                                            
////                                            ForEach(quotation.quotationProduct, id: \.quoationSearchProductID) { quotationProduct in
////                                                ForEach(quotationProduct.quotationDetails, id: \.sTotalPremium) { quotationDetail in
////                                                    
////                                                    HStack {
////                                                        
////                                                        VStack(alignment:.leading,spacing:10) {
////                                                            
////                                                            Text("Total Premium")
////                                                                .bold()
////                                                                .font(isFontMedium(size: 20))
////                                                            
////                                                            Text(quotationDetail.sTotalPremium ?? "")
////                                                                .bold()
////                                                                .font(isFontMedium(size: 20))
////                                                                .foregroundColor(inkBlueColour)
////                                                                .fixedSize(horizontal: false, vertical: true)
////                                                        }.padding(.leading)
////                                                        
////                                                        Spacer()
////                                                        
////                                                        VStack(spacing:10) {
////                                                            
////                                                            Button(action:{
////                                                                if selectedItems.contains(quotation.pZLOB) {
////                                                                    selectedItems.remove(quotation.pZLOB)
////                                                                    showNextButton = false
////                                                                    
////                                                                    
////                                                                } else {
////                                                                    selectedItems.removeAll()
////                                                                    selectedItems.insert(quotation.pZLOB)
////                                                                    
////                                                                }
////                                                                
////                                                                showNextButton = !selectedItems.isEmpty
////                                                                
////                                                                
////                                                                
////                                                            })
////                                                            {
////                                                                Text(selectedItems.contains(quotation.pZLOB) ? "Selected" : "Select")
////                                                                    .foregroundColor(.white)
////                                                                    .font(isFontMedium(size: 19))
////                                                                    .frame(width: 120, height:45)
////                                                                    .background(selectedItems.contains(quotation.pZLOB) ? Color.gray.opacity(0.7) : fontOrangeColour)
////                                                                    .cornerRadius(8)
////                                                                    .padding(.trailing)
////                                                            }
////                                                            
////                                                            //                                                    if !quotation.checklist.isEmpty {
////                                                            Button(action:{
////                                                                showViewCheckList = true
////                                                                
////                                                                //                                                            quotationSelectedProduct = quotation.productUniqueID
////                                                            })
////                                                            {
////                                                                Text("View Checklist")
////                                                                    .underline()
////                                                                    .font(isFontMedium(size: 16))
////                                                                    .foregroundColor(inkBlueColour)
////                                                                    .padding(.trailing)
////                                                            }
////                                                            //                                                    } else {
////                                                            //                                                        Text("No Checklist Available")
////                                                            //                                                            .underline()
////                                                            //                                                            .font(isFontMedium(size: 15))
////                                                            //                                                            .foregroundColor(.gray)
////                                                            //                                                            .padding(.trailing,10)
////                                                            //                                                    }
////                                                            
////                                                            
////                                                        }
////                                                        
////                                                    }
////                                                    .padding(.bottom,10)
////                                                    
////                                                    
////                                                }
////                                            }
////                                            
////                                        }
////                                    }
////                                    .frame(width:350)
////                                    .fixedSize(horizontal: false, vertical: true)
////                                    .background(Color(.secondarySystemBackground))
////                                    .cornerRadius(15)
////                                    .shadow(radius: 2)
////                                   
////                                    
////                                    HStack {
////                                        
////                                        Text("INSTALLMENTS")
////                                            .font(isFontMedium(size: 18))
////                                            .foregroundColor(.white)
////                                            .frame(width: 150, height: 25)
////                                            .background(sykBlueColour)
////                                            .mask(RoundedCorner(radius: 10, corners: [.bottomLeft]))
////                                            .mask(RoundedCorner(radius: 10, corners: [.bottomRight]))
////                                            .onTapGesture {
////                                                //                                            if !quotation.getAllByQuotationBreakage.isEmpty {
////                                                //                                                showQuotationBreakage = true
////                                                //                                                quotationSelectedProduct = quotation.productUniqueID
////                                                //                                                print(quotationSelectedProduct)
////                                                //
////                                                //                                            } else {
////                                                //                                                showBlackSheet = true
////                                                //                                            }
////                                                
////                                                showQuotationInstallment = true
////                                            }
////                                        
////                                        Text("BREAK-DOWN")
////                                            .font(isFontMedium(size: 18))
////                                            .foregroundColor(.white)
////                                            .frame(width: 150, height: 25)
////                                            .background(sykBlueColour)
////                                            .mask(RoundedCorner(radius: 10, corners: [.bottomLeft]))
////                                            .mask(RoundedCorner(radius: 10, corners: [.bottomRight]))
////                                            .onTapGesture {
////                                                //                                            if !quotation.getAllByQuotationBreakage.isEmpty {
////                                                //                                                showQuotationBreakage = true
////                                                //                                                quotationSelectedProduct = quotation.productUniqueID
////                                                //                                                print(quotationSelectedProduct)
////                                                //
////                                                //                                            } else {
////                                                //                                                showBlackSheet = true
////                                                //                                            }
////                                                
////                                                showQuotationBreakage = true
////                                            }
////                                    }
////                                    
////                                }
////                                .padding()
////                                
////                            }
//                            
//                            
//                        }
//                        .onAppear {
//                            fetchQuotationResponse()
//                        }
//                    }
//                    
//                    VStack {
//                        
////                        NavigationLink("", destination: ProposalForms(), isActive: $navigateProposalForm)
//
//                        if showNextButton {
//                            Button(action:{
//                                withAnimation {
//                                    navigateProposalForm = true
//                                }
//                            })
//                            {
//                                Text("NEXT")
//                                    .padding(.top)
//                                    .frame(maxWidth: .infinity)
//                                    .background(fontOrangeColour)
//                                    .foregroundColor(.white)
//                                    .multilineTextAlignment(.center)
//                                    .font(isFontBold(size: 20))
//                            }
//                            
//                        }
//                    }
//                    
//                }
//                
//                .onAppear {
//                    //                    fetchGetAllProduct()
//                }
//                
//                // ALERT VIEW
//                .alert(item: $alertItem) { alertItem in
//                    Alert(title: alertItem.title)
//                }
//                
//                //  TOOL BAR
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        
//                        HStack {
//                            Button(action: {
//                                
//                                withAnimation {
////                                    navigateQuotationPage = false
//                                }
//                                
//                            })
//                            {
//                                
//                                Image(systemName: "arrow.backward")
//                                    .bold()
//                                    .font(.system(size: 20))
//                                    .foregroundColor(.white)
//                                    .padding(.bottom)
//                                
//                            }
//                            
//                            Text("Quotation")
//                                .bold()
//                                .font(isFontBlack(size: 22))
//                                .foregroundColor(.white)
//                                .padding(.bottom,8)
//                            
////                            NavigationLink("", destination: CustomForms(), isActive: $navigateCustomFormPage)
//
//                        }
//                    }
//                }
//                .toolbarBackground(toolbarcolor, for: .navigationBar)
//                .toolbarBackground(.visible, for: .navigationBar)
//                .navigationBarTitleDisplayMode(.inline)
//                
//            }
//        }.navigationBarBackButtonHidden()
//        
//            .overlay {
//                navigateProposalForm ? ProposalForms(navigateProposalForm: $navigateProposalForm) : nil
//                
//                navigateLineofBusiness ? LineOfBusinessView(navigateInsuranceOptiondPage: .constant(false)) : nil
//                
//                !networkMonitor.isConnected ? ErrorView() : nil
//            }
//        
//          
//        
////            .overlay {
////               
////                if showQuotationInstallment {
////                    Color.black.opacity(0.5)
////                        .ignoresSafeArea()
////                        .onTapGesture {
////                            showQuotationInstallment = false
////                        }
////                    ZStack {
////                        Color.white
////                        VStack {
////                            HStack {
////                                Image(systemName: "multiply")
////                                    .foregroundColor(.white)
////                                    .font(.system(size: 22))
////                                    .bold()
////                                    .padding(.leading)
////                                    .onTapGesture {
////                                        showQuotationInstallment = false
////                                    }
////                                
////                                Spacer()
////                                
////                                Text("Quotation Installments")
////                                    .foregroundColor(.white)
////                                    .font(isFontMedium(size: 20))
////                                    .padding(.trailing)
////                                
////                                Spacer()
////                            }
////                            .frame(width:350,height:50)
////                            .background(fontOrangeColour)
////                            
////                            VStack(spacing: 0) {
////                                HStack(spacing: 0) {
////                                    VStack(spacing: 0) {
////                                        
////                                        Text("S.No")
////                                            .bold()
////                                            .font(.system(size: 18))
////                                            .foregroundColor(fontOrangeColour)
////                                            .frame(width: 50, height: 30, alignment: .center)
////                                            .background(Color.gray.opacity(0.3))
////                                        
////                                        Divider()
////                                            .frame(width:50,height:2)
////                                            .background(Color.white)
////                                        
////                                    }
////                                    
////                                    VStack(spacing: 0) {
////                                        Text("Installment Period")
////                                            .bold()
////                                            .font(.system(size: 18))
////                                            .foregroundColor(fontOrangeColour)
////                                            .frame(width: 189, height: 30, alignment: .center)
////                                        
////                                        Divider()
////                                            .frame(width:189,height:1)
////                                            .background(Color.gray.opacity(0.3))
////                                    }
////                                    
////                                    VStack(spacing: 0) {
////                                        Text("Amount")
////                                            .bold()
////                                            .font(.system(size: 18))
////                                            .foregroundColor(fontOrangeColour)
////                                            .frame(width: 100, height: 30, alignment: .center)
////                                            .background(Color.gray.opacity(0.3))
////                                        
////                                        Divider()
////                                            .frame(width:100)
////                                    }
////                                }
////                                
////                                ScrollView(showsIndicators:false) {
////                                    VStack(spacing:0) {
////                                        
////                                        ForEach(quotationArrayList, id: \.quotationID) { quotationSearch in
////                                            ForEach(quotationSearch.quotationProduct, id: \.quoationSearchProductID) { quotationProduct in
////                                                ForEach(quotationProduct.quotationDetails, id: \.sTotalPremium) { quotationDetail in
////                                                                                                    ForEach(quotationDetail.installment, id: \.pZInstallmentPeriodID) { value in
//////                                                    ForEach(Array(quotationDetail.installment.enumerated()), id: \.element.pZInstallmentPeriodID) { index, value in
////                                                        
//////                                                        VStack {
//////                                                            HStack(spacing: 0) {
//////                                                                VStack(alignment: .leading, spacing: 0) {
//////                                                                    Text("\(index + 1)")
//////                                                                        .modifier(TextModifier())
//////                                                                        .background(Color.gray.opacity(0.3))
//////                                                                    
//////                                                                    Divider()
//////                                                                        .frame(width: 50, height: 2)
//////                                                                        .background(Color.white)
//////                                                                }
//////                                                                .frame(width: 50)
//////                                                                
//////                                                                VStack(spacing: 0) {
//////                                                                    Text("\(value.pZInstallmentPeriod)")
//////                                                                        .modifier(TextModifier())
//////                                                                        .background(Color.white)
//////                                                                    
//////                                                                    Divider()
//////                                                                        .frame(width: 189, height: 1)
//////                                                                        .background(Color.gray.opacity(0.3))
//////                                                                }
//////                                                                .frame(width: 189)
//////                                                                
//////                                                                VStack(spacing: 0) {
//////                                                                    Text(value.sAmount)
//////                                                                        .modifier(TextModifier())
//////                                                                        .background(Color.gray.opacity(0.3))
//////                                                                    
//////                                                                    Divider()
//////                                                                        .frame(width: 100, height: 2)
//////                                                                        .background(Color.white)
//////                                                                }
//////                                                                .frame(width: 100)
//////                                                            }
//////                                                            .padding(.leading, 10)
//////                                                            .padding(.trailing, 10)
//////                                                        }
////                                                        
////                                                        
////                                                    }
////                                                }
////                                            }
////                                        }
////                                        
////                                        
////                                    }
////                                }
////                                
////                                
////                            }
////                            .padding(.bottom,10)
////                            
////                        }
////                    }
////                    .frame(width:350)
////                    .frame(maxHeight:400)
////                    .cornerRadius(8)
////                    
////                }
////                
////            }
//        
////        .overlay {
////            
////            if showProductPopUp {
////                ZStack {
////                    Color.black.opacity(0.3)
////                        .ignoresSafeArea()
////                        .onTapGesture {
////                            showProductPopUp = false
////                        }
////                    VStack {
////                        ForEach(Array(Extensions.selectedItem), id: \.self) {
////                            
////                            Text($0)
////                                .font(isFontMedium(size: 18))
////                                .padding(8)
////                                .frame(maxWidth:.infinity,alignment:.leading)
////                                .onTapGesture {
////                                    showProductPopUp = false
////                                }
////                        }
////                    }
////                    .frame(width:350)
////                    .background(Color.white)
////                    
////                }
////            }
////            
////            if showViewCheckList {
////                Color.black.opacity(0.5)
////                    .ignoresSafeArea()
////                    .onTapGesture {
////                        showViewCheckList = false
////                    }
////                ZStack {
////                    Color.white
////                    VStack {
////                        HStack {
////                            Image(systemName: "multiply")
////                                .foregroundColor(.white)
////                                .font(.system(size: 22))
////                                .bold()
////                                .padding(.leading)
////                                .onTapGesture {
////                                    showViewCheckList = false
////                                }
////                            
////                            Spacer()
////                            
////                            Text("Check List")
////                                .foregroundColor(.white)
////                                .font(isFontMedium(size: 20))
////                            
////                            Spacer()
////                        }
////                        .frame(width:320,height:50)
////                        .background(fontOrangeColour)
////                        
////                        ScrollView {
////                            VStack {
////                                
////                                ForEach(quotationArrayList, id: \.quotationID) { quotationSearch in
////                                    ForEach(quotationSearch.quotationProduct, id: \.quoationSearchProductID) { quotationProduct in
////                                        ForEach(quotationProduct.quotationDetails, id: \.sTotalPremium) { quotationDetail in
//////                                            ForEach(quotationDetail.checklist, id: \.checklistID) { value in
////                                            ForEach(Array(quotationDetail.checklist.enumerated()), id: \.element.checklistID) { index, value in
////                                                
//////                                                VStack(spacing:10) {
////                                                    Text("\(index + 1). \(value.checklist)")
//////                                                        .font(isFontMedium(size: 16))
//////                                                        .foregroundColor(.black)
//////                                                        .frame(maxWidth:.infinity,alignment:.leading)
//////                                                        .padding(.leading)
//////                                                }
////                                                
//////                                                HStack(alignment: .top) {
//////                                                    Text(value.checklist)
//////                                                        .font(isFontMedium(size: 16))
//////                                                        .foregroundColor(.black)
//////                                                    
//////                                                    Spacer()
//////                                                    
//////                                                }
//////                                                .padding(10)
////                                                
////                                            }
////                                        }
////                                    }
////                                }
////                            }
////                            
////                            
////
////
////                        }
////                    }
////                    
////                }
////                .frame(width:320)
////                .fixedSize(horizontal: false, vertical: true)
////                .cornerRadius(8)
////                
////            }
////            
////            if showQuotationBreakage {
////                Color.black.opacity(0.5)
////                    .ignoresSafeArea()
////                    .onTapGesture {
////                        showQuotationBreakage = false
////                    }
////                ZStack {
////                    Color.white
////                    VStack {
////                        HStack {
////                            Image(systemName: "multiply")
////                                .foregroundColor(.white)
////                                .font(.system(size: 22))
////                                .bold()
////                                .padding(.leading)
////                                .onTapGesture {
////                                    showQuotationBreakage = false
////                                }
////                            
////                            Spacer()
////                            
////                            Text("Quotation Break-Down")
////                                .foregroundColor(.white)
////                                .font(isFontMedium(size: 20))
////                                .padding(.trailing)
////                            
////                            Spacer()
////                        }
////                        .frame(width:350,height:50)
////                        .background(fontOrangeColour)
////                        
////                        VStack(spacing: 0) {
////                            HStack(spacing: 0) {
////                                VStack(spacing: 0) {
////                                    
////                                    Text("S.No")
////                                        .bold()
////                                        .font(.system(size: 18))
////                                        .foregroundColor(fontOrangeColour)
////                                        .frame(width: 50, height: 30, alignment: .center)
////                                        .background(Color.gray.opacity(0.3))
////                                    
////                                    Divider()
////                                        .frame(width:50,height:2)
////                                        .background(Color.white)
////                                    
////                                }
////                                
////                                VStack(spacing: 0) {
////                                    Text("Premium Category")
////                                        .bold()
////                                        .font(.system(size: 18))
////                                        .foregroundColor(fontOrangeColour)
////                                        .frame(width: 189, height: 30, alignment: .center)
////                                    
////                                    Divider()
////                                        .frame(width:189,height:1)
////                                        .background(Color.gray.opacity(0.3))
////                                }
////                                
////                                VStack(spacing: 0) {
////                                    Text("Amount")
////                                        .bold()
////                                        .font(.system(size: 18))
////                                        .foregroundColor(fontOrangeColour)
////                                        .frame(width: 100, height: 30, alignment: .center)
////                                        .background(Color.gray.opacity(0.3))
////                                    
////                                    Divider()
////                                        .frame(width:100)
////                                }
////                            }
////                            
////                            ScrollView(showsIndicators:false) {
////                                VStack(spacing:0) {
////                                    
////                                    ForEach(quotationArrayList, id: \.quotationID) { quotationSearch in
////                                        ForEach(quotationSearch.quotationProduct, id: \.quoationSearchProductID) { quotationProduct in
////                                            ForEach(quotationProduct.quotationDetails, id: \.sTotalPremium) { quotationDetail in
////                                                ForEach(Array(quotationDetail.breakdown.enumerated()), id: \.element.productBreakdownID) { index, value in
////                                                    
////                                                    HStack(spacing: 0) {
////                                                        VStack(alignment: .leading, spacing: 0) {
////                                                            Text("\(index + 1)")
////                                                                .modifier(TextModifier())
////                                                                .background(Color.gray.opacity(0.3))
////                                                            
////                                                            Divider()
////                                                                .frame(width: 50, height: 2)
////                                                                .background(Color.white)
////                                                        }
////                                                        .frame(width: 50)
////                                                        
////                                                        VStack(spacing: 0) {
////                                                            Text("\(value.premiumCategoryName) - \(value.premiumCustomText)")
////                                                                .modifier(TextModifier())
////                                                                .background(Color.white)
////                                                            
////                                                            Divider()
////                                                                .frame(width: 189, height: 1)
////                                                                .background(Color.gray.opacity(0.3))
////                                                        }
////                                                        .frame(width: 189)
////                                                        
////                                                        VStack(spacing: 0) {
////                                                            Text(value.sAmount)
////                                                                .modifier(TextModifier())
////                                                                .background(Color.gray.opacity(0.3))
////                                                            
////                                                            Divider()
////                                                                .frame(width: 100, height: 2)
////                                                                .background(Color.white)
////                                                        }
////                                                        .frame(width: 100)
////                                                    }
////                                                    .padding(.leading, 10)
////                                                    .padding(.trailing, 10)
////
////                                                }
////                                            }
////                                        }
////                                    }
////                                }
////                            }
////                            
////                            
////                            ForEach(quotationArrayList, id: \.quotationID) { quotationSearch in
////                                ForEach(quotationSearch.quotationProduct, id: \.quoationSearchProductID) { quotationProduct in
////                                    ForEach(quotationProduct.quotationDetails, id: \.sTotalPremium) { quotationDetail in
////                                        
////                                        ZStack {
////                                            Color.gray.opacity(0.3)
////                                            HStack {
////                                                Text("Total")
////                                                    .bold()
////                                                    .font(isFontMedium(size: 22))
////                                                    .foregroundColor(inkBlueColour)
////                                                    .padding(.leading)
////                                                
////                                                Spacer()
////                                                
////                                                Text(quotationDetail.sTotalPremium ?? "")
////                                                    .bold()
////                                                    .font(isFontBold(size: 21))
////                                                    .padding(.trailing)
////                                                
////                                            }
////                                        }
////                                        .frame(width: 340, height: 50)
////                                        .cornerRadius(5)
////                                       
////                                    }
////                                }
////                            }
////                            
////
////                            
////                        }
////                        .padding(.bottom,10)
////                        
////                    }
////                }
////                .frame(width:350)
////                .frame(maxHeight:400)
////                .cornerRadius(8)
////                
////            }
////            
////
////            
////            
////            if showBlackSheet {
////                Color.black.opacity(0.5)
////                    .ignoresSafeArea()
////                    .onTapGesture {
////                        showBlackSheet = false
////                    }
////            }
////        }
//        
//       
//        
//    }
//    
//    
//    func fetchQuotationResponse() {
//        
//        isLoading = true
//        
//        let parameters: [String: Any] = [
//            
//            "quotationSearchID":  quotationSearchID
//        ]
//        
//        print("quotationSearchID \(parameters)")
//        
//        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(BaseURL)")!,
//                                         path: "api/prodconfig/Quotation/GetQuotationSearch",
//                                         method: "POST",bodyData:parameters)
//        
//        APIService.request(endpoint: dynamicEndpoint) { (result: Result<QuotationResponse, Error>) in
//            switch result {
//            case .success(let quotationResponse):
//                // Handle success
//                DispatchQueue.main.async {
//                    
//                    if quotationResponse.rcode == 200 {
//                        print(quotationResponse.rcode)
////                        quotationList = quotationResponse.rObj.getAllQuotationSearchProduct
//                        
//                        quotationArrayList = [quotationResponse.rObj.GetQuotationSearch]
//                        
//                      
//                       
//                        isLoading = false
//                        
//                    } else {
//                        self.alertItem = AlertItem(title: Text(quotationResponse.rmsg.first?.errorText ?? ""))
//                        isLoading = false
//                    }
//                    
//                }
//                
//            case .failure(let error):
//                // Handle error
//                print(error)
//                self.alertItem = AlertItem(title: Text("An unexpected error occurred"))
//                isLoading = false
//            }
//        }
//    }
//    
//    
////    func fetchQuotation() {
////        
////        isLoading = true
////        
////        var parameters: [String: Any] = [
////            
////            "productIDs": Array(selectedProductIds),
////            "quotationSearchID": productQuotationRequestID,
////            "quotationRefID": productQuotationRefId
//////            "quotationSearchID": "a5f4289e-8c0b-4555-be77-11dc8aed6d85",
//////            "quotationRefID": "5d2867e8-6d10-4b33-a7df-b1cb328416d3"
////        ]
////        
////        parameters.merge(textAnswersParameters) { (_, new) in new }
////        parameters.merge(selectedAddonAnswers) { (_, new) in new }
////
////        let dynamicEndpoint = MyEndpoint(baseURL: URL(string: "\(BaseURL)")!,
////                                         path: "api/digital/core/PremiumLogic/GetPremium",
////                                         method: "POST",bodyData:parameters)
////        
////        APIService.request(endpoint: dynamicEndpoint) { (result: Result<QuotationSearchResponse, Error>) in
////            switch result {
////            case .success(let quotationResponse):
////                // Handle success
////                DispatchQueue.main.async {
////                    
////                    if quotationResponse.rcode == 200 {
////                        print(quotationResponse.rcode)
////                        quotationList = quotationResponse.rObj.getAllQuotationSearchProduct
////                        isLoading = false
////                        
////                    } else {
////                        self.alertItem = AlertItem(title: Text(quotationResponse.rmsg.first?.errorText ?? ""))
////                        isLoading = false
////                    }
////                    
////                }
////
////            case .failure(let error):
////                // Handle error
////                print(error)
////                self.alertItem = AlertItem(title: Text("An unexpected error occurred"))
////                isLoading = false
////            }
////        }
////        
////        
//////        isLoading = true
//////        let url = URL(string: "\(BaseURL)api/digital/core/PremiumLogic/GetPremium")!
//////        print(url)
//////        let request = NSMutableURLRequest(url: url)
//////        request.httpMethod = "POST"
//////
//////        let authToken:String! = "Bearer " + Extensions.token
//////
//////        request.addValue(authToken, forHTTPHeaderField: "Authorization")
//////        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//////        request.addValue(Extensions.organisationAppID, forHTTPHeaderField: "orgAppID")
//////
//////        print(authToken as Any)
//////
//////        var parameters: [String: Any] = [
//////
//////            "productIDs": Array(selectedProductIds),
//////            "quotationSearchID": productQuotationSearchId,
//////            "quotationRefID": productQuotationRefId
////////            "quotationSearchID": "a5f4289e-8c0b-4555-be77-11dc8aed6d85",
////////            "quotationRefID": "5d2867e8-6d10-4b33-a7df-b1cb328416d3"
//////        ]
//////
//////        parameters.merge(textAnswersParameters) { (_, new) in new }
//////        parameters.merge(selectedAddonAnswers) { (_, new) in new }
//////
//////        print("view json-\(parameters)")
//////
//////        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
//////
//////        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
//////            guard let data = data else {
//////                print("\("Error No data returned from server") \(error?.localizedDescription ?? "")")
//////                self.alertItem = AlertItem(title: Text("\("Error No data returned from server") \(error?.localizedDescription ?? "")"))
//////                isLoading = false
//////                return
//////            }
//////
//////            do {
//////
//////                var resultDictionary:NSDictionary! = NSDictionary()
//////                resultDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
//////                print("Quotation Response = \(String(describing: resultDictionary))")
//////
//////                let decoder = JSONDecoder()
//////                let quotationResponse = try decoder.decode(QuotationSearchResponse.self, from: data)
//////
//////                DispatchQueue.main.async {
//////
//////                    if quotationResponse.rcode == 200 {
//////                        print(quotationResponse.rcode)
//////                        quotationList = quotationResponse.rObj.getAllQuotationSearchProduct
//////                        isLoading = false
//////
//////                    } else {
//////                        self.alertItem = AlertItem(title: Text(quotationResponse.rmsg.first?.errorText ?? ""))
//////                        isLoading = false
//////                    }
//////
//////                }
//////            } catch {
//////                print("\("Error decoding response") \(error.localizedDescription)")
//////                self.alertItem = AlertItem(title: Text("An unexpected error occurred"))
//////                isLoading = false
//////            }
//////        }
//////        task.resume()
////    }
//    
//    
//}

