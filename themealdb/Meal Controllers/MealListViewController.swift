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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    var meals: [Meal] = [Meal]()
    
    var currentMeal: Meal?
    
    var viewModel: MealListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Meals"
        
        setupTableView()
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMealDetail" {
            let viewController = segue.destination as? MealDetailViewController
            
            let apiClient = APIClient()
            let mealViewModel = MealViewModel(apiClient: apiClient)
            mealViewModel.delegate = viewController
            viewController?.viewModel = mealViewModel
            viewController?.idString = currentMeal?.idMeal
        }
    }
    
    func configure(with viewModel: MealListViewModel) {
        self.viewModel = viewModel
        self.viewModel?.delegate = self
    }
    
    // MARK - Setup TableView
    func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "MealTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MealTableViewCell")
    }
    
    func loadData() {
        viewModel?.loadMealsList(completion: { [weak self] mealsArray in
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
        return 144
    }
    
}

extension MealListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell", for: indexPath) as? MealTableViewCell {
            
            let apiClient = APIClient()
            let mealViewModel = MealViewModel(apiClient: apiClient)
            mealViewModel.meal = meals[indexPath.row]
            cell.configure(viewModel: mealViewModel)
            return cell
        }
        return UITableViewCell()
    }
}

// notifications from the view model
extension MealListViewController: ViewModelDelegate {
    
    func willLoadData() {
        activityIndicator.startAnimating()
    }
    
    func didLoadData() {
        // reloads tableView data from model.taskNames
        tableView.reloadData()
        activityIndicator.stopAnimating()
    }
    
    func didLoadDataWithError(error: Error) {
        activityIndicator.stopAnimating()
        alertErrorWithMessage(message: error.localizedDescription)
    }
    
    func alertErrorWithMessage(message: String) {
        let alert = UIAlertController(title: "Internet Error",
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Try Again",
                                      style: UIAlertAction.Style.destructive,
                                      handler: { [weak self] action in
                self?.loadData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

