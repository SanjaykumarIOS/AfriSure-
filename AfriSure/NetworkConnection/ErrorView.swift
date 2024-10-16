import SwiftUI
import Network
import Foundation

struct ErrorView: View {
    @State private var selectedNavigationLink: String? = nil
    
    @State private var alertItem: AlertItem?
    
    @StateObject var networkMonitor = NetworkMonitor()

    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading, spacing: 20) {
                VStack {
                    Spacer()
                    
                    // Your error illustration
                    Image("no_internet")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                    
                    
                    Text("Check your internet connection, then refresh the page")
                        .font(.headline)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button(action: {
                        // Your refresh action here
                        
                        if !networkMonitor.isConnected {
                            self.alertItem = AlertItem(title: Text("Please check your internet connection and try again!"))
                        }
                    }) {
                        Text("REFRESH")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40) // You can specify a fixed height if you want
                            .padding()
                            .background(toolbarcolor)
                            .cornerRadius(10)
                    }
                    .padding()
                    Spacer()
                }
                .padding()
                
                
                // ALERT VIEW
                .alert(item: $alertItem) { alertItem in
                    Alert(title: alertItem.title)
                }
                
                //  TOOL BAR
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        
                        HStack {
                            
                            Button(action: {
//                                self.selectedNavigationLink = "DashboardPage"
                                
                            })
                            {
                                
                                Image(systemName: "arrow.backward")
                                    .bold()
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .padding(.bottom)
                                
                            }
                            
                            
                            Text("Products Screen")
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
                
            }.navigationBarBackButtonHidden(true)
            
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
