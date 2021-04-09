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
    var recipes: Recipes?
    var recipeDetail: RecipeDetail?
    
    private var coreDataManager: CoreDataManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        
        setupUI()
    }

    private func setupUI() {
        //image
        guard let url = recipeDetail?.image else { return }
        let image = UIImage(data: url)
        imageRecipe.image = image
        imageRecipe.contentMode = .scaleAspectFill

        let title: UILabel = {
        let label = UILabel()
            label.text = recipeDetail?.title
            label.textAlignment = NSTextAlignment.center
            label.numberOfLines = 1
            return label
        }()
        func SetupView() {
            self.imageRecipe.addSubview(title)
            title.bottomAnchor.constraint(equalTo: imageRecipe.bottomAnchor).isActive = true
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeDetail?.ingredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let ingredient = recipeDetail?.ingredients[indexPath.row] ?? ""
        cell.textLabel?.text = "- \(ingredient)"
        
        return cell
    }

    @IBAction func toggleFavButtonAction(_ sender: UIBarButtonItem) {
        let image = recipeDetail?.image
        
        let ingredients = recipeDetail?.ingredients.map { $0 } ?? []
        
        let label = recipeDetail?.title ?? ""
        
        let totalTime = recipeDetail?.totalTime ?? ""
        
        let url = recipeDetail?.url ?? ""
        
        let yield = recipeDetail?.yield ?? ""
        
        coreDataManager?.createRecipe(image: image, ingredients: ingredients, label: label, totalTime: totalTime, url: url, yield: yield)
        
    }
    @IBAction func getDirectionsTapped(_ sender: Any) {
        
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
