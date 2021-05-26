//
//  StocksViewController-Router.swift
//  Plus500
//
//  Created by Bary Levy on 25/05/2021.
//

import UIKit

extension StocksViewController {    
    
    class Router {
        func showStockDetails(parent: UIViewController, stockData: StockData) {
            let viewModel = StockDetailsViewController.ViewModel(stockData: stockData)
            let vc = ModuleFactory.screenFactory.loadScreen(screenId: .feedsDeatils(viewModel))
            parent.show(vc, sender: parent)
        }
    }
}
