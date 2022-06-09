//
//  NetworkManager.swift
//  themealdb
//
//  Created by Phil Wright on 4/25/22.
//

import Foundation

enum LoadingState {
    case idle
    case loading
    case error
    case completed
}

final class MealAPIClient: HTTPClient {
    
    let endPoints = EndPoints()
    var session = URLSession.shared
    var loadingStatus: LoadingState = .idle
    
    public func get(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        
        loadingStatus = .loading
        
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(error))
                self?.loadingStatus = .idle
            } else if let data = data {
                completion(.success(data))
                self?.loadingStatus = .idle
            }
        }
        task.resume()
    }
    
    func fetchListOfMeals(completion: @escaping (Result<[Meal], Error>) -> Void)  {
        
        if let url = endPoints.categoryURL() {
            get(from: url) { result in
                switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    
                    do {
                        if let jsonString = String(data: data, encoding: .utf8) {
                            let jsonData = Data(jsonString.utf8)
                            let meals = try decoder.decode(MealsContainer.self, from: jsonData)
                            completion(.success(meals.meals))
                        }
                    } catch let parseError {
                        completion(.failure(parseError))
                        print("JSON Error \(parseError.localizedDescription)")
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }
    }
    
    func fetchMeal(idString: String, completion: @escaping (Result<Meal, Error>) -> Void)  {
        
        if let url = endPoints.mealURL(idString: idString) {
            get(from: url) { result in
                switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    do {
                        if let jsonString = String(data: data, encoding: .utf8) {
                            let jsonData = Data(jsonString.utf8)
                            let meals = try decoder.decode(MealsContainer.self, from: jsonData)
                            if let meal = meals.meals.first {
                                completion(.success(meal))
                            }
                        }
                    } catch let parseError {
                        print("JSON Error \(parseError.localizedDescription)")
                        completion(.failure(parseError))
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }
    }
}
