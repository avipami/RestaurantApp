//
//  RestaurantViewModel.swift
//  UmainApp
//
//  Created by Vincent Palma on 2024-05-16.
//

import Foundation
import Combine

class RestaurantViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    @Published var filters: [Filter] = []
    @Published var selectedFilters: Set<String> = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchRestaurants()
//        fetchFilters()
    }
    
    func fetchRestaurants() {
        NetworkManager.shared.fetchRestaurants { [weak self] result in
            switch result {
            case .success(let restaurants):
                DispatchQueue.main.async {
                    self?.restaurants = restaurants
                }
            case .failure(let error):
                print("Failed to fetch restaurants: \(error)")
            }
        }
    }
    
//    func fetchFilters() {
//        NetworkManager.shared.fetchFilters { [weak self] result in
//            switch result {
//            case .success(let filters):
//                DispatchQueue.main.async {
//                    self?.filters = filters
//                }
//            case .failure(let error):
//                print("Failed to fetch filters: \(error)")
//            }
//        }
//    }
    
    func toggleFilter(_ filter: Filter) {
        if selectedFilters.contains(filter.id) {
            selectedFilters.remove(filter.id)
        } else {
            selectedFilters.insert(filter.id)
        }
        applyFilters()
    }
    
    private func applyFilters() {
        if selectedFilters.isEmpty {
            fetchRestaurants()
        } else {
            NetworkManager.shared.fetchRestaurants { [weak self] result in
                switch result {
                case .success(let restaurants):
                    DispatchQueue.main.async {
                    }
                case .failure(let error):
                    print("Failed to fetch restaurants: \(error)")
                }
            }
        }
    }
}
