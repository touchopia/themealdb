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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }
    
    func setupCell() {
        self.titleLabel.text = "Test long title for this"
    }
}
