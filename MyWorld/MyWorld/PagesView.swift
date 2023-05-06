//
//  PagesView.swift
//  MyWorld
//
//  Created by pc on 06/05/2023.
//

import SwiftUI

struct PagesView: View {
    
    @Binding var showMenu: Bool
    @Binding var menuEnumState: MenuEnum
    
    // Offset
    @State var offset: CGFloat = 0
    
    var body: some View {
        ZStack {
            // two background Cards...
            
            Color.white
                .opacity(0.4)
                .cornerRadius(showMenu ? 15 : 0)
                .shadow(color: Color.black.opacity(0.07), radius: 5, x: -5, y: 0)
                .offset(x: showMenu ? -20 : 0)
                .padding(.vertical, 60)
            
            Color.white
                .opacity(0.70)
                .cornerRadius(showMenu ? 15 : 0)
                .shadow(color: Color.black.opacity(0.07), radius: 5, x: -5, y: 0)
                .offset(x: showMenu ? -10 : 0)
                .padding(.vertical, 30)
            
            
            
            
            PageView(menuEnumState: $menuEnumState)
                .cornerRadius(showMenu ? 15 : 0)
                .rotation3DEffect(showMenu ? .init(degrees: -0.35 * 90) : .init(degrees: 0 * 90)
                                  , axis: (x: 0, y: 1, z: 0)
                                  , anchor: .leading, anchorZ: 0, perspective: 0.9)
                
        }
        // scaling and moving the view
        .scaleEffect(showMenu ? 0.84 : 1)
        .offset(x: showMenu ? getRect().width - 235 : 0)
        .ignoresSafeArea(.all)
    }
}
