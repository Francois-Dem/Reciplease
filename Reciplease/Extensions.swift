//
//  Extensions.swift
//  Reciplease
//
//  Created by françois demichelis on 21/03/2021.
//  Copyright © 2021 françois demichelis. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
