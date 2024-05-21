//
//  Home.swift
//  UmainApp
//
//  Created by Vincent Palma on 2024-05-15.
//

import SwiftUI

struct Home: View {
    @StateObject var viewModel = RestaurantViewModel()
    @State private var showDetailView = false
    @State private var selectedRestaurant: Restaurant?
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 22) {
            Image("Umain")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 54)
                .padding(.leading, 16)
            
            FilterView()
            
            ScrollView {
                ForEach(viewModel.buttonActive ? viewModel.filteredRestaurants : viewModel.restaurants, id: \.id) { restaurant in
                    
                    Button(action: {
                        selectedRestaurant = restaurant
                        
                        showDetailView.toggle()
                        
                    }) {
                        RestaurantCardView(restaurant: restaurant)
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0.0, y: 4)
                    }
                    .padding(.bottom, 16)
                }
            }
        }
        .fullScreenCover(item: $selectedRestaurant ,content: { restaurant in
            
                RestaurantDetailView(showDetailView: $showDetailView, restaurant: restaurant)
            
        })
        .environmentObject(viewModel)
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        let graphicsModel = GraphicsModel()
        Home()
            .environmentObject(graphicsModel)
    }
}
