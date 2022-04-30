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

        self.bootstrap()
    }
    
    // Delegate initializer
    // Can do tableView datasource setup if needed
    func bootstrap() {}
    
    // MARK: - Initializer
    
    func loadMeal(idString: String, completion: @escaping (Meal) -> Void)  {
        
        delegate?.willLoadData()
        
       // func fetchMeal(idString: String, completion: @escaping (Result<Meal, Error>) -> Void)
        
        apiClient.fetchMeal(idString: idString, completion: { [weak self] result in
            switch result {
            case .success(let meal):
                completion(meal)
                
                // Must call delegate on main thread
                DispatchQueue.main.async {
                    self?.delegate?.didLoadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                
                // Must call on main thread
                DispatchQueue.main.async {
                    self?.delegate?.didLoadDataWithError(error: error)
                }
            }
        })
    }
}
