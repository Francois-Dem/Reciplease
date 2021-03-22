//
//  SearchController.swift
//  Reciplease
//
//  Created by françois demichelis on 22/02/2021.
//  Copyright © 2021 françois demichelis. All rights reserved.
//

import UIKit

class SearchController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchRecipe: UIButton!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var ingredientsTextField: UITextField!
    
    let recipleaseService = RecipleaseService()
    let cellId: String = "Cell"
    
    var ingredients = [String]()
    var results: Reciplease?
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    @IBAction func addIngredient(_ sender: Any) {
        guard let textField = ingredientsTextField.text else { return }
        ingredients.append(textField)
        ingredientsTextField.text = ""
        listTableView.reloadData()
    }
    
    @IBAction func clearIngredients(_ sender: Any) {
        ingredients.removeAll()
        listTableView.reloadData()
    }
    
    @IBAction func searchRecipe(_ sender: Any) {
        if (ingredients.count == 0) {
            return
        }
        
        recipleaseService.getData(ingredients: ingredients) { result in
            switch result {
                case .success(let recipePlease):
                    if (recipePlease.hits.count > 0) {
                        self.results = recipePlease
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "showRecipes", sender: nil)
                        }
                    } else {
                        let alert = UIAlertController(title: "Information", message: "Pas de recettes trouvées", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(action)
                        DispatchQueue.main.async {
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = "- \(ingredients[indexPath.row])"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showRecipes") {
            let dest = segue.destination as! RecipesController
            guard let hits = results?.hits else { return }
            dest.recipes = hits
        }
    }
}
