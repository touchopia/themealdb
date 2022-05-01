//
//  MealViewModel.swift
//  themealdb
//
//  Created by Phil Wright on 4/30/22.
//

import Foundation

class MealViewModel: ViewModelType {

    // MARK: - Properties
    
    private let apiClient: APIClient
    weak var delegate: ViewModelDelegate?
    var meal: Meal?
    
    // MARK: - Initializer
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    // MARK: - Initializer
    
    func loadMeal(idString: String, completion: @escaping (Meal) -> Void)  {
        
        delegate?.willLoadData()
        
        apiClient.fetchMeal(idString: idString, completion: { [weak self] result in
            switch result {
            case .success(let meal):
                completion(meal)
                
                // Must call delegate on main thread
                DispatchQueue.main.async {
                    self?.delegate?.didLoadData()
                }
            case .failure(let error):
                // Must call on main thread
                DispatchQueue.main.async {
                    self?.delegate?.didLoadDataWithError(error: error)
                }
            }
        })
    }
}
