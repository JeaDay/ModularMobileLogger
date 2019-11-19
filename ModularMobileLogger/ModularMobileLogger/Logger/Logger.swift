//
//  Logger.swift
//  ModularMobileLogger
//
//  Created by Kamil Krzyszczak on 18/05/2019.
//  Copyright © 2019 JeaCode. All rights reserved.
//

import Foundation

public class Logger {
    
    private let maxEventBuffer: Int
    private var congfigs: [LoggerEventConfig]
    private var ignoredEvents: [LoggerEventConfig]
    private var ignoredFiles: [String]
    private var printer: Printer
    private var screenConsole: Bool
    private(set) var pastEvents: [LoggerEvent]
    
    
    public init(congfigs: [LoggerEventConfig] = DefaultConfigsFactory().createDefaultConfigs(),
                ignoredEvents: [LoggerEventConfig] = [],
                ignoredFiles: [String] = [],
                printer: Printer = Printer(allowPrintOnTestTragets: false),
                screenConsole: Bool = true,
                bufforItems: Int = 10000) {
        self.congfigs = congfigs
        self.ignoredEvents = ignoredEvents
        self.ignoredFiles = ignoredFiles
        self.printer = printer
        self.screenConsole = screenConsole
        self.pastEvents = []
        self.maxEventBuffer = bufforItems
    }
    
    public func dumpPastEvents() {
        pastEvents = []
    }
    
    public func display(console: Bool, event: LoggerEvent, file: String = "\(#file)") {
        pastEvents.append(event)
        innerDisplay(event: event, file: file)
        guard console else { return }
        Console.shared.show(event)
    }
    
    private func innerDisplay(event: LoggerEvent, file: String = "\(#file)", allowStop: Bool = true) {
        guard allowPrintOfEvent(type: event.config.type) else { return }
        guard !ignoredFiles.contains(file) else { return }
        guard !ignoredEvents.contains(event.config) else { return }
        if event.config.async {
            printer.printAsync(content: event.textToDisplay())
        } else {
            printer.printSync(content: event.textToDisplay())
        }
        guard !event.config.shouldStopAtDebug else {
            guard allowStop else { return }
            stopLoggerWith(info: "Stopped with fatal error from event: \(event.textToDisplay())")
            return
        }
    }
    
    private func allowPrintOfEvent(type: LoggerEventType) -> Bool {
        guard congfigs.contains(where: { (config) -> Bool in
            config.type == type
        }) else {
            stopLoggerWith(info: "Type of event: \(type.name) was not added to logger!")
            return false
        }
        return true
    }
    
    private func trimItems() {
        while pastEvents.count > maxEventBuffer {
            pastEvents.removeFirst()
        }
    }
    
    private func stopLoggerWith(info: String) {
        fatalError(info)
    }
    
    private func configForEvent(type: LoggerEventType) -> LoggerEventConfig? {
        let config = congfigs.first { (element) -> Bool in
            element.type == type
        }
        guard (config != nil) else {
            stopLoggerWith(info: "Type of event: \(DefaultLoggerLogTypes.error.rawValue) was not added to logger!")
            return nil
        }
        return config
    }
}

extension Logger {
    func displayStatus() {
        print("""
            Logger:
            |  configs: \(congfigs.count)
            |  ignored configs: \(ignoredEvents.count)
            |  ignored files: \(ignoredFiles.count)
            |  loggs cached: \(pastEvents.count)
            """)
    }
    
    func displayInnerDemo() {
        for config in congfigs {
            let event = LoggerEvent(config: config, text: "This is \(config.type.name) event type log")
            innerDisplay(event: event, allowStop: false)
        }
    }
}

extension Logger {
    
    public func logFatalError(_ description: String,
                              array: [Any]? = nil,
                              params: [String: Any]? = nil,
                              file: String = "\(#file)",
        function: String = "\(#function)")  {
        log(type: .fatalError, description: description, array: array, params: params, file: file)
    }
    
    public func logError(_ description: String,
                         array: [Any]? = nil,
                         params: [String: Any]? = nil,
                         file: String = "\(#file)",
        function: String = "\(#function)")  {
        log(type: .error, description: description, array: array, params: params, file: file)
    }
    
    public func logWarrning(_ description: String,
                            array: [Any]? = nil,
                            params: [String: Any]? = nil,
                            file: String = "\(#file)",
        function: String = "\(#function)")  {
        log(type: .warrning, description: description, array: array, params: params, file: file)
    }
    
    public func logDebug(_ description: String,
                         array: [Any]? = nil,
                         params: [String: Any]? = nil,
                         file: String = "\(#file)",
        function: String = "\(#function)")  {
        log(type: .debug, description: description, array: array, params: params, file: file)
    }
    
    public func logDeveloperDebug(_ description: String,
                                  array: [Any]? = nil,
                                  params: [String: Any]? = nil,
                                  file: String = "\(#file)",
        function: String = "\(#function)")  {
        log(type: .developerDebug, description: description, array: array, params: params, file: file)
    }
    
    public func logDataBase(_ description: String,
                            array: [Any]? = nil,
                            params: [String: Any]? = nil,
                            file: String = "\(#file)",
        function: String = "\(#function)")  {
        log(type: .db, description: description, array: array, params: params, file: file)
    }
    
    public func logUserInteraction(_ description: String,
                                   array: [Any]? = nil,
                                   params: [String: Any]? = nil,
                                   file: String = "\(#file)",
        function: String = "\(#function)")  {
        log(type: .ui, description: description, array: array, params: params, file: file)
    }
    
    public func logNetwork(_ description: String,
                           array: [Any]? = nil,
                           params: [String: Any]? = nil,
                           file: String = "\(#file)",
        function: String = "\(#function)")  {
        log(type: .network, description: description, array: array, params: params, file: file)
    }
    
    public func logInfo(_ description: String,
                        array: [Any]? = nil,
                        params: [String: Any]? = nil,
                        file: String = "\(#file)",
        function: String = "\(#function)")  {
        log(type: .info, description: description, array: array, params: params, file: file)
    }
    
    public func logVerbose(_ description: String,
                           array: [Any]? = nil,
                           params: [String: Any]? = nil,
                           file: String = "\(#file)",
        function: String = "\(#function)")  {
        log(type: .verbose, description: description, array: array, params: params, file: file)
    }
    
    private func log(type: DefaultLoggerLogTypes,
                     description: String,
                     array: [Any]?,
                     params: [String: Any]?,
                     file: String) {
        guard let config = constructConfig(type: type) else { return }
        wrapDisplay(event: constructEvent(config: config,
                                          description: description,
                                          array: array,
                                          params: params),
                    file: file)
    }
    
    private func constructConfig(type: DefaultLoggerLogTypes) -> LoggerEventConfig? {
        return configForEvent(type: LoggerEventType(name: type.rawValue))
    }
    
    private func constructEvent(config: LoggerEventConfig, description: String, array: [Any]?, params: [String:Any]?) -> LoggerEvent {
        return LoggerEvent(config: config, text: description, params: params, array: array)
    }
    
    private func wrapDisplay(event: LoggerEvent, file: String) {
        display(console: screenConsole, event: event, file: file)
    }
}
