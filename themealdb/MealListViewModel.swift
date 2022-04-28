//
//  MealViewModel.swift
//  themealdb
//
//  Created by Phil Wright on 4/27/22.
//

import UIKit

class MealViewModel {
    
    // MARK: Properties
    private let apiClient: APIClient
    private var meals: [Meal]
    
    var totalMealsCount: Int {
        return self.meals.count
    }
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
        self.meals = [Meal]()
        self.loadData()
    }
    
    func loadData() {
        apiClient.fetchListOfMeals(completion: { [weak self] mealsArray in
            self?.meals = mealsArray
        })
    }
    
    func mealAtIndex(_ index: Int) -> Meal? {
        if totalMealsCount < index {
            return meals[index]
        }
        return nil
    }
}
