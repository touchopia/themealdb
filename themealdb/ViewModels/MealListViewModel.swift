//
//  MealViewModel.swift
//  themealdb
//
//  Created by Phil Wright on 4/27/22.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func willLoadData()
    func didLoadData()
    func didLoadDataWithError(error: Error)
}

protocol ViewModelType {
    func bootstrap()
    var delegate: ViewModelDelegate? { get set }
}

class MealListViewModel: ViewModelType {

    // MARK: - Properties
    
    private let apiClient: APIClient
    weak var delegate: ViewModelDelegate?
    //private var dataSource: UsersDataSource!
    
    public var meals: [Meal]
    
    // MARK: - Initializer
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
        self.meals = [Meal]()
        self.bootstrap()
    }
    
    // Delegate initializer
    func bootstrap() {
        print("Hello Bootstrap!")
        
    }
    
    // MARK: - Initializer
    
    func loadMealsList(completion: @escaping ([Meal]) -> Void)  {
        
        delegate?.willLoadData()
        
        apiClient.fetchListOfMeals(completion: { [weak self] result in
            switch result {
            case .success(let meals):
                
                // Sort meals alphabetically
                
                self?.meals = meals.sorted {
                    $0.strMeal < $1.strMeal
                }
                completion(meals)
                
                // Must call delegate on main thread
                DispatchQueue.main.async {
                    self?.delegate?.didLoadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                let emptyArray = [Meal]()
                completion(emptyArray)
                
                // Must call on main thread
                DispatchQueue.main.async {
                    self?.delegate?.didLoadDataWithError(error: error)
                }
            }
        })
    }
}
