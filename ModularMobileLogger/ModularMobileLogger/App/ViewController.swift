//
//  ViewController.swift
//  ModularMobileLogger
//
//  Created by Kamil Krzyszczak on 18/05/2019.
//  Copyright © 2019 JeaCode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        demoRun(logger: constructLogger(console: false))
    }
    
    private func constructLogger(console: Bool) -> Logger {
        return Logger(screenConsole: console)
    }
    
    private func demoRun(logger: Logger) {
        //        testLogger.displayInnerDemo() // will show only local configs
        logger.displayStatus()
        logger.logError("Error")
        logger.logWarrning("Warrning")
        //        testLogger.logFatalError("Fatal Error") // will crash any app in debug
        logger.logDebug("Debug")
        logger.logDeveloperDebug("Developer debug")
        logger.logUserInteraction("User Interaction")
        logger.logDataBase("Data Base")
        logger.logNetwork("Network Data")
        logger.logInfo("Info")
        logger.logVerbose("Verbose")
        logger.logDeveloperDebug("Fruits:",array: fruits, params: json)
    }
    
    private let json: [String: Any] = ["name":"Orange",
                                       "cost":2.0,
                                       "color":"orange",
                                       "array":["Benek","Zenek","Gienek"],
                                       "object": ["name":"Apple",
                                                  "cost":1.0,
                                                  "color":"green"]]
    
    private let fruits = [Fruit(name: "Orange",
                                cost: 2.0,
                                color: .orange),
                          Fruit(name: "Banana",
                                cost: 1.0,
                                color: .yellow),
                          Fruit(name: "Apple",
                                cost: 0.5,
                                color: .red),
                          Fruit(name: "Kiwi",
                                cost: 0.5,
                                color: .green)]
    
    private let lorem = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur consequat tellus volutpat dignissim vestibulum. Fusce sagittis fringilla rutrum. Fusce id augue et mi facilisis interdum. Nunc iaculis nunc enim, eu pretium enim interdum sed. Vestibulum egestas augue at metus sagittis, at scelerisque nibh laoreet. Etiam ac nibh turpis. Nam vitae libero in metus laoreet posuere eu sit amet quam. Ut ante ligula, maximus et commodo eu, ornare sed ex. Ut elementum ipsum nulla, id congue libero tincidunt vel. Donec luctus molestie consequat. Proin cursus id lacus et sodales. Sed urna elit, tincidunt eget magna ut, blandit consequat mauris. Ut eu lectus in sapien tempor aliquet at ac lectus. Pellentesque dignissim semper ultricies. Pellentesque aliquet, felis ac convallis placerat, mauris lorem rhoncus erat, at tincidunt lacus enim pellentesque dui. Sed dictum felis quis sem interdum, sed condimentum nisl euismod.

Sed magna lorem, lobortis eget pellentesque sit amet, dignissim ut ipsum. Pellentesque egestas quis sem a lacinia. Sed iaculis sodales quam, et dapibus urna vulputate sed. Aliquam ac porta ipsum. In at dapibus neque, volutpat rutrum magna. Praesent bibendum enim varius, tincidunt tortor a, accumsan ante. Integer laoreet pharetra purus et vehicula. Aliquam sodales lacinia velit, nec sagittis augue semper eu. Vestibulum vel ipsum commodo eros euismod porta. Donec dictum, eros et placerat ullamcorper, lectus nibh pulvinar odio, ac iaculis nulla nibh non lacus. Phasellus dapibus lacinia volutpat. Quisque ac ligula eget felis mattis lacinia ac vitae dolor. Nam finibus lacinia sapien non congue. Praesent eget iaculis risus.

Etiam risus sapien, rutrum a nisi in, congue elementum lacus. Duis accumsan ante sit amet tortor rhoncus imperdiet. Praesent rhoncus ipsum sed commodo vestibulum. Fusce at tincidunt nisl. Aliquam leo nisl, vestibulum vel purus ac, sodales cursus mauris. Aenean dapibus, nulla sit amet posuere sodales, quam lacus ultricies lorem, eu porttitor lacus dui sed odio. Nunc felis enim, dapibus sit amet nisi nec, pharetra sodales felis. Maecenas elementum ante vitae magna congue, malesuada blandit odio euismod. Donec quis fermentum lectus, a mollis augue. Aliquam ornare eros eu enim fringilla fermentum.
"""
    
    
}
