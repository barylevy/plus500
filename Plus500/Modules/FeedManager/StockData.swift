//
//  FeedData.swift
//  Plus500
//
//  Created by Bary Levy on 25/05/2021.
//

import Foundation

public class StockData {
    let id: StockId
    let feedName: String?
    
    var feedData: FeedData?
    var historicalFeeds = [FeedData]()
    
    static let RECENT_SAVED_FEEDS = 100
    
    init(stock: StockElement) {
        id = "\(stock.id!)"
        feedName = stock.symbol
    }
    
    var date: Date? { feedData?.date }
    var buyPrice: Double? { feedData?.buyPrice }
    var sellPrice: Double? { feedData?.sellPrice }
    
    func setFeedData(feed: Feed, timeUpdated: Date) {
        feedData = FeedData(feed: feed, time: timeUpdated)
    }
    
    func saveHistorical() {
        if (historicalFeeds.count > Self.RECENT_SAVED_FEEDS ){
            historicalFeeds.removeFirst()
        }
        if let feedData = self.feedData {
            historicalFeeds.append(feedData)
        }
    }
}

struct FeedData {
    let date: Date
    let buyPrice: Double?
    let sellPrice: Double?
    
    init(feed: Feed, time: Date) {
        self.date = time
        buyPrice =  feed.buyPrice?.value
        sellPrice = feed.sellPrice?.value
    }
}
