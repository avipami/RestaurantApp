//
//  OpenModel.swift
//  UmainApp
//
//  Created by Vincent Palma on 2024-05-16.
//

import Foundation

struct OpenStatus: Codable {
    let restaurantId: String
    let isOpen: Bool
    
    enum CodingKeys: String, CodingKey {
        case restaurantId = "restaurant_id"
        case isOpen = "is_currently_open"
    }
}
