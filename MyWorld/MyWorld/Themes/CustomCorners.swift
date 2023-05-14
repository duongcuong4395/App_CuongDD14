//
//  CustomCorners.swift
//  MyWorld
//
//  Created by pc on 06/05/2023.
//

import SwiftUI


// Custom corner Shapes
struct CustomCorners: Shape {
    
    var coners: UIRectCorner
    var radius: CGFloat
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: coners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
