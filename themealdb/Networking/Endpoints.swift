//
//  Endpoints.swift
//  themealdb
//
//  Created by Phil Wright on 4/29/22.
//

import Foundation

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
