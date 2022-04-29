//
//  ViewController.swift
//  themealdb
//
//  Created by Phil Wright on 4/25/22.
//

import UIKit

class MealListViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var meals: [Meal] = [Meal]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var currentMeal: Meal?
    
    var viewModel: MealViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Meals"
        
        setupTableView()
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMealDetail" {
            let vc = segue.destination as? MealDetailViewController
            vc?.meal = currentMeal
        }
    }
    
    // MARK - Setup TableView
    func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "MealTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MealTableViewCell")
    }
    
    func loadData() {
        let apiClient = APIClient()
        apiClient.fetchListOfMeals(completion: { [weak self] mealsArray in
            self?.meals = mealsArray
        })
    }
}

extension MealListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentMeal = meals[indexPath.row]
        performSegue(withIdentifier: "showMealDetail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension MealListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell", for: indexPath) as? MealTableViewCell {
            cell.configure(meal: meals[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

