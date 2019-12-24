//
//  SignInView.swift
//  FirebaseLogin
//
//  Created by Mavis II on 9/2/19.
//  Copyright © 2019 Bala. All rights reserved.
//

import SwiftUI
import Firebase

struct actIndSignin: UIViewRepresentable {
    @Binding var shouldAnimate: Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }

    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
        if self.shouldAnimate {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}


struct SignInView: View {
    
    
    @State private var shouldAnimate = false
    
    @Environment(\.presentationMode) var presentationMode
    @State var emailAddress: String = ""
    @State var password: String = ""
    @State var verifyEmail: Bool = true
    @State private var showEmailAlert = false
    @State private var showPasswordAlert = false
    @State var errorText: String = ""
    
    var onDismiss: () -> ()
    
    var verifyEmailAlert: Alert {
           Alert(title: Text("Verify your Email ID"), message: Text("Please click the link in the verification email sent to you"), dismissButton: .default(Text("Dismiss")){
               
                    self.presentationMode.wrappedValue.dismiss()
                    self.emailAddress = ""
                    self.verifyEmail = true
                    self.password = ""
                    self.errorText = ""
           
               })
          }
    
    
    var passwordResetAlert: Alert {
              Alert(title: Text("Reset your password"), message: Text("Please click the link in the password reset email sent to you"), dismissButton: .default(Text("Dismiss")){
                  
                    self.emailAddress = ""
                    self.verifyEmail = true
                    self.password = ""
                    self.errorText = ""
              
                  })
             }
    
    
    var body: some View {
        
                    VStack {
                        
                        
                      
                            
                        AppTitleView(Title: "Sign In")

                        VStack(spacing: 10) {

                                    
                            Text("Email").font(.title).fontWeight(.thin).frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                                   

                            TextField("user@domain.com", text: $emailAddress).textContentType(.emailAddress)

                            Text("Password").font(.title).fontWeight(.thin)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                            

                            SecureField("Enter a password", text: $password)

                            Button(action: {

                                self.shouldAnimate = true
                            self.sayHelloWorld(email:self.emailAddress, password:self.password)
                                

                            }
                            ) {
                            Text("Sign In")
                            }


                            Button(action: {

                            Auth.auth().sendPasswordReset(withEmail: self.emailAddress) { error in

                            if let error = error {
                            self.errorText = error.localizedDescription
                            return
                            }

                            self.showPasswordAlert.toggle()

                            }


                            }
                            ) {
                            Text("Forgot Password")
                            }


                            Text(errorText).frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)

                            
                           actIndSignin(shouldAnimate: self.$shouldAnimate)
                                                
                                          

                            if (!verifyEmail) {

                                Button(action: {

                                    Auth.auth().currentUser?.sendEmailVerification { (error) in
                                        if let error = error {
                                        self.errorText = error.localizedDescription
                                        return
                                        }
                                    self.showEmailAlert.toggle()

                                    }
                                }) {

                                Text("Send Verify Email Again")
                                    
                                    
                                   
                                }
                                
                                

                            }


                        }.padding(10)



                    }.edgesIgnoringSafeArea(.top).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading).background(Color.white)

                    .alert(isPresented: $showEmailAlert, content: { self.verifyEmailAlert })

                    .alert(isPresented: $showPasswordAlert, content: { self.passwordResetAlert })


        
}

    
        
    func sayHelloWorld(email: String, password: String) {

        
               
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            
           


        if let error = error
            {
            self.errorText = error.localizedDescription
                self.shouldAnimate = false

            return
            }


        guard user != nil else { return }


        self.verifyEmail = user?.user.isEmailVerified ?? false


        if(!self.verifyEmail)
            {
            self.errorText = "Please verify your email"
            self.shouldAnimate = false
            return
            }

            self.emailAddress = ""
            self.verifyEmail = true
            self.password = ""
            self.errorText = ""
            self.onDismiss()
            self.presentationMode.wrappedValue.dismiss()
            self.shouldAnimate = false

        }

        
        
        
        }

    
}
    


struct SignInView_Previews: PreviewProvider {
    
    
    static var previews: some View {

        SignInView(onDismiss: {print("hi")})
        
    }
}
