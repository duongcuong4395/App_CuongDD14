//
//  MenuView.swift
//  MyWorld
//
//  Created by pc on 06/05/2023.
//

import SwiftUI

struct MenuView: View {
    
    @Binding var menuEnumState: MenuEnum
    @Binding var showMenu: Bool
    // Animation nameSpace
    @Namespace var animation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 5) {

                
                //padding top for top close button
                    //.padding(.top, 10)
                VStack(alignment: .leading, spacing: 5) {
                    Text("Dang Duong Cuong")
                        .font(.system(size: 17))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    Text("App version 1.0.0")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Button(action: {
                        // action log out
                    }, label: {
                        Text("Log out")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    })
                }
            }
            
            MenuTabView(menuEnumState: $menuEnumState, showMenu: $showMenu, animation: _animation)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}
