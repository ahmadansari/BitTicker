//
//  TickerCell.swift
//  BitTicker
//
//  Created by Ahmad Ansari on 07/03/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import UIKit

class TickerCell: UITableViewCell {
    static let cellIdentifier = "tickerCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var upArrow: UIImageView!
    @IBOutlet weak var downArrow: UIImageView!
    
    class func register(forTableView tableView: UITableView?) {
        guard tableView != nil else { return }
        tableView?.register(UINib.init(nibName: "TickerCell", bundle: Bundle.main), forCellReuseIdentifier: TickerCell.cellIdentifier)
    }
    
    func configure(tickerDTO: TickerDTO, searchText: String? = nil) {
        titleLabel.text = tickerDTO.currencyPairName()
        valueLabel.text = tickerDTO.lastTradePrice()
        percentLabel.text = tickerDTO.percentChangeValue()
        
        if tickerDTO.isChangePositive() {
            percentLabel.backgroundColor = UIColor.stockGreen
        } else {
            percentLabel.backgroundColor = UIColor.stockRed
        }
        
        if searchText != nil {
            if let filterValue = Double(searchText!) {
                if tickerDTO.isLastTradePricePositive(forValue: filterValue) {
                    upArrow.isHidden = false
                    downArrow.isHidden = true
                } else {
                    upArrow.isHidden = true
                    downArrow.isHidden = false
                }
            }
        } else {
            upArrow.isHidden = true
            downArrow.isHidden = true
        }
    }
}
