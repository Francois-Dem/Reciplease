//
//  RecipesController.swift
//  Reciplease
//
//  Created by françois demichelis on 08/03/2021.
//  Copyright © 2021 françois demichelis. All rights reserved.
//

import UIKit

class RecipesController: UITableViewController {

    let cellId: String = "RecipeCell"
        
    var recipes = [Hit]()
    var selectedRecipe: Hit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RecipeTableViewCell
        
        let hit = recipes[indexPath.row]
        cell.hit = hit

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        selectedRecipe = recipes[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetail") {            
            let dest = segue.destination as! DetailController
            dest.hit = selectedRecipe
        }
    }

}
