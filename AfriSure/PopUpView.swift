//
//  PopUpView.swift
//  SwiftUINews
//
//  Created by Chee Ket Yung on 12/12/2020.
//

import SwiftUI

struct PopUpView : View {
  
    @State private var showPopUp = false
  
    @State private var selectedChoice = ""
    
    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    var body: some View {
     
        ZStack {
       
            mainView()
            
            if $showPopUp.wrappedValue {
                
                popUpView()
                
            }
        
        }
    }
        
    private func mainView() -> some View {
        
        
        VStack (spacing : 20) {
            
            Text("Click the button below to show choices of fruits")
            
            Button(action: {
                
                withAnimation(.linear(duration: 1)) {
                    
                    self.showPopUp = true
                    
                }
                
                }, label: {
                Text("Show")
            })
            
            

        }.padding()
    }
    
    
    private let choices = ["Apple", "Orange", "Papaya", "Grape", "Star Fruit", "Strawberries", "Raspberries", "Blueberries"].sorted()
  
    
    private func popUpView() -> some View {
        
        
        VStack (spacing : 10) {
            
            Text("Choices Of Fruits").font(Font.custom("Avenir-Black", size: 18.0))

            List(choices, id:\.self) {
                
                Text($0).onTapGesture {
                    
                
                }
                
            }
    
            Button(action: {
                
                withAnimation {
          
                    self.showPopUp = false
                    
                }
            }, label: {
                Text("Close")
            })
    
        }
        
        .padding()
        .frame(width: 240, height: 300)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 20 )
       
    }
}
