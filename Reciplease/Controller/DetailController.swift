//
//  DetailController.swift
//  Reciplease
//
//  Created by françois demichelis on 21/03/2021.
//  Copyright © 2021 françois demichelis. All rights reserved.
//

import UIKit

class DetailController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var imageRecipe: UIImageView!
    
    let cellId: String = "DetailCell"
    
    var hit: Hit?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        guard let hit = hit else { return }
        
        //image
        guard let url = URL(string: hit.recipe.image) else { return }
        imageRecipe.load(url: url)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hit?.recipe.ingredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let ingredient = hit?.recipe.ingredients[indexPath.row].text ?? ""
        cell.textLabel?.text = "- \(ingredient)"
        
        return cell
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
