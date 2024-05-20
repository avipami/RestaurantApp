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
    var body: some Scene {
        WindowGroup {
            Home()
                .environmentObject(graphicsModel)
        }
    }
}
