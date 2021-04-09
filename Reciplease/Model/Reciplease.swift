//
//  Reciplease.swift
//  Reciplease
//
//  Created by françois demichelis on 01/03/2021.
//  Copyright © 2021 françois demichelis. All rights reserved.
//

import Foundation

// MARK: - Reciplease
struct Reciplease: Codable {
    let q: String
    let from, to: Int
    let more: Bool
    let count: Int
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe
    let bookmarked, bought: Bool
}

// MARK: - Recipe
struct Recipe: Codable {
    let uri: String
    let label: String
    let image: String
    let source: String
    let url: String
    let shareAs: String
    let yield: Int
    let ingredients: [Ingredient]
    let totalTime: Int
}

enum Unit: String, Codable {
    case empty = "%"
    case g = "g"
    case kcal = "kcal"
    case mg = "mg"
    case µg = "µg"
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let text: String
    let image: String?

    enum CodingKeys: String, CodingKey {
        case text
        case image
    }
}

struct RecipeDetail {
    let title: String
    let ingredients: [String]
    var image: Data?
    let totalTime: String
    let yield: String
    let url: String
    
}
