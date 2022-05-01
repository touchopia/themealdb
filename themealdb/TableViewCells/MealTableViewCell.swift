//
//  MealTableViewCell.swift
//  themealdb
//
//  Created by Phil Wright on 4/27/22.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mealImageView: UIImageView!
    
    let placeholderImage = UIImage(named: "placeholder-image")
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.mealImageView.image = nil
    }
    
    func configure(viewModel: MealViewModel) {
        
        if let meal = viewModel.meal {
            self.titleLabel.text = meal.strMeal
            self.mealImageView?.loadImageFromURL(urlString: meal.strMealThumb, placeholder: placeholderImage)
        }
    }
}
