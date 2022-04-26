//
//  MealTableViewCell.swift
//  themealdb
//
//  Created by Phil Wright on 4/26/22.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }
    
    func setupCell() {
        self.titleLabel.text = "Test"
    }


}
