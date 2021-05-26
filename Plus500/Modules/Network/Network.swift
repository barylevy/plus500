//
//  Network.swift
//  Plus500
//
//  Created by Bary Levy on 25/05/2021.
//

import Foundation
import Alamofire

public class Network: NetworkType {
    
    public func fetchRealTimeFeeds(ids: [StockId]?, comletion:@escaping (FeedsResponse)->()) {

        let url = ServerURL.urlRunning(route: .feeds)

        var parameters: [String: String]?
        if let ids = ids {
            parameters = ["ids": ids.joined(separator: ",")]
        }

        AF.request(url, method: .get, parameters: parameters).responseDecodable(of: FeedsResponse.self) { response in
            // TODO: handle errors
            comletion(try! response.result.get())
        }
    }
    
    public func fetchStock(completion: @escaping([StockElement])->()) {
        
        let url = ServerURL.urlRunning(route: .stock)
        AF.request(url).responseData { response in

            if let jsonData = try? response.result.get() {
                if let stocksData: [StockElement] = try? JSONDecoder().decode([StockElement].self, from: jsonData) {
                    completion(stocksData)
                } else {
                    // TODO: handle errors
                }
            }
        }
    }
}
