

import SwiftUI

struct QuotationBreakdownPopup: View {
    @Binding var showQuotationBreakage: Bool
    
    var body: some View {
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
                    
                    Text("Quotation Break-Down")
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
                            
                            ForEach(quotationArrayList.indices, id: \.self) { quotationvalue in
                                let quotation = quotationArrayList[quotationvalue]
                                
                                ForEach(quotation.quotationProduct, id: \.quoationSearchProductID) { quotationProduct in
                                    if let quotationDetails = quotationProduct.quotationDetails {
                                        ForEach(quotationDetails, id: \.sTotalPremium) { quotationDetail in
                                            
                                            if let breakdowns = quotationDetail.breakdown {
                                                ForEach(Array(breakdowns.enumerated()), id: \.element.productBreakdownID) { index, value in
                                                    
                                                    if quotationSelectedProduct == quotationDetail.productUniqueID {
                                                        
                                                        VStack {
                                                            HStack(spacing: 0) {
                                                                VStack(alignment: .leading, spacing: 0) {
                                                                    Text("\(index + 1)")
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
                                }
                            }
                        }
                    }
                    
                    ForEach(quotationArrayList.indices, id: \.self) { quotationvalue in
                        let quotation = quotationArrayList[quotationvalue]
                        
                        ForEach(quotation.quotationProduct, id: \.quoationSearchProductID) { quotationProduct in
                            if let quotationDetails = quotationProduct.quotationDetails {
                                ForEach(quotationDetails, id: \.sTotalPremium) { quotationDetail in
                                    if quotationSelectedProduct == quotationDetail.productUniqueID {
                                        ZStack {
                                            Color.gray.opacity(0.3)
                                            HStack {
                                                Text("Total")
                                                    .bold()
                                                    .font(isFontMedium(size: 22))
                                                    .foregroundColor(inkBlueColour)
                                                    .padding(.leading)
                                                
                                                Spacer()
                                                
                                                Text(quotationDetail.sTotalPremium ?? "")
                                                    .bold()
                                                    .font(isFontBold(size: 21))
                                                    .padding(.trailing)
                                                
                                            }
                                        }
                                        .frame(width: 340, height: 50)
                                        .cornerRadius(5)
                                        
                                    }
                                }
                            }
                        }
                    }
                    
                    
                }
                .padding(.bottom,10)
                
            }
        }
        .frame(width:350,height:400)
        .cornerRadius(8)

    }
}
