//
//  HomePageView.swift
//  FirebaseLogin
//
//  Created by Mavis II on 9/3/19.
//  Copyright © 2019 Bala. All rights reserved.
//

import SwiftUI

struct HomePageView: View {
    var body: some View {
        
        
        VStack{
            
            
            AppTitleView(Title: "Home")
            
            Spacer()
            
            Text("Hello World!")
            
            Spacer()
            
            }.edgesIgnoringSafeArea(.top).background(Color.white)
      
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
