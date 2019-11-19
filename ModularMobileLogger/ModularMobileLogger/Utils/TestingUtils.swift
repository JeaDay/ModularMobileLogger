//
//  TestingUtils.swift
//  ModularMobileLogger
//
//  Created by Kamil Krzyszczak on 18/05/2019.
//  Copyright © 2019 JeaCode. All rights reserved.
//

import Foundation

class TestingUtils {
    
    func isLunchedOnTestingTarget() -> Bool {
        if let _ = NSClassFromString("XCTest") {
            return true
        } else {
            return false
        }
    }
}
