//
//  LoggerEventConfig.swift
//  ModularMobileLogger
//
//  Created by Kamil Krzyszczak on 18/05/2019.
//  Copyright © 2019 JeaCode. All rights reserved.
//

import UIKit

public struct LoggerEventConfig {
    let type: LoggerEventType
    let textColor: UIColor
    let emojiIcon: String
    let async: Bool
    let shouldStopAtDebug: Bool
    let shouldBeVisible: Bool
    
    init(type: LoggerEventType,
         textColor: UIColor = UIColor.white,
         emojiIcon: String = "ℹ️",
         async: Bool = false,
         shouldStopAtDebug: Bool = false,
         shouldBeVisible: Bool = true) {
        self.type = type
        self.textColor = textColor
        self.emojiIcon = emojiIcon
        self.async = async
        self.shouldStopAtDebug = shouldStopAtDebug
        self.shouldBeVisible = shouldBeVisible
    }
}

extension LoggerEventConfig: Equatable {
    public static func ==(lhs: LoggerEventConfig, rhs: LoggerEventConfig) -> Bool {
        return lhs.type == rhs.type
    }
}
