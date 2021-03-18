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
    
    var datasource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    @IBAction func addIngredient(_ sender: Any) {
        guard let textField = ingredientsTextField.text else { return }
        datasource.append(textField)
        ingredientsTextField.text = ""
        listTableView.reloadData()
    }
    
    @IBAction func clearIngredients(_ sender: Any) {
        datasource.removeAll()
        listTableView.reloadData()
    }
    
    @IBAction func searchRecipe(_ sender: Any) {
            performSegue(withIdentifier: "showRecipes", sender: nil)
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = "- \(datasource[indexPath.row])"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showRecipes") {
            let dest = segue.destination as! RecipesController            
            dest.ingredients = datasource
        }
    }
}
