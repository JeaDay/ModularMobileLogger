//
//  DefaultConfigsFactory.swift
//  ModularMobileLogger
//
//  Created by Kamil Krzyszczak on 18/05/2019.
//  Copyright © 2019 JeaCode. All rights reserved.
//

import UIKit

public enum DefaultLoggerLogTypes: String {
    case error = "Error"
    case fatalError = "Fatal Error"
    case warrning = "Warrning"
    case debug = "Debug"
    case developerDebug = "Developer Debug"
    case ui = "User Interaction"
    case db = "Data Base"
    case network = "Network Data"
    case info = "Info"
    case verbose = "Verbose"
}

public class DefaultConfigsFactory {
    
    public enum CodingKeys: String {
        case name
        case icon
        case color
        case async
        case stopping
        case visible
    }
    
    public init() { }
    
    public func createDefaultConfigs() -> [LoggerEventConfig] {
        return DefaultConfigsFactory.json.compactMap { (element) -> LoggerEventConfig? in
            return createConfig(name: element[.name] as? String,
                                icon: element[.icon] as? String,
                                async: element[.async] as? Bool,
                                color: element[.color] as? UIColor,
                                shouldStopAtDebug: element[.stopping] as? Bool,
                                shouldBeVisible: element[.visible] as? Bool)
        }
    }
    
    private func createConfig(name: String?, icon: String?, async: Bool?,
                              color: UIColor?,
                              shouldStopAtDebug: Bool? = false,
                              shouldBeVisible: Bool? = true) -> LoggerEventConfig {
        return LoggerEventConfig(type: createTypeFrom(name: name ?? ""),
                                 textColor: color ?? UIColor.white,
                                 emojiIcon: icon ?? "",
                                 async: async ?? true,
                                 shouldStopAtDebug: shouldStopAtDebug ?? false,
                                 shouldBeVisible: shouldBeVisible ?? true)
    }
    
    private func createTypeFrom(name: String) -> LoggerEventType {
        return LoggerEventType(name: name)
    }
    
    private static let json: [[CodingKeys: Any]] = [
        [ CodingKeys.name: "Error",
          CodingKeys.icon: "⛔️",
          CodingKeys.color: UIColor.red,
          CodingKeys.async: false,
          CodingKeys.stopping: false,
          CodingKeys.visible: true
          ],
        [ CodingKeys.name: "Fatal Error",
          CodingKeys.icon: "📛",
          CodingKeys.color: UIColor.magenta,
          CodingKeys.async: false,
          CodingKeys.stopping: true,
          CodingKeys.visible: true
        ],
        [ CodingKeys.name: "Warrning",
          CodingKeys.icon: "⚠️",
          CodingKeys.color: UIColor.yellow,
          CodingKeys.async: false,
          CodingKeys.stopping: false,
          CodingKeys.visible: true
        ],
        [ CodingKeys.name: "Debug",
          CodingKeys.icon: "📄",
          CodingKeys.async: true,
          CodingKeys.stopping: false,
          CodingKeys.visible: true
        ],
        [ CodingKeys.name: "Developer Debug",
          CodingKeys.icon: "📲",
          CodingKeys.async: true,
          CodingKeys.stopping: false,
          CodingKeys.visible: true
        ],
        [ CodingKeys.name: "User Interaction",
          CodingKeys.icon: "🤳",
          CodingKeys.async: false,
          CodingKeys.stopping: false,
          CodingKeys.visible: true
        ],
        [ CodingKeys.name: "Data Base",
          CodingKeys.icon: "🗃",
          CodingKeys.async: false,
          CodingKeys.stopping: false,
          CodingKeys.visible: true
        ],
        [ CodingKeys.name: "Network Data",
          CodingKeys.icon: "🌍",
          CodingKeys.async: false,
          CodingKeys.stopping: false,
          CodingKeys.visible: true
        ],
        [ CodingKeys.name: "Info",
          CodingKeys.icon: "ℹ️",
          CodingKeys.color: UIColor.systemBlue,
          CodingKeys.async: true,
          CodingKeys.stopping: false,
          CodingKeys.visible: true
        ],
        [ CodingKeys.name: "Verbose",
          CodingKeys.icon: "✅",
          CodingKeys.color: UIColor.green,
          CodingKeys.async: true,
          CodingKeys.stopping: false,
          CodingKeys.visible: true
        ],
    ]
    
}


