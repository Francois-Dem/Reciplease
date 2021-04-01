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
        guard let recipes = try? managedObjectContext.fetch(request) else { return [] }
        return recipes
    }

    // MARK: - Initializer

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }

    // MARK: - Manage Recipe Entity

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
    
    
    func deleteAllRecipes() {
        favRecipes.forEach { managedObjectContext.delete($0) }
        coreDataStack.saveContext()
    }
}
