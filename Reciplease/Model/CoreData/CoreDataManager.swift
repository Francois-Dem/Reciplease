//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by françois demichelis on 30/03/2021.
//  Copyright © 2021 françois demichelis. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager {

    // MARK: - Properties

    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext

    var favRecipes: [Recipes] {
        let request: NSFetchRequest<Recipes> = Recipes.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "label", ascending: true)]
        guard let favorites = try? managedObjectContext.fetch(request) else { return [] }
        return favorites
    }

    // MARK: - Initializer

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }

    // MARK: - Manage Favorite Entity

    func createRecipe(image: Data?, ingredients: [String], label: String, totalTime: String, url: String, yield: String) {
        let recipe = Recipes(context: managedObjectContext)
        recipe.image = image
        recipe.ingredients = ingredients
        recipe.label = label
        recipe.totalTime = totalTime
        recipe.url = url
        recipe.yield = yield
        coreDataStack.saveContext()
    }
    
    func isInFavorite(label: String) -> Bool {
        let request: NSFetchRequest<Recipes> = Recipes.fetchRequest()
        request.predicate = NSPredicate(format: "label == %@", label)
        guard let favorites = try? managedObjectContext.fetch(request) else { return false }
        
        if !favorites.isEmpty {
            return true
        }
            return false
    }
    
    func deleteFavorite(label: String) -> Bool {
        let request: NSFetchRequest<Recipes> = Recipes.fetchRequest()
        request.predicate = NSPredicate(format: "label == %@", label)
        guard let favorites = try? managedObjectContext.fetch(request) else { return false }
        
        let isFavorite = favorites.count == 1
        if (!isFavorite) {
            print("An error occured while searching for the recipe")
            return false
        }
        
        guard let favToDelete = favorites.first else { return false }
        managedObjectContext.delete(favToDelete)
        coreDataStack.saveContext()
        
        return true
    }
    
    func deleteAllFavorite() {
        favRecipes.forEach { managedObjectContext.delete($0) }
        coreDataStack.saveContext()
    }
}
