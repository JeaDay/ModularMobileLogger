//
//  ConsoleEventCell.swift
//  ModularMobileLogger
//
//  Created by Kamil Krzyszczak on 02/06/2019.
//  Copyright © 2019 JeaCode. All rights reserved.
//

import UIKit

class ConsoleEventCell: UITableViewCell {
    
    static let identifier = "ConsoleEventCell"
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var eventLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bind(_ with: LoggerEvent) {
        iconLabel.text = with.config.emojiIcon
        eventLabel.text = with.textToDisplay()
        eventLabel.textColor = with.config.textColor
    }
    
}

