//
//  ScreenFactoryTyoe.swift
//  Plus500
//
//  Created by Bary Levy on 25/05/2021.
//

import UIKit

public enum ScreeId {
    case allFeeds(StocksViewController.ViewModel)
    case feedsDeatils(StockDetailsViewController.ViewModel)
}

public protocol ScreenFactoryType {
    func loadScreen(screenId: ScreeId) -> UIViewController
}
