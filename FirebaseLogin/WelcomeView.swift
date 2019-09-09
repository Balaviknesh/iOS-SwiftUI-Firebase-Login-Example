//
//  WelcomeView.swift
//  FirebaseLogin
//
//  Created by Mavis II on 9/2/19.
//  Copyright © 2019 Bala. All rights reserved.
//

import SwiftUI

public var screenWidth: CGFloat {
     return UIScreen.main.bounds.width
 }
 
 public var screenHeight: CGFloat {
     return UIScreen.main.bounds.height
 }

struct WelcomeView: View {
    
    
    @State var signUpIsPresent: Bool = false
    @State var signInIsPresent: Bool = false
    @State var selection: Int? = nil
    @State var viewState = CGSize(width: screenWidth, height: 0)
    @State var MainviewState = CGSize.zero

    var body: some View {

        ZStack{
    
            VStack {
                
             
                AppTitleView(Title: "Welcome")

                          Spacer()

                          VStack(spacing:20) {

                              
                              Button(action: {
                             
                                self.signUpIsPresent = true
                                
                              }) {
                                
                              Text("Sign Up")
                                
                              }.sheet(isPresented: self.$signUpIsPresent) {
                                  
                                SignUpView()
                                
                              }
                              
                              Button(action: {
                                
                                self.signInIsPresent = true
                             
                              })
                              {
                                
                              Text("Sign In")
                                
                              }.sheet(isPresented: $signInIsPresent) {
                                
                                SignInView(onDismiss:{
                                    
                                    self.status()
                                    
                                })
                                
                              }
                            
                          }
          
                          Spacer()
                
                }.edgesIgnoringSafeArea(.top).edgesIgnoringSafeArea(.bottom).offset(y: self.MainviewState.height).animation(.spring())

                HomePageView().offset(x: self.viewState.width)
                    .animation(.interactiveSpring())
                

           
        }
            
    
    }

    
    
func status(){
    
    self.viewState = CGSize(width: 0, height: 0)
    self.MainviewState = CGSize(width: 0, height: screenHeight)
    
    
}}





struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

