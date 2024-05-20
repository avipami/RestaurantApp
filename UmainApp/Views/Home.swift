//
//  Home.swift
//  UmainApp
//
//  Created by Vincent Palma on 2024-05-15.
//

import SwiftUI

struct Home: View {
    @StateObject var viewModel = RestaurantViewModel()
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading, spacing: 22) {
                Image("Umain")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 54)
                    .padding(.leading, 16)
                    
                FilterView()
                
            ScrollView {
    
                    ForEach(viewModel.restaurants, id: \.id) { restaurant in
                        NavigationLink(destination: RestaurantCardView(restaurant: restaurant)) {
                            RestaurantCardView(restaurant: restaurant)
                                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.1), radius: 4, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 4)
                                
                        }
                        .padding(.top, 30)
                    }.padding(.top, 10)
                }
            }
        }
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

//struct RestaurantRowView: View {
//    let restaurant: Restaurant
//    
//    var body: some View {
//        HStack {
//            AsyncImage(url: URL(string: restaurant.imageURL)) { image in
//                image.resizable()
//                    .frame(width: 50, height: 50)
//            } placeholder: {
//                ProgressView()
//            }
//            VStack(alignment: .leading) {
//                Text(restaurant.name)
//                    .font(.headline)
//                Text("Rating: \(restaurant.rating)")
//                Text("Delivery Time: \(restaurant.deliveryTimeMinutes) min")
//            }
//        }
//    }
//}

//struct RestaurantDetailView: View {
//    let restaurant: Restaurant
//    @State private var isOpen: Bool = false
//    
//    var body: some View {
//        VStack {
//            AsyncImage(url: URL(string: restaurant.image_url)) { image in
//                image.resizable()
//                    .aspectRatio(contentMode: .fit)
//            } placeholder: {
//                ProgressView()
//            }
//            Text(restaurant.name)
//                .font(.largeTitle)
//            Text("Rating: \(restaurant.rating)")
//            Text("Delivery Time: \(restaurant.delivery_time_minutes) min")
//            Text(isOpen ? "Open Now" : "Closed")
//                .font(.headline)
//                .foregroundColor(isOpen ? .green : .red)
//                .padding()
//        }
//        .onAppear {
//            NetworkManager.shared.fetchRestaurantOpenStatus(restaurantId: restaurant.id) { result in
//                switch result {
//                case .success(let status):
//                    DispatchQueue.main.async {
//                        self.isOpen = status.is_currently_open
//                    }
//                case .failure(let error):
//                    print("Failed to fetch open status: \(error)")
//                }
//            }
//        }
//        .padding()
//    }
//}
