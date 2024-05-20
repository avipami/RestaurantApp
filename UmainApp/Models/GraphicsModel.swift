//
//  GraphicsModel.swift
//  UmainApp
//
//  Created by Vincent Palma on 2024-05-20.
//

import Foundation
import SwiftUI

class GraphicsModel: ObservableObject {
    
    enum AppColors : String {
        case darkText
        case lightText
        case subtitle
        case background
        case selectedButton
        case positive
        case negative
    }
    
    func useColor(for appColor: AppColors) -> Color {
        return Color(appColor.rawValue)
    }
}
