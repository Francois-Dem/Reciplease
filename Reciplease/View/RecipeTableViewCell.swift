//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by françois demichelis on 15/03/2021.
//  Copyright © 2021 françois demichelis. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var verticalStackView: UIStackView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var peopleLabel: UILabel!
    
    
    var hit: Hit? {
        didSet {
            verticalStackView.backgroundColor = .white
            guard let hit = hit else { return }
            var ingredients = [String]()
            
            for ingredient in hit.recipe.ingredients {
                ingredients.append(ingredient.text)
            }
            
            titleLabel.text = hit.recipe.label
            ingredientsLabel.text = ingredients.joined(separator: ", ")
            let totalTime: Int = hit.recipe.totalTime
            timeLabel.text = " \(totalTime) min"
            let people: Int = hit.recipe.yield
            peopleLabel.text = " \(people) people"
            
            guard let url = URL(string: hit.recipe.image) else { return }
            backgroundImage.load(url: url)
        }
    }
    
}
