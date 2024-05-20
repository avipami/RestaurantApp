//
//  ButtonViewModel.swift
//  UmainApp
//
//  Created by Vincent Palma on 2024-05-20.
//

import Foundation
class ButtonViewModel: ObservableObject {
    
    let buttonHeight: CGFloat = 48
    let buttonWidth: CGFloat = 144
    let cornerRadius: CGFloat = 29
    
    @Published var isSelected: Bool = false
    
}
