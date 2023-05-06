//
//  MainView.swift
//  MyWorld
//
//  Created by pc on 06/05/2023.
//

import SwiftUI

struct MainView: View {
    // selected tab
    @State private var menuEnumState: MenuEnum = .HarryPotter
    @State var showMenu = true
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: .init(colors: [Color("background"), Color.clear]),
                startPoint: .leading,
                endPoint: .trailing
            ).ignoresSafeArea()
            
            // side menu
            MenuView(menuEnumState: $menuEnumState, showMenu: $showMenu)
                
            // list page
            PagesView(showMenu: $showMenu, menuEnumState: $menuEnumState)
                //.softOuterShadow(darkShadow: .yellow, lightShadow: .offWhite, offset: 0.5, radius: 3)
        }
        .overlay(
            ZStack {
                // more option
            }
            .padding()
            ,alignment: .bottomLeading
        )
    }
}
