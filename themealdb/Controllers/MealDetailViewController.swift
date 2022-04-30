//
//  MealDetailViewController.swift
//  themealdb
//
//  Created by Phil Wright on 4/28/22.
//

import UIKit

class MealDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: MealViewModel?
    
    var meal: Meal?
    
    var idString: String?
    
    var hasFullMeal: Bool = false

    // MARK: -
    func configure(with viewModel: MealViewModel) {
        self.viewModel = viewModel
        self.viewModel?.delegate = self
    }
    
    // MARK: - View Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        loadMeal()
    }
    
    func loadMeal() {
        guard let idString = idString else {
            print("cant load meal")
            return
        }
        
        viewModel?.loadMeal(idString: idString, completion: { [weak self] theMeal in
            self?.meal = theMeal
        })
    }
    
    func updateUI() {
        if let meal = meal {
            titleLabel.text = meal.strMeal
            imageView.loadImageFromURL(urlString: meal.strMealThumb)
        } else {
            
            // Empty State
            activityIndicator.stopAnimating()
            
        }
    }
}

// notifications from the view model
extension MealDetailViewController: ViewModelDelegate {
    
    func willLoadData() {
        activityIndicator.startAnimating()
    }
    
    func didLoadData() {
        activityIndicator.stopAnimating()
        updateUI()
    }
    
    func didLoadDataWithError(error: Error) {
        activityIndicator.stopAnimating()
        print("\(error.localizedDescription)")
    }
}
