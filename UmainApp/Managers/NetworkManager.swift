//
//  NetworkManager.swift
//  UmainApp
//
//  Created by Vincent Palma on 2024-05-15.
//

import Foundation

enum API {
    static let baseURL = "https://food-delivery.umain.io/api/v1"
    
    static func restaurantsURL() -> URL? {
        return URL(string: "\(baseURL)/restaurants")
    }
    
    static func filtersURL(filterId: String) -> URL? {
        return URL(string: "\(baseURL)/filter/\(filterId)")
    }
    
    static func openStatusURL(for restaurantId: String) -> URL? {
        return URL(string: "\(baseURL)/open/\(restaurantId)")
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case error(Error)
    case decodeError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    // Fetch Restaurants
    private func fetchFromApi(completion: @escaping (Result<[Restaurant], NetworkError>) -> Void) {
        guard let url = API.restaurantsURL() else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.error(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(RestaurantResponse.self, from: data)
                completion(.success(response.restaurants))
            } catch {
                if let jsonString = String(data: data, encoding: .utf8) {
                    //print("Raw JSON Data: \(jsonString)")
                }
                completion(.failure(.error(error)))
            }
        }.resume()
    }
    
    func fetchFromApi() async throws -> [Restaurant] {
        return try await withCheckedThrowingContinuation { continuation in
            fetchFromApi { result in
                switch result {
                case .success(let restaurants):
                    continuation.resume(returning: restaurants)
                    break
                case .failure(let error):
                    continuation.resume(throwing: error)
                    break
                }
            }
        }
    }
    
    // Fetch Filters
    func fetchFilters(filterID: String, completion: @escaping (Result<Filter, NetworkError>) -> Void) {
        guard let url = API.filtersURL(filterId: filterID) else {
            //print("Invalid URL")
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                //print("Error: \(error.localizedDescription)")
                completion(.failure(.error(error)))
                return
            }
            
            guard let responseData = data else {
                //print("No data received")
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let filter = try decoder.decode(Filter.self, from: responseData)
                completion(.success(filter))
            } catch {
                //print("Error decoding JSON: \(error.localizedDescription)")
                completion(.failure(.decodeError))
            }
        }.resume()
    }
    
    // Fetch Restaurant Open Status
    func fetchOpenStatusFromAPI(restaurantId: String, completion: @escaping (Result<OpenStatus, NetworkError>) -> Void) {
        guard let url = API.openStatusURL(for: restaurantId) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.error(error)))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let response = try JSONDecoder().decode(OpenStatus.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(.error(error)))
            }
        }.resume()
    }
}
