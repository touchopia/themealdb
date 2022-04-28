//
//  NetworkManager.swift
//  themealdb
//
//  Created by Phil Wright on 4/25/22.
//

import Foundation

enum LoadingStatus {
    case loading
    case error
    case completed
    case paused
}

enum APIError: Error {
    case failedToGetData
}

struct EndPoints {
    
    let categoryURLString = "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    let mealURLString = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
    
    func mealURL(idString: String) -> URL? {
        if let url = URL(string: "\(mealURLString)\(idString)") {
            return url
        }
        return nil
    }
    
    func categoryURL() -> URL? {
        if let url = URL(string: categoryURLString) {
            return url
        }
        return nil
    }
}

public protocol HTTPClient {
    var session: URLSession { get }
    func get(from url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

class APIClient: HTTPClient {
    
    let endPoints = EndPoints()
    var session = URLSession.shared
    var loadingStatus = LoadingStatus.paused
    
    public func get(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
    
    func fetchListOfMeals(completion: @escaping ([Meal]) -> Void)  {
        
        if let url = endPoints.categoryURL() {
            get(from: url) { result in
                switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    
                    do {
                        if let jsonString = String(data: data, encoding: .utf8) {
                            
                            //print(jsonString)
                            
                            let jsonData = Data(jsonString.utf8)
                            let meals = try decoder.decode(MealsContainer.self, from: jsonData)
                            print("Total Meals: \(meals.meals.count)")
                            completion(meals.meals)
                        }
                    } catch let parseError {
                        print("JSON Error \(parseError.localizedDescription)")
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    let emptyMealsList = [Meal]()
                    completion(emptyMealsList)
                }
            }
        }
    }
    
    func fetchMeal(idString: String, completion: @escaping (Meal) -> Void)  {
        
        if let url = endPoints.mealURL(idString: idString) {
            get(from: url) { result in
                switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    
                    print(idString)
                    
                    do {
                        if let jsonString = String(data: data, encoding: .utf8) {
                            
                            //print(jsonString)
                            
                            let jsonData = Data(jsonString.utf8)
                            let meals = try decoder.decode(MealsContainer.self, from: jsonData)
                            if let meal = meals.meals.first {
                                completion(meal)
                            }
                        }
                    } catch let parseError {
                        print("JSON Error \(parseError.localizedDescription)")
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
