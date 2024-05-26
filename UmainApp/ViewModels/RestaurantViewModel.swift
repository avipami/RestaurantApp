//
//  RestaurantViewModel.swift
//  UmainApp
//
//  Created by Vincent Palma on 2024-05-16.
//

import Foundation

class RestaurantViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = [] {
        didSet {
            fetchFilters()
        }
    }
    @Published var selectedRestaurant: Restaurant?
    @Published var filteredRestaurants: [Restaurant] = []
    @Published var filters: [Filter] = []
    @Published var selectedFilters: Set<String> = []
    @Published var buttonActive: Bool = false
    @Published var isRestaurantOpen: Bool = false
    
    func fetchRestaurants() {
        NetworkManager.shared.fetchFromApi { [weak self] result in
            switch result {
            case .success(let restaurants):
                DispatchQueue.main.async {
                    //print("Restaurants fetched successfully:", restaurants)
                    self?.restaurants = restaurants
                }
            case .failure(let error): break
                //print("Failed to fetch restaurants: \(error)")
            }
        }
    }
    
    func fetchFilters() {
        let filterIDs = Set(restaurants.flatMap { $0.filterIDS })
        
        let fetchGroup = DispatchGroup()
        var fetchedFilters: [Filter] = []
        
        filterIDs.forEach { filterID in
            fetchGroup.enter()
            NetworkManager.shared.fetchFilters(filterID: filterID) { result in
                switch result {
                case .success(let filter):
                    fetchedFilters.append(filter)
                case .failure(let error): break
                    //print("Error fetching filter: \(error)")
                }
                fetchGroup.leave()
            }
        }
        
        fetchGroup.notify(queue: .main) {
            fetchedFilters.sort { $0.name < $1.name } // To not make it randomly sorted
            self.filters = fetchedFilters
        }
    }
    
    
    func fetchRestaurantIfOpen(restaurantId: String)  {
        
        NetworkManager.shared.fetchOpenStatusFromAPI(restaurantId: restaurantId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let openStatus):
                    self.isRestaurantOpen = openStatus.isOpen
                    
                case .failure(let error):
                    //print("Failed to fetch open status: \(error.localizedDescription)")
                    self.isRestaurantOpen = false
                }
            }
        }
    }
    
    func sortRestaurantByFilter() {
        if selectedFilters.isEmpty {
            filteredRestaurants = restaurants
        } else {
            filteredRestaurants = restaurants.filter { restaurant in
                selectedFilters.isSubset(of: Set(restaurant.filterIDS))
            }
        }
    }
    
    func getFilterDescription(for restaurant: Restaurant) -> String {
        let filterNames = restaurant.filterIDS.compactMap { filterID in
            filters.first(where: { $0.id == filterID })?.name
        }
        return filterNames.joined(separator: " • ")
        
    }
    
    func toggleFilter(_ filter: Filter) {
        if selectedFilters.contains(filter.id) {
            selectedFilters.remove(filter.id)
        } else {
            selectedFilters.insert(filter.id)
        }
        buttonActive = !selectedFilters.isEmpty
        sortRestaurantByFilter()
    }
}
