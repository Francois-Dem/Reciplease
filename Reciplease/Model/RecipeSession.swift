//
//  RecipeSession.swift
//  Reciplease
//
//  Created by françois demichelis on 23/02/2021.
//  Copyright © 2021 françois demichelis. All rights reserved.
//

import Foundation
import Alamofire

protocol AlamofireSession {
    func request(url: URL, callback: @escaping (AFDataResponse<Any>) -> Void)
}

final class RecipeSession: AlamofireSession {
    func request(url: URL, callback: @escaping (AFDataResponse<Any>) -> Void) {
        
        AF.request(url).responseJSON { dataResponse in
            callback(dataResponse)
        }
    }
}
