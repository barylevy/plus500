// StockDetailsViewController.swift
// Plus500
//
// Created by Bary Levy on 25/05/2021.
//

import UIKit

public class StockDetailsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: StockDetailsViewController.ViewModel!
    
    public override func viewDidLoad() {
        
        tableView.dataSource = self
        
        viewModel.completionReload = { [weak self] in
            self?.tableView.reloadData()
        }
        title = viewModel.screenTitle
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.prepareData()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.feeds.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data: FeedHistoricalData = viewModel.feeds[indexPath.row]
        
        let cell = tableView.dequeueCell(cellType: FeedHistoricalCell.self, for: indexPath)
        cell.configureCell(data: data)
        return cell
    }
}
