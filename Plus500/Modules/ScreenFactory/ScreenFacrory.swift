//
//  ScreenFacrory.swift
//  Plus500
//
//  Created by Bary Levy on 25/05/2021.
//

import UIKit

class ScreenFactory: ScreenFactoryType {
    
    public func loadScreen(screenId: ScreeId) -> UIViewController {
        
        switch screenId {
        case .allFeeds(let viewModel):
            let vc = Self.loadVCFromStoryBoard(type: StocksViewController.self)
            vc.viewModel = viewModel
            return vc
            
        case .feedsDeatils(let viewModel):
            let vc = Self.loadVCFromStoryBoard(type: StockDetailsViewController.self)
            vc.viewModel = viewModel            
            return vc
        }
    }
    
    private static func loadVCFromStoryBoard<T: UIViewController>(type: T.Type) -> T {
        let name = String(describing: T.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! T
        return vc
        
    }
    
    
}
