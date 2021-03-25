//
//  DetailController.swift
//  Reciplease
//
//  Created by françois demichelis on 21/03/2021.
//  Copyright © 2021 françois demichelis. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    @IBOutlet weak var imageRecipe: UIImageView!
    @IBOutlet weak var recipeIngredients: UILabel!
    
    var hit: Hit?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        
        guard let hit = hit else { return }
        guard let url = URL(string: hit.recipe.image) else { return }
        imageRecipe.load(url: url)
        
        recipeIngredients.text = hit.recipe.label
    }
        

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
