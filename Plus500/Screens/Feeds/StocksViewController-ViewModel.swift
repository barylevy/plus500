//
//  StocksViewController-ViewModel.swift
//  Plus500
//
//  Created by Bary Levy on 25/05/2021.
//

import Foundation

extension StocksViewController {
    
    public class ViewModel: FeedType {        
        
        var items = [StockData]()
        
        var completionReload: (() -> Void)?
        
        var screenTitle: String { "Feeds" }
        
        func prepareData() {
            ModuleFactory.feedsManager.registerFeeds(stockIds: nil/* means all*/, delegate: self)
        }
        
        public func onFeedsUpdated(feedData: [StockId : StockData]) {
            self.items = feedData.map({ (key: StockId, value: StockData) -> StockData in
                value
            })
            self.completionReload?()
        }
    }
}
