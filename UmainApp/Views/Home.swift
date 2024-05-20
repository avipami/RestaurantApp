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
            VStack {
                FilterView(viewModel: viewModel)
                List(viewModel.restaurants) { restaurant in
//                    NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)) {
//                        RestaurantRowView(restaurant: restaurant)
//                    }
                }
                .navigationTitle("Restaurants")
            }
        }
    }
}

#Preview {
    Home()
}
struct FilterView: View {
    @ObservedObject var viewModel: RestaurantViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.filters) { filter in
                    FilterItemView(filter: filter, isSelected: viewModel.selectedFilters.contains(filter.id))
                        .onTapGesture {
                            viewModel.toggleFilter(filter)
                        }
                }
            }
        }
    }
}

struct FilterItemView: View {
    let filter: Filter
    let isSelected: Bool
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: filter.image_url)) { image in
                image.resizable()
                    .frame(width: 50, height: 50)
            } placeholder: {
                ProgressView()
            }
            Text(filter.name)
        }
        .padding()
        .background(isSelected ? Color.blue : Color.gray)
        .cornerRadius(8)
    }
}

struct RestaurantRowView: View {
    let restaurant: Restaurant
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: restaurant.imageURL)) { image in
                image.resizable()
                    .frame(width: 50, height: 50)
            } placeholder: {
                ProgressView()
            }
            VStack(alignment: .leading) {
                Text(restaurant.name)
                    .font(.headline)
                Text("Rating: \(restaurant.rating)")
                Text("Delivery Time: \(restaurant.deliveryTimeMinutes) min")
            }
        }
    }
}

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
