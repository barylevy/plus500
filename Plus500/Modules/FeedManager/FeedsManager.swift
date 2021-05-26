//
//  FeedsManager.swift
//  Plus500
//
//  Created by Bary Levy on 25/05/2021.
//

import Foundation

public typealias StockId = String

public class FeedsManager: FeedsManagerType {
    
    private var stocksData: [StockId: StockData]?
    
    private var lastUpdateTime: Date?
    
    private weak var delegate: FeedType?
    
    private var timer: Timer?
    private let fetchInterval = 0.5 // TODO MOVE TO CONSTANT
    private var stockIds: [StockId]?
    private var dateFormatter = DateFormatter()
    
    init() {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssssssZ"
    }
    
    public func registerFeeds(stockIds: [StockId]?, delegate: FeedType) {
        self.delegate = delegate
        
        
        fetchRemoteData()
    }
    
    private func fetchRemoteData() {
        
        fetchStockStaticData { [weak self]  in
            ModuleFactory.network.fetchRealTimeFeeds(ids: self?.stockIds, comletion: { response in
                self?.lastUpdateTime = Date()//TODO: self?.dateFormatter.date(from: response.lastUpdate!)
                let realTimeData = self?.convertRealtimeData(feeds: response.feeds)
                self?.enrichData(feeds: realTimeData)
                self?.addHistoricalData()
                self?.dispatchData()
                self?.fireTimer()
            })
        }
    }
    
    private func fetchStockStaticData(completion: @escaping()->Void) {
        guard stocksData == nil else { completion(); return }
        
        ModuleFactory.network.fetchStock { [weak self] stocks in
            
            self?.stocksData = self?.convertStocksToMap(stocks: stocks)
            completion()
        }
    }
    private func convertStocksToMap(stocks: [StockElement]) -> [StockId: StockData]{
        var stocksData = [StockId: StockData]()
        
        stocks.forEach { stock in
            if let id = stock.id {
                stocksData["\(id)"] = StockData(stock: stock)
            }
        }
        return stocksData
    }
    
    private func convertRealtimeData(feeds: [Feed]?) -> [StockId: Feed] {
        
        var feedsData = [StockId: Feed]()
        
        feeds?.forEach { feed in
            if let id = feed.stockID {
                feedsData["\(id)"] = feed
            }
        }
        return feedsData
    }
    
    private func enrichData(feeds: [StockId: Feed]?) {
        
        guard let stocksData = self.stocksData,
              let time = self.lastUpdateTime else { return }
        
        feeds?.forEach({ (stockId: StockId, feed: Feed) in
            if let stockData = stocksData[stockId] {
                stockData.feedData = FeedData(feed: feed, time: time)
            }
        })
    }
    
    private func addHistoricalData() {
        stocksData?.forEach { (_, value: StockData) in
            value.saveHistorical()
        }
    }
    
    private func dispatchData() {
        self.delegate?.onFeedsUpdated(feedData: stocksData ?? [:])
    }
    
    private func fireTimer() {
        self.timer?.invalidate()
        
        guard delegate != nil else {
            return
        }
        
        self.timer = Timer.scheduledTimer(withTimeInterval: fetchInterval, repeats: false) { [weak self]timer in
            self?.fetchRemoteData()
        }
    }
}
