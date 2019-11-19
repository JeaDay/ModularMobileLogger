//
//  PrinterTests.swift
//  ModularMobileLoggerTests
//
//  Created by Kamil Krzyszczak on 18/05/2019.
//  Copyright © 2019 JeaCode. All rights reserved.
//

import XCTest
@testable import ModularMobileLogger

class PrinterTests: XCTestCase {
    
    private var printer: Printer!
    
    override func setUp() {
        self.printer = Printer()
    }
    
    func testPrintAsyncWithNoContent() {
        printer.printAsync(content: "")
    }
    
    func testPrintAsync() {
        printer.printAsync(content: "\(#function)")
    }
    
    func testPrintAsyncWithLongContent() {
        printer.printAsync(content: createLongContent())
    }
    
    func testPrintSyncWithNoContent() {
        printer.printSync(content: "")
    }
    
    func testPrintSync() {
        printer.printSync(content: "\(#function)")
    }
    
    func testPrintWithLongContent() {
        printer.printSync(content: createLongContent())
    }
    
    func testIsPrinting() {
        let testPrinter = Printer.init(allowPrintOnTestTragets: true)
        testPrinter.printSync(content: "\(#function)")
    }
    
    private func createLongContent(words: Int = 2000, word: String = "\(#function)") -> String {
        var longContent = ""
        for _ in 0...words {
            longContent.append(word)
        }
        return longContent
    }
    
}
