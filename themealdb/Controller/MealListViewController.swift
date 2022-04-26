//
//  ViewController.swift
//  themealdb
//
//  Created by Phil Wright on 4/25/22.
//

import UIKit

class MealListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.fetchData { mealsArray in
            for m in mealsArray {
                print(m.strMeal)
                print(m.idMeal)
            }
        }
    }
}

