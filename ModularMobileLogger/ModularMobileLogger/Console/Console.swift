//
//  Console.swift
//  ModularMobileLogger
//
//  Created by Kamil Krzyszczak on 02/06/2019.
//  Copyright © 2019 JeaCode. All rights reserved.
//

import UIKit

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

class Console {
    
    static let shared = Console()
    private let consoleView: ConsoleView = ConsoleView.fromNib()
    
    init() {
        addObservers()
    }
    
    deinit {
        removeObservers()
    }
    
    func show(_ event: LoggerEvent) {
        consoleView.add(event)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didBecomeKeyNotification),
            name: UIWindow.didBecomeKeyNotification,
            object: nil
        )
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func didBecomeKeyNotification() {
        setupLayout()
    }
    
    private func setupLayout() {
        guard UIApplication.topViewController() != nil else {
            return
        }
        
        guard let keyWindow = UIApplication.shared.keyWindow else {
            stopConsoleWith(info: "Failed to recive App keyWindow!")
            return
        }
        
        consoleView.setupView()
        keyWindow.insertSubview(consoleView,
                                at: (keyWindow.subviews.count))
    }
    
    private func stopConsoleWith(info: String) {
        fatalError(info)
    }
}
