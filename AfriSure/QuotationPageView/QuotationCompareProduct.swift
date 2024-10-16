

import SwiftUI

var uniqueTitles = Set<String>()

struct QuotationCompareProduct: View {
    
    @Binding var selectedIndices: Set<String>
    
    @Binding var navigateProposalForm: Bool
    
    @Binding var navigateCompareProduct: Bool
    var body: some View {
        NavigationStack {
            
            VStack {

                if selectedIndices.count >= 2,
                   
                  
                    let firstSelectedIndex = quotationArrayList.firstIndex(where: { quotation in
                        quotation.quotationProduct.contains { quotationProduct in
                            quotationProduct.quotationDetails?.contains { quotationDetail in
                                selectedIndices.contains(quotationDetail.productUniqueID)
                            } ?? false
                        }
                    }),
                    let secondSelectedIndex = quotationArrayList.firstIndex(where: { quotation in
                        quotation.quotationProduct.contains { quotationProduct in
                            quotationProduct.quotationDetails?.contains { quotationDetail in
                                quotationDetail.productUniqueID != quotationArrayList[firstSelectedIndex].quotationProduct.first?.quotationDetails?.first?.productUniqueID &&
                                selectedIndices.contains(quotationDetail.productUniqueID)
                            } ?? false
                        }
                    }) {
                    
                    let firstSelectedProduct = quotationArrayList[firstSelectedIndex]
                    let secondSelectedProduct = quotationArrayList[secondSelectedIndex]
                    
                    // Filter the quotation details for the first selected product
                    let firstSelectedDetails = firstSelectedProduct.quotationProduct.flatMap { $0.quotationDetails ?? [] }.filter { quotationDetail in
                        selectedIndices.contains(quotationDetail.productUniqueID)
                    }
                    
                    // Filter the quotation details for the second selected product
                    let firstSelectedProductDetailsIDs = quotationArrayList[firstSelectedIndex].quotationProduct.flatMap { $0.quotationDetails ?? [] }.map { $0.productUniqueID }
                    let secondSelectedDetails = secondSelectedProduct.quotationProduct
                        .flatMap { $0.quotationDetails ?? [] }
                        .filter { quotationDetail in
                            !firstSelectedProductDetailsIDs.contains(quotationDetail.productUniqueID) &&
                            selectedIndices.contains(quotationDetail.productUniqueID)
                        }
                    
                    HStack {
                        
                        ForEach(firstSelectedDetails.indices, id: \.self) { index in
                            VStack(spacing: 10) {
                                Image("CompareProductLogo")
                                    .resizable()
                                    .frame(width: 100, height: 110)
                                
                                Text(firstSelectedDetails[index].products.productName)
                                    .font(isFontMedium(size: 14))
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                                
                                Text(firstSelectedDetails[index].sTotalPremium ?? "")
                                    .font(isFontMedium(size: 16))
                                    .foregroundColor(inkBlueColour)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                            }
                            .frame(width: 180)
                            
                            VStack {
                                if index != firstSelectedDetails.count - 1 {
                                    DottedLineVertical()
                                        .frame(width: 1,height: 200)
                                        .foregroundColor(.black)
                                }
                            }
                            .frame(width: 1)
                        }

                       
                    }
                    
                    
                    ScrollView {
                        
                        VStack {
                                                        
                            ForEach(Array(uniqueTitles), id: \.self) { title in
                                Text(title)
                                    .font(isFontMedium(size: 17))
                                    .foregroundColor(inkBlueColour)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment:.leading)
                                    .padding(.leading)
                                    .frame(width: 400, height: 50)
                                    .background(Color(.secondarySystemBackground))
                                
                                HStack(alignment:.top) {
                                    ForEach(firstSelectedProduct.productCompare ?? [], id: \.productID) { value in
                                        if selectedIndices.contains(value.productID ?? "") {
                                            if let benefits = value.mainBenefits {
                                                ForEach(benefits.indices, id: \.self) { index in
                                                    let benefit = benefits[index]
                                                    if benefit.pZBenefitTitle == title {
                                                        Text(benefit.marketingStatement1 ?? "---")
                                                            .font(isFontMedium(size: 16))
                                                            .multilineTextAlignment(.center)
                                                            .padding(3)
                                                            .frame(width: 180)
                                                        
//                                                        if index != benefits.count - 1 {
                                                            DottedLineVertical()
                                                                .frame(width: 1)
                                                                .foregroundColor(.black)
//                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }


                             
                        }
                        
                    }
                    
                    
                    HStack {
                        
                        ForEach(firstSelectedDetails.indices, id: \.self) { index in
                            
                            Button(action:{
                                withAnimation {
                                    navigateProposalForm = true
                                    navigateCompareProduct = false
                                }
                                
                                Extensions.quotationDetailRefID = firstSelectedDetails[index].quotationDetailRefID
                                                                
                                selectedIndices.removeAll()
                                uniqueTitles = Set<String>()
                            })
                            {
                                Text("PROCEED TO BUY")
                                    .bold()
                                    .font(isFontMedium(size: 17))
                                    .foregroundColor(.white)
                                    .frame(width:180,height:45)
                                    .background(fontOrangeColour)
                                    .cornerRadius(8)
                            }
                        }
                        
                    }
                    .padding(1)
                  
                    
                    
                }

            }
            
            
            //  TOOL BAR
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    HStack {
                        Button(action: {
                            
                            withAnimation {
                                navigateCompareProduct = false
                                selectedIndices.removeAll()
                                uniqueTitles = Set<String>()
                            }
                            
                        })
                        {
                            
                            Image(systemName: "arrow.backward")
                                .bold()
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .padding(.bottom)
                            
                        }
                        
                        Text("Compare products")
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
}

struct QuotationCompareProduct_Previews: PreviewProvider {
    static var previews: some View {
        QuotationPage(navigateQuotationPage: .constant(false))
    }
}


struct DottedLineVertical: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let pattern: [CGFloat] = [4,4] // Customize the pattern as per your requirement
        
        let start = rect.origin
        let end = CGPoint(x: rect.origin.x, y: rect.maxY)
        
        path.move(to: start)
        path.addLine(to: end)
        path = path.strokedPath(StrokeStyle(lineWidth: 1, dash: pattern))
        
        return path
    }
}




