//
//  LoggerEvent.swift
//  ModularMobileLogger
//
//  Created by Kamil Krzyszczak on 18/05/2019.
//  Copyright © 2019 JeaCode. All rights reserved.
//
import Foundation

public struct LoggerEvent {
    let config: LoggerEventConfig
    let text: String
    private let date: Date
    private let params: [String: Any]?
    private let array: [Any]?
    
    init(config: LoggerEventConfig,
         text: String,
         date: Date = Date(),
         params: [String: Any]? = nil,
         array: [Any]? = nil) {
        self.config = config
        self.date = date
        self.text = text
        self.params = params
        self.array = array
    }
    
    func textToDisplay(displayTextEventName: Bool = false) -> String {
        var textToDisplay = baseText(displayTextEventName: displayTextEventName)
        if let params = params {
            textToDisplay.append("\nParameters(\(params.keys.count)):\n")
            _ = params.keys.sorted().map({ (key) -> Void in
                textToDisplay.append("  \(key): \(params[key] ?? "")\n")
            })
        }
        
        if let array = array {
            textToDisplay.append("\nElements(\(array.count)):\n")
            _ = array.map { (element) -> Void in
                switch element {
                case let loging as Loging:
                    textToDisplay.append(
                        """
                        \(loging.loging)\n
                        """
                    )
                default:
                    textToDisplay.append("   \(element)")
                }
            }
        }
        return textToDisplay
    }
    
    private func baseText(displayTextEventName: Bool = false) -> String {
        return """
        \(descriptedDate(date: date)) | \(config.emojiIcon) |\(displayTextEventName ? " \(config.type.name) |" : "" ) \(text)
        """
    }
    
    private func descriptedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss Z"
        return formatter.string(from: date)
    }
}

