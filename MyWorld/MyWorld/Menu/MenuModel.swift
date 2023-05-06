//
//  MenuModels.swift
//  MyWorld
//
//  Created by pc on 06/05/2023.
//

import Foundation
import SwiftUI

enum MenuEnum: String, Equatable, CaseIterable {
    case HarryPotter = "Harry Potter"
    
    func getIcon() -> String {
        switch self {
        case .HarryPotter:
            return "house"
        }
    }
    
    @ViewBuilder
    func getView() -> some View {
        switch self {
        case .HarryPotter:
           HarryPotterView()
        }
    }
}
