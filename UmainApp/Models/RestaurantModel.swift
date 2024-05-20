//
//  RestaurantModel.swift
//  UmainApp
//
//  Created by Vincent Palma on 2024-05-16.
//

import Foundation

struct RestaurantResponse: Codable {
    let restaurants: [Restaurant]
}

struct Restaurant: Identifiable, Codable {
    let id: String
    let filterIDS: [String]
    let deliveryTimeMinutes: Int
    let rating: Double
    let name: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case filterIDS = "filterIds"
        case deliveryTimeMinutes = "delivery_time_minutes"
        case rating, name
        case imageURL = "image_url"
    }
}


