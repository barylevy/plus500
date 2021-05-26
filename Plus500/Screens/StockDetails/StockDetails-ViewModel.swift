// StockDetails-ViewModel.swift
// Plus500
//
// Created by Bary Levy on 25/05/2021.
//
//

import Foundation

extension StockDetailsViewController {
    
    struct FeedHistoricalData {
        
        let spread: Double?
        let buyPrice: Double?
        let sellPrice: Double?
        let time: Date?
        let rateChange: Double? // between 0-100
        
        init(feed: FeedData, oldestFeed: FeedData?) {
            buyPrice = feed.buyPrice
            sellPrice = feed.sellPrice
            time = feed.date
            
            if let buyPrice = feed.buyPrice,
               let sellPrice = feed.sellPrice {
                spread = buyPrice - sellPrice
            }
            else {
                spread = 0
            }
            
            if let currentPrice = feed.sellPrice,
               let oldestPrice = oldestFeed?.sellPrice {
                rateChange = 100 - currentPrice / oldestPrice
            } else {
                rateChange = nil
            }
        }
    }
    
    public class ViewModel: FeedType {
        
        let stockId: StockId
        
        var feeds = [FeedHistoricalData]()
        
        var completionReload: (() -> Void)?
        
        var screenTitle: String
        
        init(stockData: StockData) {
            stockId = stockData.id
            
            screenTitle = stockData.feedName ?? "StockId: \(stockData.id)"
            
            setStockData(stockData: stockData)
        }
        
        func prepareData() {
            ModuleFactory.feedsManager.registerFeeds(stockIds: [stockId], delegate: self)
        }
        
        public func onFeedsUpdated(feedData: [StockId : StockData]) {
            if let stockData = feedData[stockId] {
                setStockData(stockData: stockData)
            }
            completionReload?()
        }
        
        func setStockData(stockData: StockData) {
            
            let oldestFeed = stockData.historicalFeeds[0]
            
            var newFeeds = stockData.historicalFeeds.map({ feed in
                FeedHistoricalData(feed: feed, oldestFeed: oldestFeed)
            })
            if let currentFeed = stockData.feedData {
                newFeeds.append(FeedHistoricalData(feed: currentFeed, oldestFeed: oldestFeed))
            }
            
            feeds = newFeeds.reversed()
        }
    }
}
