//
//  LoggerEventTests.swift
//  ModularMobileLoggerTests
//
//  Created by Kamil Krzyszczak on 19/11/2019.
//  Copyright © 2019 JeaCode. All rights reserved.
//

import XCTest
@testable import ModularMobileLogger

final class LoggerEventTests: XCTestCase {
    
    override class func setUp() {
        super.setUp()
    }
    
    func testEmptyTextDisplay() {
        XCTAssert(Events.empty.textToDisplay() == "01:00:00 +0100 | ℹ️ | ")
    }
    
    func testMinimalDisplay() {
        XCTAssert(Events.minimal.textToDisplay() == "01:00:00 +0100 | ℹ️ | 0.0")
    }
    
    func testArrayDisplay() {
        XCTAssert(Events.array.textToDisplay() == "01:00:00 +0100 | ℹ️ | 0.0\nElements(3):\n   UIExtendedSRGBColorSpace 1 0 0 1   UIExtendedSRGBColorSpace 0 1 0 1   UIExtendedSRGBColorSpace 0 0 1 1", "\(Events.array.textToDisplay())")
    }
    
    func testParamsDisplay() {
        XCTAssert(Events.params.textToDisplay() == "01:00:00 +0100 | ℹ️ | 0.0\nParameters(2):\n  color: red\n  number: 2.0\n", "\(Events.params.textToDisplay())")
    }
    
    func testFullDisplay() {
        XCTAssert(Events.full.textToDisplay() == "01:00:00 +0100 | ℹ️ | 0.0\nParameters(2):\n  color: red\n  number: 2.0\n\nElements(3):\n   UIExtendedSRGBColorSpace 1 0 0 1   UIExtendedSRGBColorSpace 0 1 0 1   UIExtendedSRGBColorSpace 0 0 1 1", "\(Events.full.textToDisplay())")
    }
    
    func testDisplayWithName() {
        XCTAssert(Events.minimal.textToDisplay(displayTextEventName: true) == "01:00:00 +0100 | ℹ️ | Debug | 0.0")
    }
    
    //MARK: Mocks
    
    struct Events {
        private static let date = Date(timeIntervalSince1970: 0)
        private static let mockedText = "\(date.timeIntervalSince1970)"
        private static let mockedParams: [String : Any] = ["color":"red", "number":2.0]
        private static let mockedArray = [UIColor.red, UIColor.green, UIColor.blue]
        
        static let empty = LoggerEvent(config: configFactory(),
                                       text: "",
                                       date: Date(timeIntervalSince1970: 0))
        static let minimal = LoggerEvent(config: configFactory(),
                                         text: mockedText,
                                         date: Date(timeIntervalSince1970: 0))
        static let array = LoggerEvent(config: configFactory(),
                                       text: mockedText,
                                       date: Date(timeIntervalSince1970: 0),
                                       array: mockedArray)
        static let params = LoggerEvent(config: configFactory(),
                                        text: mockedText,
                                        date: Date(timeIntervalSince1970: 0),
                                        params: mockedParams)
        static let full = LoggerEvent(config: configFactory(),
                                      text: mockedText,
                                      date: Date(timeIntervalSince1970: 0),
                                      params: mockedParams,
                                      array: mockedArray)
    }
    
    //MARK: Factory
    
    private static func configFactory(type: DefaultLoggerLogTypes = .debug) -> LoggerEventConfig {
        return LoggerEventConfig(type: LoggerEventType(type: type))
    }
    
    private static func eventFactory(text: String = "\(#function)", config: LoggerEventConfig) -> LoggerEvent {
        return LoggerEvent(config: config,
                           text: text)
    }
}
