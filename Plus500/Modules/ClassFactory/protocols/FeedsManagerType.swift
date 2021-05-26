//
//  FeedsManagerProtocol.swift
//  Plus500
//
//  Created by Bary Levy on 25/05/2021.
//

import Foundation

public protocol FeedsManagerType {
    func registerFeeds(stockIds: [StockId]?, delegate: FeedType)
}

public protocol FeedType: AnyObject {
    func onFeedsUpdated(feedData: [StockId: StockData])
}

