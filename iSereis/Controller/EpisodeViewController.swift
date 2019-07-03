//
//  EpisodeViewController.swift
//  iSereis
//
//  Created by Filipe Amaral Neis on 01/07/19.
//  Copyright © 2019 Filipe Amaral Neis. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    private var seasonViewModel: SeasonViewModel!
    private var idSeason: Int!
    private var seasonNumber: Int!
    private let identifier = "episodeTableViewCell"
    private var titleSeason: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = titleSeason
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.tableFooterView = UIView()
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        let _ = SeasonViewModel(idSeason: idSeason, seasonNumber: seasonNumber) { [weak self] (season) in
            self?.seasonViewModel = SeasonViewModel(with: season)
            DispatchQueue.main.async {
                self?.update()
            }
        }
    }
    
    // MARK: - Create
    static func create(idSeason: Int, seasonNumber: Int, title: String?) -> EpisodeViewController {
        let identifier = String.init(describing: EpisodeViewController.self)
        let viewController = UIStoryboard(name: "TVShow", bundle: nil)
            .instantiateViewController(withIdentifier: identifier) as! EpisodeViewController
        viewController.idSeason = idSeason
        viewController.seasonNumber = seasonNumber
        viewController.titleSeason = title
        return viewController
    }
    
    // MARK: - Methods
    
    private func update() {
        setupTableView()
        self.activityIndicator.removeFromSuperview()
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        registerCell()
        
    }
    
    private func registerCell() {
        let nib = UINib(nibName: String.init(describing: EpisodeTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
}

extension EpisodeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasonViewModel.episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let cell = cell as? EpisodeTableViewCell {
            cell.setupCell(with: seasonViewModel.episodes[indexPath.row])
        }
        return cell
    }
}
