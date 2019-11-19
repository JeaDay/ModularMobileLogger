//
//  Fruit.swift
//  ModularMobileLogger
//
//  Created by Kamil Krzyszczak on 19/11/2019.
//  Copyright © 2019 JeaCode. All rights reserved.
//

import UIKit

struct Fruit {
    let name: String
    let cost: Double
    let color: UIColor
}

extension Fruit: Loging {
    var loging: String {
        return """
        name: \(name.debugDescription)
        cost: \(cost.debugDescription)
        color: \(color.debugDescription)
        """
    }
}
