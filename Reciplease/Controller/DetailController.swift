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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeImage: UIImageView!
    @IBOutlet weak var peopleLabel: UILabel!
    @IBOutlet weak var toggleFavButton: UIBarButtonItem!
    
    let cellId: String = "DetailCell"
            
    var recipeDetail: RecipeDetail?
    var isInFavorite: Bool = false
    
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
        
        titleLabel.text = recipeDetail?.title
        let totalTime = recipeDetail?.totalTime ?? ""
        timeLabel.text = " \(totalTime) min"
        
        // remove time if = 0 or missing
        let isValidTotalTime = totalTime != "" && totalTime != "0"
        timeImage.isHidden = !isValidTotalTime
        timeLabel.isHidden = !isValidTotalTime
        
        let yield = recipeDetail?.yield ?? ""
        peopleLabel.text = " \(yield) people"
        
        guard let title = recipeDetail?.title else { return }
        if let isFav = coreDataManager?.isInFavorite(label: title) {
            isInFavorite = isFav
        }
        
        setupFavoriteButton()
    }
    
    private func setupFavoriteButton() {
        if (isInFavorite) {
            toggleFavButton.image = #imageLiteral(resourceName: "Icon-App-20x20-2").withRenderingMode(.alwaysOriginal)
        } else {
            toggleFavButton.image = #imageLiteral(resourceName: "Icon-App-20x20-3").withRenderingMode(.alwaysOriginal)
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeDetail?.ingredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let ingredient = recipeDetail?.ingredients[indexPath.row] ?? ""
        cell.textLabel?.text = "- \(ingredient)"
        tableView.separatorStyle = .none
        return cell
    }

    @IBAction func toggleFavButtonAction(_ sender: UIBarButtonItem) {
        if (isInFavorite) {
            // Remove from favorite
            guard let title = recipeDetail?.title else { return }
            guard let isDeleted = coreDataManager?.deleteFavorite(label: title) else { return }
            
            if (!isDeleted) {
                return
            }
            
            isInFavorite = false
            setupFavoriteButton()
            // return back only on FavView when remove favorite
            if tabBarController?.selectedIndex == 1 {
                navigationController?.popViewController(animated: true)
            }
            
        } else {
            // Add to favorite
            let image = recipeDetail?.image
            let ingredients = recipeDetail?.ingredients.map { $0 } ?? []
            let label = recipeDetail?.title ?? ""
            let totalTime = recipeDetail?.totalTime ?? ""
            let url = recipeDetail?.url ?? ""
            let yield = recipeDetail?.yield ?? ""
            
            coreDataManager?.createRecipe(image: image, ingredients: ingredients, label: label, totalTime: totalTime, url: url, yield: yield)
            
            isInFavorite = true
            setupFavoriteButton()
        }
    }
    
    @IBAction func getDirectionsTapped(_ sender: Any) {
        let urlStr = recipeDetail?.url ?? ""
        
        guard let url = URL(string: urlStr) else { return }
        UIApplication.shared.open(url)
    }
    

}
