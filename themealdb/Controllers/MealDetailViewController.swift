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
    
    var meal: Meal?

    // MARK: -
    // MARK: - View Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        //self.imageView.layer.cornerRadius = 8.0
        //self.imageView.layer.masksToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let meal = meal {
            titleLabel.text = meal.strMeal
            imageView.loadImageFromURL(urlString: meal.strMealThumb)
        }
    }
}
