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
    @IBOutlet weak var toggleFavButton: UIBarButtonItem!
    
    let cellId: String = "DetailCell"
    
    var hit: Hit?
    private var coreDataManager: CoreDataManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)

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

    @IBAction func toggleFavButtonAction(_ sender: UIBarButtonItem) {
        let image = hit?.recipe.image.toData
        
        let ingredients = hit?.recipe.ingredients.map { $0.text } ?? []
        
        let label = hit?.recipe.label ?? ""
        
        let totalTime = hit?.recipe.totalTime ?? 0
        let totalTimeStr = String(totalTime)
        
        let url = hit?.recipe.url ?? ""
        
        let yield = hit?.recipe.yield ?? 0
        let yieldStr = String(yield)
        
        coreDataManager?.createRecipe(image: image, ingredients: ingredients, label: label, totalTime: totalTimeStr, url: url, yield: yieldStr)
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
