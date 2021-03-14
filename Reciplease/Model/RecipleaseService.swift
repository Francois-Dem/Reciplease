//
//  RecipleaseService.swift
//  Reciplease
//
//  Created by françois demichelis on 26/02/2021.
//  Copyright © 2021 françois demichelis. All rights reserved.
//

import Foundation

enum RecipeError: Error {
    case noData, invalidResponse, undecodableData
}

final class RecipleaseService {

    // MARK: - Properties

    private let session: AlamofireSession

    // MARK: - Initializer

    init(session: AlamofireSession = RecipeSession()) {
        self.session = session
    }

    // MARK: - Management

    func getData(ingredients: [String], callback: @escaping (Result<Reciplease, RecipeError>) -> Void) {
        // 1 - Define Url
        let urlStr: String = "https://api.edamam.com/search"
        
        // 2 - Create URL from String (urlStr)
        guard let baseUrl: URL = URL(string: urlStr) else { return }
        
        // 3 - Array parameters (tuple : key -> value)
        let parameters = [("q", ingredients.joined(separator: ",")),
        ("app_id", "4427bd64"),
        ("app_key", "7d1af595b0484968bdca06e6a03b4b34")]
        let url = encode(baseUrl: baseUrl, with: parameters)        
        session.request(url: url) { dataResponse in
            guard let data = dataResponse.data else {
                callback(.failure(.noData))
                return
            }
            guard dataResponse.response?.statusCode == 200 else {
                callback(.failure(.invalidResponse))
                return
            }
            guard let dataDecoded = try? JSONDecoder().decode(Reciplease.self, from: data) else {
                callback(.failure(.undecodableData))
                return
            }
            callback(.success(dataDecoded))
        }
    }
    
    private func encode(baseUrl: URL, with parameters: [(String, Any)]?) -> URL {
        guard var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false) else { return baseUrl }
        guard let parameters = parameters, !parameters.isEmpty else { return baseUrl }
        
        urlComponents.queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            urlComponents.queryItems?.append(queryItem)
        }
        guard let url = urlComponents.url else { return baseUrl }
        return url
    }}
