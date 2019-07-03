//
//  MySeriesViewController.swift
//  iSereis
//
//  Created by Filipe Amaral Neis on 02/07/19.
//  Copyright © 2019 Filipe Amaral Neis. All rights reserved.
//

import UIKit

class MySeriesViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - properties
    private let dataManger = DataManger()
    private var series: [SerieData] = []
    private let identifier = "mySerieTableViewCell"
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
//        initSeries()
    }
    override func viewWillAppear(_ animated: Bool) {
        initSeries()
    }
    
    // MARK: - Methods
    private func initSeries() {
        dataManger.getAllSeries(filter: true) { [weak self] (series) in
            self?.series = series
            self?.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource  = self
        self.tableView.tableFooterView = UIView()
        registerCell()
    }
    
    private func registerCell() {
        let nib = UINib(nibName: String.init(describing: MySerieTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
    // MARK: - Create
    static func create() -> MySeriesViewController {
        let identifier = String.init(describing: MySeriesViewController.self)
        let viewController = UIStoryboard(name: "MyTVShows", bundle: nil)
            .instantiateViewController(withIdentifier: identifier) as! MySeriesViewController
        return viewController
    }
    
}

extension MySeriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return series.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        if let cell = cell as? MySerieTableViewCell {
            cell.setupCell(with: series[indexPath.row])
        }
        
        return cell
    }
    
    
    
}
