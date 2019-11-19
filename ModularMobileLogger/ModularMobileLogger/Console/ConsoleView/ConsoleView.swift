//
//  ConsoleView.swift
//  ModularMobileLogger
//
//  Created by Kamil Krzyszczak on 02/06/2019.
//  Copyright © 2019 JeaCode. All rights reserved.
//

import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

class ConsoleView: UIView {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var showMoreButton: UIButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var eventsTableView: UITableView!
    
    private var events: [LoggerEvent] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        setupTableView()
    }
    
    private func setupTableView() {
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        eventsTableView.register(ConsoleEventCell.nib, forCellReuseIdentifier: ConsoleEventCell.identifier)
        eventsTableView.rowHeight = UITableView.automaticDimension
        eventsTableView.estimatedRowHeight = 25
    }
    
    func add(_ event: LoggerEvent) {
        events.append(event)
        eventsTableView.reloadData()
    }
}

extension ConsoleView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 22
//    }
}

extension ConsoleView: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard canGrabCel(indexPath) else { return UITableViewCell() }
        guard let cell = cellFor(indexPath, in: tableView) as? ConsoleEventCell else {
            return UITableViewCell()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ConsoleEventCell, let event = eventFor(indexPath) else { return }
        cell.bind(event)
    }

    private func cellFor(_ indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ConsoleEventCell.identifier,
                                                       for: indexPath) as? ConsoleEventCell else { return nil }
        return cell
    }

    private func eventFor(_ indexPath: IndexPath) -> LoggerEvent? {
        guard canGrabCel(indexPath) else { return nil }
        return events[indexPath.row]
    }
    
    private func canGrabCel(_ indexPath: IndexPath) -> Bool {
        guard !events.isEmpty else {
            return false
        }
        guard indexPath.row < (events.count) else {
            return false
        }
        return true
    }
}
