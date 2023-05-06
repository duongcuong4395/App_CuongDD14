//
//  MainView.swift
//  MyWorld
//
//  Created by pc on 06/05/2023.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        Button(action: {
            authViewModel.signOut()
        }, label: {
            Text("Sign out")
        })
        
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
