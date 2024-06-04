//
//  Home.swift
//  UmainApp
//
//  Created by Vincent Palma on 2024-05-15.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var restaurantVM : RestaurantViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 22) {
            Image("Umain")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 54)
                .padding(.leading, 16)
                .onTapGesture {
                    
                    restaurantVM.fetchRestaurants()
                }
            
            FilterView()
            RestaurantListView()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(RestaurantViewModel())
            .environmentObject(GraphicsModel())
    }
}



