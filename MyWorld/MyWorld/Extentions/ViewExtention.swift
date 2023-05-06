//
//  ViewExtention.swift
//  MyWorld
//
//  Created by pc on 06/05/2023.
//

import SwiftUI


// extending view to get screen size
extension View {
    func getRect() -> CGRect{
        return UIScreen.main.bounds
    }
}
