//
//  RestaurantViewModel.swift
//  UmainApp
//
//  Created by Vincent Palma on 2024-05-16.
//

import Foundation
import Combine

class RestaurantViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = [] {
        didSet {
            fetchFilters()
        }
    }
    @Published var filters: [Filter] = []
    @Published var selectedFilters: Set<String> = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchRestaurants()
    }
    
    func fetchRestaurants() {
        print("Fetching restaurants...")
        
        NetworkManager.shared.fetchRestaurants { [weak self] result in
            switch result {
            case .success(let restaurants):
                DispatchQueue.main.async {
                    print("Restaurants fetched successfully:", restaurants)
                    self?.restaurants = restaurants
                }
                
            case .failure(let error):
                print("Failed to fetch restaurants: \(error)")
            }
        }
    }
    
    func fetchFilters() {
        print("Fetching filters...")
        if restaurants.isEmpty {
            print("Restaurants empty")
            return
        }
        let ids: [String] = restaurants.flatMap { $0.filterIDS }
        ids.forEach { id in
            NetworkManager.shared.fetchFilters(filterID: id) { result in
                switch result {
                case .success (let filter):
                    DispatchQueue.main.async {
                        print("Filters fetched successfully:", filter)
                        self.filters.append(filter)
                    }
                case .failure(let error):
                    print("Failed to fetch filters: \(error)")
                }
            }
        }
    }
    
    func toggleFilter(_ filter: Filter) {
        if selectedFilters.contains(filter.id) {
            selectedFilters.remove(filter.id)
        } else {
            selectedFilters.insert(filter.id)
        }
        applyFilters()
    }
    
    private func applyFilters() {
        
    }
}
