//
//  NetworkManager.swift
//  UmainApp
//
//  Created by Vincent Palma on 2024-05-15.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchRestaurants(completion: @escaping (Result<[Restaurant], Error>) -> Void) {
        let url = URL(string: "https://food-delivery.umain.io/api/v1/restaurants")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "dataNilError", code: -100001, userInfo: nil)))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(RestaurantResponse.self, from: data)
                completion(.success(response.restaurants))
            } catch {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw JSON Data : \(jsonString)")
                }
                completion(.failure(error))
                
            }
        }.resume()
    }
    
    enum NetworkError: Error {
        case invalidURL
        case invalidResponse
        case noData
        case error
        case decodeError
    }
    
    func fetchFilters(filterID: String, completion: @escaping (Result<Filter, Error>) -> Void) {
        let urlString = "https://food-delivery.umain.io/api/v1/filter/\(filterID)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(NetworkError.error))
                return
            }
            
            guard let responseData = data else {
                print("No data received")
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let filter = try decoder.decode(Filter.self, from: responseData)
                completion(.success(filter))
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                completion(.failure(NetworkError.decodeError))
            }
        }
        
        task.resume()
    }

    
        
        
        
        
        
        
        

    
//    func fetchRestaurantOpenStatus(restaurantId: String, completion: @escaping (Result<OpenStatus, Error>) -> Void) {
//        let url = URL(string: "https://food-delivery.umain.io/api/v1/open/\(restaurantId)")!
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            guard let data = data else {
//                completion(.failure(NSError(domain: "dataNilError", code: -100001, userInfo: nil)))
//                return
//            }
//            
//            do {
//                let response = try JSONDecoder().decode(OpenStatus.self, from: data)
//                completion(.success(response))
//            } catch {
//                completion(.failure(error))
//            }
//        }.resume()
//    }
}


struct API {
    static let baseURL = "https://food-delivery.umain.io/api/v1"
    
    static func restaurantsURL() -> URL? {
        return URL(string: "\(baseURL)/restaurants")
    }
    
    static func filtersURL() -> URL? {
        return URL(string: "\(baseURL)/filters")
    }
    
    static func openStatusURL(for restaurantId: String) -> URL? {
        return URL(string: "\(baseURL)/open/\(restaurantId)")
    }
}
