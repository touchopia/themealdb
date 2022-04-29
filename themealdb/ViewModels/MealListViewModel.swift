//
//  MealViewModel.swift
//  themealdb
//
//  Created by Phil Wright on 4/27/22.
//

import UIKit

class MealViewModel {
    
    // MARK: - Properties
    
    private let apiClient: APIClient
    
    private var meals: [Meal]
    
    // MARK: - Initializer
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
        self.meals = [Meal]()
        self.loadMealsList()
    }
    
    // MARK: - Initializer
    
    func loadMealsList() {
        
        apiClient.fetchListOfMeals(completion: { [weak self] result in
            switch result {
            case .success(let meals):
                self?.meals = meals
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
