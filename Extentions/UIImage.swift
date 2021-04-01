//
//  UIImage.swift
//  Reciplease
//
//  Created by françois demichelis on 31/03/2021.
//  Copyright © 2021 françois demichelis. All rights reserved.
//

import UIKit

extension String {
    
    var toData: Data? {
        guard let url = URL(string: self) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return data
    }
}
