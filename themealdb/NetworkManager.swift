//
//  NetworkManager.swift
//  themealdb
//
//  Created by Phil Wright on 4/25/22.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let mealsListURL = "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    private let mealsDetailListURL = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
    
    func fetchListOfMeals(completion: @escaping ([MealList]) -> Void)  {
        
        let session = URLSession.shared
        
        if let url = URL(string: mealsListURL) {
            let task = session.dataTask(with: url, completionHandler: { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                } else if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        
                        if let jsonString = String(data: data, encoding: .utf8) {
                            let jsonData = Data(jsonString.utf8)
                            let meals = try decoder.decode(MealListContainer.self, from: jsonData)
                            completion(meals.meals)
                        }
                    } catch {
                        print("Error during JSON serialization: \(error.localizedDescription)")
                        let emptyMealsList = [MealList]()
                        completion(emptyMealsList)
                    }
                }
            })
            task.resume()
        }
    }
}
