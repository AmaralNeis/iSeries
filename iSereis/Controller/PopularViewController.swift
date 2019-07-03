//
//  ViewController.swift
//  iSereis
//
//  Created by Filipe Amaral Neis on 29/06/19.
//  Copyright © 2019 Filipe Amaral Neis. All rights reserved.
//

import UIKit

class PopularViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private let searchController = UISearchController(searchResultsController: nil)
    private let viewModel = ItemsViewModel()
    private var identifier = "serieTableViewCell"
    private var previousRun = Date()
    private let minInterval = 0.05
    private var refresher: UIRefreshControl!
    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    private var page: Int = 0
    private var totalPage: Int = 1
    
    private var tracks = [Track]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: — View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupTableView()
        setupSearchBar()
        fetchResults()
    }
    
    // MARK: - Methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        self.refresher = UIRefreshControl()
        self.refresher.tintColor = .gray
        self.refresher?.addTarget(self, action: #selector(self.refresh(sender:)), for: UIControl.Event.valueChanged)
        self.tableView?.addSubview(refresher!)
        tableView.tableFooterView = UIView()
        registerCell()
        setupBackgroundTableView()
    }
    
    private func registerCell() {
        let nib = UINib(nibName: String.init(describing: SerieTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
    private func setupBackgroundTableView() {
        let backgroundViewLabel = UILabel(frame: .zero)
        backgroundViewLabel.textColor = .darkGray
        backgroundViewLabel.numberOfLines = 0
        backgroundViewLabel.text = "Oops, nenhuma serie encontrada"
        backgroundViewLabel.textAlignment = NSTextAlignment.center
        backgroundViewLabel.font.withSize(20)
        tableView.backgroundView = backgroundViewLabel
    }
    
    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Informe o nome da serie"
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    private func initValues(textToSearch: String = "") {
        self.page = 0
        tracks.removeAll()
        fetchResults(for: textToSearch)
        
    }
    
    private func fetchResults(for text: String = "", isRefresher: Bool = false) {
        page += 1
        if !(self.page <= self.totalPage) {
            return
        }
        viewModel.fetch(page: page, query: text) { [weak self](isSuccess, trackPage) in
            self?.dimmissLoading(isRefresher: isRefresher)
            if isSuccess {
                let trackPage = trackPage as! TrackPage
                self?.totalPage = trackPage.page.totalPage
                self?.page = trackPage.page.currentPage
                self?.tracks.append(contentsOf: trackPage.track)
            }
            
            self?.tableView.reloadData()
        }
    }
    private func dimmissLoading(isRefresher: Bool) {
        if isRefresher {
            self.refresher.endRefreshing()
        } else {
            self.activityIndicator.removeFromSuperview()
        }
    }
    // MARK: - Actions
    @objc func refresh(sender: AnyObject) {
        self.page = 1
        self.totalPage = 1
        fetchResults(isRefresher: true)
    }
}

extension PopularViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        guard let textToSearch = searchBar.text, !textToSearch.isEmpty else {
            initValues()
            return
        }
        
        if Date().timeIntervalSince(previousRun) > minInterval {
            previousRun = Date()
            initValues(textToSearch: textToSearch)        
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        initValues()
    }
    
}

extension PopularViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let cell = cell as? SerieTableViewCell {
            cell.setupCell(with: tracks[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let idSerie = tracks[indexPath.row].ids.tmdb
        let viewController = SerieDetailsViewController.create(idSerie: idSerie)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tracks.count - 4 && tracks.count >= 10  {
            fetchResults()
        }
    }
}

