//
//  PageView.swift
//  MyWorld
//
//  Created by pc on 06/05/2023.
//

import SwiftUI

struct PageView: View {
    @Binding var menuEnumState: MenuEnum
    
    @State private var home = UUID()
    @State private var courses = UUID()
    @State private var tappedTwice: Bool = false
    
    init(menuEnumState: Binding<MenuEnum>) {
        self._menuEnumState = menuEnumState
        // hiding tabbar
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        // tab view with tabs
        TabView(selection: $menuEnumState) {
            ForEach(MenuEnum.allCases, id: \.self) { tab in
                tab.getView()
                    .onChange(of: tappedTwice, perform: { tappedTwice in
                        guard tappedTwice else { return }
                        home = UUID()
                        self.tappedTwice = false
                    }).tag(tab.rawValue)
            }
        }.statusBar(hidden: true)
            .navigationBarHidden(true)
        
    }
}
