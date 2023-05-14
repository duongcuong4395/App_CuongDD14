//
//  MainView.swift
//  MyWorld
//
//  Created by pc on 06/05/2023.
//

import SwiftUI
import Kingfisher

struct MainView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            Button(action: {
                authViewModel.signOut()
            }, label: {
                Text("Sign out")
            })
            
            Text(authViewModel.userLogin.email ?? "")
            KFImage(authViewModel.userLogin.photoURL)
                .resizable()
                .scaledToFit()
                .frame(width: 68, height: 68)
                .padding([.bottom, .trailing], 4)
        }
        .onAppear{
            authViewModel.getUserLogin()
        }
        
        
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
