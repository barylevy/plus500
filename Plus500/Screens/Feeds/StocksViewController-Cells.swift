//
//  StocksViewController-Cells.swift
//  Plus500
//
//  Created by Bary Levy on 25/05/2021.
//

import UIKit

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var labelFeedName: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelBuy: UILabel!
    @IBOutlet weak var labelSell: UILabel!
    
    let dateFormatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateFormatter.dateFormat = "HH:mm:ss"
    }

    func configureCell(feedData: StockData) {
        labelFeedName.text = feedData.feedName
        if let time = feedData.date {
            labelDate.text = dateFormatter.string(from: time)
            labelDate.isHidden = false
        } else {
            labelDate.isHidden = true
        }
        
        
        if let buyPrice = feedData.buyPrice {
            labelBuy.text = "Buy: \(buyPrice)"
        }
        
        if let sellPrice = feedData.sellPrice {
            labelSell.text = "Sell: \(sellPrice)"
        }
    }
}
