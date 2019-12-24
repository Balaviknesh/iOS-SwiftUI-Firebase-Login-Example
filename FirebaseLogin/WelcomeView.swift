//
//  WelcomeView.swift
//  FirebaseLogin
//
//  Created by Mavis II on 9/2/19.
//  Copyright © 2019 Bala. All rights reserved.
//

import SwiftUI
import Firebase

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
       @State var viewState = CGSize.zero
       @State var MainviewState =  CGSize.zero
       
       var body: some View {
        
        ZStack{
            
           if Auth.auth().currentUser != nil {
                            
             VStack{
                        
                     AppTitleView(Title: "Home")
                     Spacer()
                     Text("Hello World!")
                     Spacer()

                     Button(action: {
                       let firebaseAuth = Auth.auth()
                       do {
                         try firebaseAuth.signOut()
                      
                       } catch let signOutError as NSError {
                         print ("Error signing out: %@", signOutError)
                       }
                         
                        self.MainviewState = CGSize(width: screenWidth, height: 0)
                        self.viewState = CGSize(width: 0, height: 0)
                         
                     }, label: {
                         Text("Sign Out")
                             .foregroundColor(Color.white)
                             .padding()
                     })
                         .background(Color.green)
                         .cornerRadius(5)
                                    
                     }.edgesIgnoringSafeArea(.top).background(Color.white)
                      .offset(x: self.MainviewState.width).animation(.spring())

            }
            
           else {
            
            VStack {
                              
                           
                        AppTitleView(Title: "Welcome")
                        Spacer()
                        VStack(spacing:20) {
                            
                            Button(action: {self.signUpIsPresent = true}){
                                Text("Sign Up")
                                  
                            }.sheet(isPresented: self.$signUpIsPresent){
                                    
                                  SignUpView()
                                  
                            }
                                
                            Button(action: {self.signInIsPresent = true}){
                                  
                                Text("Sign In")
                                  
                            }.sheet(isPresented: $signInIsPresent) {
                                  
                                  SignInView(onDismiss:{
                                      
                                  self.viewState = CGSize(width: screenWidth, height: 0)
                                  self.MainviewState = CGSize(width: 0, height: 0)
                                      
                                  })}}
                        Spacer()
                              
                }.edgesIgnoringSafeArea(.top).edgesIgnoringSafeArea(.bottom)
                .offset(x:self.viewState.width).animation(.spring())
            }

        }
       
   }
    
}



struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

