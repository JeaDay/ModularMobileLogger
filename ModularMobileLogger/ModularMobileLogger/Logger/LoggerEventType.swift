//
//  LoggerEventType.swift
//  ModularMobileLogger
//
//  Created by Kamil Krzyszczak on 18/05/2019.
//  Copyright © 2019 JeaCode. All rights reserved.
//

import Foundation

public struct LoggerEventType {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    init(type: DefaultLoggerLogTypes) {
        self.name = type.rawValue
    }
}

extension LoggerEventType: Equatable {
    public static func ==(lhs: LoggerEventType, rhs: LoggerEventType) -> Bool {
        return lhs.name == rhs.name
    }
}
