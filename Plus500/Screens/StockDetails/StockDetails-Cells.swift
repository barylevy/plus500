// StockDetails-Cells.swift
// Plus500
//
// Created by Bary Levy on 25/05/2021.
//
//

import UIKit

class FeedHistoricalCell: UITableViewCell {

    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelBuy: UILabel!
    @IBOutlet weak var labelSell: UILabel!
    @IBOutlet weak var labelSpread: UILabel!
    @IBOutlet weak var labelRateChange: UILabel!
    
    let dateFormatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateFormatter.dateFormat = "HH:mm:ss"
    }

    func configureCell(data: StockDetailsViewController.FeedHistoricalData) {
        if let time = data.time {
            labelDate.text = dateFormatter.string(from: time)
        }
        
        if let buyPrice = data.buyPrice {
            labelBuy.text = "Buy: \(buyPrice)"
            labelBuy.isHidden = false
        } else {
            labelBuy.isHidden = true
        }
        
        if let sellPrice = data.sellPrice {
            labelSell.text = "Sell: \(sellPrice)"
            labelSell.isHidden = false
        } else {
            labelSell.isHidden = true
        }
        
        if let spread = data.spread {
            labelSpread.text = "Spread: \(spread)"
            labelSpread.isHidden = false
        } else {
            labelSpread.isHidden = true
        }
        
        if let rateChange = data.rateChange {
            labelRateChange.text = "Rate Change: \(String(format:"%.2f", rateChange))%"
            labelRateChange.isHidden = false
        } else {
            labelRateChange.isHidden = true
        }
    }
}
