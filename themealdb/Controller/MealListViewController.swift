//
//  ViewController.swift
//  themealdb
//
//  Created by Phil Wright on 4/25/22.
//

import UIKit

class MealListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(MealTableViewCell.self,
                           forCellReuseIdentifier: MealTableViewCell.reuseIdentifier)
        loadData()
    }
    
    func loadData() {
        NetworkManager.shared.fetchListOfMeals { mealsArray in
            for m in mealsArray {
                print("\(m.idMeal): \(m.strMeal): \(m.strMealThumb)")
            }
        }
    }
}

extension MealListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}

extension MealListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MealTableViewCell.reuseIdentifier, for: indexPath) as? MealTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
}

