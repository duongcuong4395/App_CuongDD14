//
//  ContentView.swift
//  MyWorld
//
//  Created by pc on 06/05/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        switch authViewModel.state {
            case .signedIn: MainView()
            case .signedOut: AuthView()
        }
    }
}
