//
//  MenuTabView.swift
//  MyWorld
//
//  Created by pc on 06/05/2023.
//

import SwiftUI

struct MenuTabView: View {
    @Binding var menuEnumState: MenuEnum
    @Binding var showMenu: Bool
    // Animation nameSpace
    @Namespace var animation
    
    var body: some View {
    
        ScrollView(.vertical, showsIndicators: false) {
            // tab button
            VStack(alignment: .leading, spacing: 5) {
                
                ForEach(MenuEnum.allCases, id: \.self) { tab in
                    TabButtonView(image: tab.getIcon(), title: tab.rawValue, menuEnumState: $menuEnumState, animation: animation, showMenu: $showMenu)
                }
            }
            
        }
        .padding(.leading, -15)
        .padding(.top, 10)
        .padding(.bottom, 30)
        
    }
}
