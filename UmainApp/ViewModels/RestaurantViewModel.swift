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
    @Published var filteredRestaurants: [Restaurant] = []
    @Published var filters: [Filter] = []
    @Published var selectedFilter: String? = nil 
    @Published var buttonActive: Bool = false
    
    
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
        let filterIDs = Set(restaurants.flatMap { $0.filterIDS })
        
        let fetchGroup = DispatchGroup()
        var fetchedFilters: [Filter] = []
        
        filterIDs.forEach { filterID in
            fetchGroup.enter()
            fetchFilter(filterID: filterID) { result in
                switch result {
                case .success(let filter):
                    fetchedFilters.append(filter)
                case .failure(let error):
                    print("Error fetching filter: \(error)")
                }
                fetchGroup.leave()
            }
        }
        
        fetchGroup.notify(queue: .main) {
            self.filters = fetchedFilters
        }
    }
    
    func sortRestaurantByFilter()  {
        guard let selectedFilter = selectedFilter else { return }
        
        filteredRestaurants = restaurants.filter { restaurant in
            restaurant.filterIDS.contains(selectedFilter)
        }
    }
    
    func fetchFilter(filterID: String, completion: @escaping (Result<Filter, Error>) -> Void) {
        let urlString = "https://food-delivery.umain.io/api/v1/filter/\(filterID)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let responseData = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let filter = try decoder.decode(Filter.self, from: responseData)
                completion(.success(filter))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func toggleFilter(_ filter: Filter) {
        if selectedFilter == filter.id {
            buttonActive = false
            selectedFilter = nil
        } else {
            selectedFilter = filter.id
            buttonActive = true
            sortRestaurantByFilter()
            print("Selected filter", selectedFilter)
        }
    }
}
