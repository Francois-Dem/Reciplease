//
//  CoreDataManagerTest.swift
//  RecipleaseTests
//
//  Created by françois demichelis on 16/04/2021.
//  Copyright © 2021 françois demichelis. All rights reserved.
//

@testable import Reciplease
import XCTest

final class CoreDataManagerTests: XCTestCase {

    // MARK: - Properties

    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!

    //MARK: - Tests Life Cycle

    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }

    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
    }

    // MARK: - Tests

//    func testAddTeskMethods_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
//        coreDataManager.createFavorite(ingredients: ["Lemon", "chicken"], label: "My Recipe")
//        XCTAssertTrue(!coreDataManager.favRecipes.isEmpty)
//        XCTAssertTrue(coreDataManager.favRecipes.count == 1)
//        XCTAssertTrue(coreDataManager.favRecipes[0].label! == "My Recipe")
//        XCTAssertTrue(coreDataManager.favRecipes[0].ingredients![0] == "Lemon")    }

}
