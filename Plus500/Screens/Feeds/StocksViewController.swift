//
//  ViewController.swift
//  Plus500
//
//  Created by Bary Levy on 25/05/2021.
//

import UIKit

public class StocksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var router = Router()
    
    var viewModel: ViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        title = viewModel.screenTitle
        
        viewModel.completionReload = { [weak self] in
            self?.tableView.reloadData()
        }
        
        self.title = viewModel.screenTitle
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.prepareData()        
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feedData = viewModel.items[indexPath.row]
        let cell = tableView.dequeueCell(cellType: FeedCell.self, for: indexPath)
        cell.configureCell(feedData: feedData)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let stockData = viewModel.items[indexPath.row]
        router.showStockDetails(parent: self, stockData: stockData)
    }
}

