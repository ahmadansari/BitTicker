//
//  TickerCollectionCell.swift
//  BitTicker
//
//  Created by Ahmad Ansari on 08/03/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import UIKit

class TickerCollectionCell: UICollectionViewCell {
    static let collectionCellIdentifier = "tickerCollectionCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var percentChangeLabel: UILabel!
    
    @IBOutlet weak var lastTradePriceLabel: UILabel!
    @IBOutlet weak var lowestTradePriceLabel: UILabel!
    @IBOutlet weak var highestTradePriceLabel: UILabel!
    
    @IBOutlet weak var lowestAskLabel: UILabel!
    @IBOutlet weak var highestBidLabel: UILabel!
    
    @IBOutlet weak var baseCurrencyVolumeLabel: UILabel!
    @IBOutlet weak var quoteCurrencyVolumeLabel: UILabel!
    
    @IBOutlet weak var upArrow: UIImageView!
    @IBOutlet weak var downArrow: UIImageView!
    
    class func register(forCollectionView collectionView: UICollectionView?) {
        guard collectionView != nil else { return }
        collectionView?.register(UINib.init(nibName: "TickerCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: TickerCollectionCell.collectionCellIdentifier)
    }
    
    func configure(tickerDTO: TickerDTO, searchText: String? = nil) {
        titleLabel.text = tickerDTO.currencyPairName()
        
        lastTradePriceLabel.text = tickerDTO.lastTradePrice()
        lowestTradePriceLabel.text = tickerDTO.lowestTradePrice()
        highestTradePriceLabel.text = tickerDTO.highestTradePrice()
        
        lowestAskLabel.text = tickerDTO.lowestAsk()
        highestBidLabel.text = tickerDTO.highestBid()
        
        baseCurrencyVolumeLabel.text = tickerDTO.baseCurrencyVolume()
        quoteCurrencyVolumeLabel.text = tickerDTO.quoteCurrencyVolume()
        
        percentChangeLabel.text = tickerDTO.percentChangeValue()
        if tickerDTO.isChangePositive() {
            percentChangeLabel.backgroundColor = UIColor.stockGreen
        } else {
            percentChangeLabel.backgroundColor = UIColor.stockRed
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
                titleLabel.sizeToFit()
            }
        } else {
            upArrow.isHidden = true
            downArrow.isHidden = true
        }
    }
}
