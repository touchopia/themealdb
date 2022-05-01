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
    
    @IBOutlet weak var columnOneStackView: UIStackView!
    @IBOutlet weak var columnTwoStackView: UIStackView!
    
    @IBOutlet var ingrediateLabels: [UILabel]!
    @IBOutlet var ingrediateLabels2: [UILabel]!
    
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
        guard let meal = meal else {
            
            // Empty State
            activityIndicator.stopAnimating()
            return
        }
       
        titleLabel.text = meal.strMeal.uppercased()
        
        imageView.alpha = 0
        
        imageView.loadImageFromURL(urlString: meal.strMealThumb)
        
        ingrediateLabels[0].text = meal.strIngredient1 ?? ""
        ingrediateLabels[1].text = meal.strIngredient2 ?? ""
        ingrediateLabels[2].text = meal.strIngredient3 ?? ""
        ingrediateLabels[3].text = meal.strIngredient4 ?? ""
        ingrediateLabels[4].text = meal.strIngredient5 ?? ""
        ingrediateLabels2[0].text = meal.strIngredient6 ?? ""
        ingrediateLabels2[1].text = meal.strIngredient7 ?? ""
        ingrediateLabels2[2].text = meal.strIngredient8 ?? ""
        ingrediateLabels2[3].text = meal.strIngredient9 ?? ""
        ingrediateLabels2[4].text = meal.strIngredient10 ?? ""
        
        // Fade in ImageView
        UIView.animate(withDuration: 0.2, delay: 0.5) {
            self.imageView.alpha = 1
        }
    }
}

// notifications from the view model
extension MealDetailViewController: ViewModelDelegate {
    
    func willLoadData() {
        activityIndicator.startAnimating()
    }
    
    func didLoadData() {
        updateUI()
    }
    
    func didLoadDataWithError(error: Error) {
        print("\(error.localizedDescription)")
    }
}
