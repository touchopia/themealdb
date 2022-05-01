//
//  themealdbTests.swift
//  themealdbTests
//
//  Created by Phil Wright on 4/25/22.
//

import XCTest
@testable import themealdb

class MealAPITests: XCTestCase {

    func test_init_fetchMealsList() {
        
        let apiClent = APIClient()
        let viewModel = MealListViewModel(apiClient: apiClent)
        
        var meals = [Meal]()
        
        viewModel.loadMealsList { mealsArray in meals = mealsArray }
        
        // Assert that the asynchronous task worked.
        XCTAssertTrue(meals.count > 0)
    }
    
}
