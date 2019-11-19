//
//  Printer.swift
//  ModularMobileLogger
//
//  Created by Kamil Krzyszczak on 18/05/2019.
//  Copyright © 2019 JeaCode. All rights reserved.
//

import Foundation
import os

public class Printer {

    private var allowPrintOnTestTragets: Bool
    private var useSystemLog: Bool
    
    public init(allowPrintOnTestTragets: Bool = false, useSystemLog: Bool = false) {
        self.useSystemLog = useSystemLog
        self.allowPrintOnTestTragets = allowPrintOnTestTragets
    }
    
    func printAsync(content: String) {
        DispatchQueue.global().async {
            self.printOnLog(content: content)
        }
    }
    
    func printSync(content: String) {
        DispatchQueue.main.async(execute: {
            self.printOnLog(content: content)
        })
    }
        
    private func printOnLog(content: String) {
        guard !TestingUtils().isLunchedOnTestingTarget() else {
            guard allowPrintOnTestTragets else {
                return
            }
            printer(content: content)
            return
        }
        printer(content: content)
    }
    
    private func printer(content: String) {
        guard useSystemLog else {
            print(content)
            return
        }
        systemPrinter(content: content)
    }
    
    private func systemPrinter(content: String) {
        if #available(iOS 10.0, *) {
            os_log("%s", content)
        } else {
           print(content)
        }
    }
}
