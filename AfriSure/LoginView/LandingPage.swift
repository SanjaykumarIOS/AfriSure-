

import SwiftUI


struct CarouselItem: Identifiable {
    let id = UUID()
    let imageName: String
    let caption: String
    let text: String
}

struct LandingPage: View {
    let items: [CarouselItem] = [
        CarouselItem(imageName: "Car", caption: "Secure Your Drive",text: "Experience Peace of Mind on Every Journey"),
        CarouselItem(imageName: "Redcar", caption: "Effortless Protection",text: "Seamless Quotes, Swift Protection"),
        CarouselItem(imageName: "MenandWomen", caption: "24/7 Support, Always Covered",text: "Reliable Support for Every Bump in the Road"),
        CarouselItem(imageName: "AfrisureLogo", caption: "Afrisure",text: "Tailored Policies, Hassle-Free Claims")
       
    ]

    @State private var selectedTab = 0
    
    @State private var navigateLoginPage = false

    var body: some View {
        NavigationStack {
            VStack {
                
                Button(action:{
                    withAnimation {
                        navigateLoginPage = true
                    }
                })
                {
                    Text("Skip >")
                        .bold()
                        .font(isFontMedium(size: 20))
                        .foregroundColor(inkBlueColour)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing)
                        .padding(.top)
                }
                
//                NavigationLink("",destination: LoginPage(),isActive: $navigateLoginPage)
                
                TabView(selection: $selectedTab) {
                    ForEach(items.indices, id: \.self) { index in
                        VStack {
                            Image(items[index].imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 350,height: 350)
                                .padding(.bottom)
                                .padding(.top,10)
                            
                            
                            Divider()
                                .frame(width: 330,height: 2)
                            
                            Text(items[index].caption)
                                .bold()
                                .font(isFontBlack(size: 25))
                                .foregroundColor(.black.opacity(0.7))
                                .padding(.top,30)
                            
                            Text(items[index].text)
                                .bold()
                                .font(isFontMedium(size: 18))
                                .foregroundColor(.black.opacity(0.7))
                                .padding(.top,30)
                            
                            
                            
                            
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                HStack {
                    Button(action: {
                        withAnimation {
                            if selectedTab > 0 {
                                selectedTab -= 1
                            }
                        }
                    }) {
                        Text("<< Previous")
                            .font(isFontMedium(size: 18))
                            .foregroundColor(selectedTab != 0 ? fontOrangeColour : .clear)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                        
                    }
                    .disabled(selectedTab == 0)
                    
                    ImageSliderIndicator(numberOfPages: items.count, selectedTab: $selectedTab)
                        .padding()
                        .padding(.leading)
                    
                    
                    Button(action: {
                        withAnimation {
                            if selectedTab < items.count - 1 {
                                selectedTab += 1
                            } else {
                                withAnimation {
                                    navigateLoginPage = true
                                }
                            }
                        }
                    }) {
                        Text("Next >>")
                            .font(isFontMedium(size: 18))
                            .foregroundColor(fontOrangeColour)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                    }
                    
//                    NavigationLink("",destination: LoginPage(),isActive: $navigateLoginPage)
                    
                    
                }
                .padding(10)
                
            }
        }
        .overlay(
            navigateLoginPage ? LoginPage() : nil
        )
        
       
    }
}


struct ImageSliderIndicator: View {
    let numberOfPages: Int
    @Binding var selectedTab: Int

    var body: some View {
        HStack {
            ForEach(0..<numberOfPages) { index in
                Circle()
                    .frame(width:15, height:15)
                    .foregroundColor(index == selectedTab ? fontOrangeColour : .gray.opacity(0.6))
            }
        }
    }
}




