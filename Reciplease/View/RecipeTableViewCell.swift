//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by françois demichelis on 15/03/2021.
//  Copyright © 2021 françois demichelis. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellIngredients: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    var hit: Hit? {
        didSet {
            guard let hit = hit else { return }
            var ingredients = [String]()
            
            for ingredient in hit.recipe.ingredients {
                ingredients.append(ingredient.text)
            }
            
            cellTitle.text = hit.recipe.label
            cellIngredients.text = ingredients.joined(separator: ", ")
            
            guard let url = URL(string: hit.recipe.image) else { return }
            cellImage.load(url: url)
        }
    }
    
}
