//
//  MealViewModel.swift
//  themealdb
//
//  Created by Phil Wright on 4/30/22.
//

import Foundation

class MealViewModel: ViewModelType {
    weak var delegate: ViewModelDelegate?
    var meal: Meal?
}
