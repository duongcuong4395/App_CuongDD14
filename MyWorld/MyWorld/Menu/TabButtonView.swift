//
//  TabButtonView.swift
//  MyWorld
//
//  Created by pc on 06/05/2023.
//

import SwiftUI

struct TabButtonView: View {
    var image: String
    var title: String
    
    // selected tab
    @Binding var menuEnumState: MenuEnum
    // For hero animation slide
    var animation: Namespace.ID
    @Binding var showMenu: Bool
    var body: some View {
        Button {
            withAnimation(.spring()) {
                menuEnumState = MenuEnum(rawValue: title) ?? .HarryPotter
            }
        } label: {
            HStack(spacing: 15) {
                Image(systemName: image)
                    .font(.title2)
                    .frame(width: 30)
                Text(title)
                    .fontWeight(.semibold)
                    .font(.caption)
            }
            .foregroundColor(menuEnumState.rawValue == title ? Color("background") : .white)
            .padding(.vertical, 7)
            .padding(.horizontal, 10)
            // max frame..
            .frame(maxWidth: getRect().width - 230, alignment: .leading)
            .background(
                // Hero animation
                ZStack {
                    if menuEnumState.rawValue == title {
                        Color.white
                            .opacity(menuEnumState.rawValue == title ? 1 : 0)
                            .clipShape(CustomCorners(coners: [.topRight, .bottomRight], radius: 12))
                    }
                }
            )
        }

    }
}
