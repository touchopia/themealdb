//
//  DataManager.swift
//  themealdb
//
//  Created by Phil Wright on 5/1/22.
//

import Foundation

final class DataManager {
    
    private let shared = DataManager()
    private init() {}
    
    let apiClient = MealAPIClient()
    
    public var meals = [Meal]()
    
    // MARK: - Meals API
    
    func fetchMealsList() {
        
        apiClient.fetchListOfMeals(completion: { [weak self] result in
            switch result {
            case .success(let meals):
                // Sort meals alphabetically
                self?.meals = meals.sorted { $0.strMeal < $1.strMeal }
                self?.fetchMeals()
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        })
    }
    
    func fetchMeals() {
        guard meals.isEmpty == false else { return }
        
        for (index, meal) in meals.enumerated() {
            
            apiClient.fetchMeal(idString: meal.idMeal) { result in
                switch(result) {
                case .success(let meal):
                    print("\(index)")
                    self.meals[index] = meal
                case .failure(let error):
                    print("\(error.localizedDescription)")
                }
            }
        }
    }
}
