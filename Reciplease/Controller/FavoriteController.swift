//
//  FavoriteController.swift
//  Reciplease
//
//  Created by françois demichelis on 02/04/2021.
//  Copyright © 2021 françois demichelis. All rights reserved.
//

import UIKit

class FavoriteController: UITableViewController {
    
    let cellId: String = "RecipeCell"
    private var coreDataManager: CoreDataManager?
    
    var selectedRecipe: Recipes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        
        tableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return coreDataManager?.favRecipes.count ?? 0
        }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RecipeTableViewCell
        
        let recipes = coreDataManager?.favRecipes[indexPath.row]
        cell.recipes = recipes
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRecipe = coreDataManager?.favRecipes[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    
    @IBAction func clearButtonTapped(_ sender: UIBarButtonItem) {
        coreDataManager?.deleteAllFavorite()
        tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetail") {
            let dest = segue.destination as! DetailController
            
            let totalTime = selectedRecipe?.totalTime ?? ""
            let totalTimeStr = String(totalTime)
            
            let url = selectedRecipe?.url ?? ""
            
            let yield = selectedRecipe?.yield ?? ""
            let yieldStr = String(yield)
            
            let recipeDetail = RecipeDetail(title: selectedRecipe?.label ?? "", ingredients: selectedRecipe?.ingredients.map { $0 } ?? [], image: selectedRecipe?.image, totalTime: totalTimeStr, yield: yieldStr, url: url)
            
            
            
            dest.recipeDetail = recipeDetail
        }
    }
}


