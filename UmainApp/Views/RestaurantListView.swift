//
//  RestaurantListView.swift
//  UmainApp
//
//  Created by Vincent Palma on 2024-05-24.
//

import SwiftUI

struct RestaurantListView: View {
    
    @EnvironmentObject var restaurantVM: RestaurantViewModel
    @State private var showDetailView = false
    
    var body: some View {
        
        ScrollView {
            ForEach(restaurantVM.buttonActive ? restaurantVM.filteredRestaurants : restaurantVM.restaurants, 
                    id: \.id) { restaurant in
                
                Button(action: {
                    restaurantVM.selectedRestaurant = restaurant
                    showDetailView.toggle()
                    
                }) {
                    
                    RestaurantCardView(restaurant: restaurant)
                        .shadow(color: .black.opacity(0.05), radius: 4, x: 0.0, y: 4)
                        .padding(.bottom, 20)
                }
                .padding(.bottom, 16)
            }
            .padding(.top, 16)
        }
        .onAppear {
            print("Fetching restaurants")
            restaurantVM.fetchRestaurants()
        }
        
        .fullScreenCover(
            isPresented: $showDetailView,
            onDismiss: {
                restaurantVM.selectedRestaurant = nil
            },
            content: {
                if let selectedRestaurant = restaurantVM.selectedRestaurant {
                    RestaurantDetailView(
                        showDetailView: $showDetailView,
                        restaurant: selectedRestaurant
                    )
                }
            }
        )
    }
}

struct RestaurantListView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListView()
            .environmentObject(RestaurantViewModel())
            .environmentObject(GraphicsModel())
    }
}
