//
//  NetworkType.swift
//  Plus500
//
//  Created by Bary Levy on 25/05/2021.
//

import Foundation

public protocol NetworkType: AnyObject {
    func fetchRealTimeFeeds(ids:[StockId]?, comletion:@escaping (FeedsResponse)->())
    
    func fetchStock(completion: @escaping([StockElement])->()) 
}

