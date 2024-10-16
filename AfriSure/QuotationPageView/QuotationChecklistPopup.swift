


import SwiftUI

struct QuotationChecklistPopup: View {
    
    @Binding var showViewCheckList: Bool
    
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
                            showViewCheckList = false
                        }
                    
                    Spacer()
                    
                    Text("Check List")
                        .foregroundColor(.white)
                        .font(isFontMedium(size: 20))
                        .padding(.trailing)
                    
                    Spacer()
                }
                .frame(width:320,height:50)
                .background(fontOrangeColour)
                
                ScrollView {
                    VStack {
                        ForEach(quotationArrayList.indices, id: \.self) { quotationvalue in
                            let quotation = quotationArrayList[quotationvalue]
                            
                            ForEach(quotation.quotationProduct, id: \.quoationSearchProductID) { quotationProduct in
                                if let quotationDetails = quotationProduct.quotationDetails {
                                    ForEach(quotationDetails, id: \.sTotalPremium) { quotationDetail in
                                        
                                        if let checkList = quotationDetail.checklist {
                                            ForEach(Array(checkList.enumerated()), id: \.element.checklistID) { index, value in
                                                
                                                if quotationSelectedProduct == quotationDetail.productUniqueID {
                                                    
                                                    HStack(alignment: .top) {
                                                        Text("\(index + 1). \(value.checklist)")
                                                            .font(isFontMedium(size: 16))
                                                            .foregroundColor(.black)
                                                            .padding(.leading)
                                                        
                                                        Spacer()
                                                        
                                                    }
                                                    .padding(5)
                                                }
                                            }
                                        }
                                        
                                    }
                                }
                            }
                        }
                        
                    }
                    
                }
                .frame(maxHeight:350)
            }
            
        }
        .frame(width:320)
        .fixedSize(horizontal: false, vertical: true)
        .cornerRadius(8)
        
        
    }
}


