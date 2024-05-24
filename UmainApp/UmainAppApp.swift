//
//  UmainAppApp.swift
//  UmainApp
//
//  Created by Vincent Palma on 2024-05-15.
//

import SwiftUI

@main
struct UmainAppApp: App {
    @StateObject private var graphicsModel = GraphicsModel()
    @StateObject var restaurantVM = RestaurantViewModel()
    var nwManager = NetworkManager.shared
    var body: some Scene {
        WindowGroup {
            Home()
                .environmentObject(graphicsModel)
                .environmentObject(restaurantVM)
        }
    }
}
