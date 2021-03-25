//
//  UIColor.swift
//  Reciplease
//
//  Created by françois demichelis on 24/03/2021.
//  Copyright © 2021 françois demichelis. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}
