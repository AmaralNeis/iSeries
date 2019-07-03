//
//  SerieDetailsViewController.swift
//  iSereis
//
//  Created by Filipe Amaral Neis on 30/06/19.
//  Copyright © 2019 Filipe Amaral Neis. All rights reserved.
//

import UIKit

class SerieDetailsViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    // MARK: - Properties
    private var serieViewModel: SerieViewModel!
    private var idSerie: Int!
    private let activityIndicator = UIActivityIndicatorView(style: .white)

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.hiddenViewDetail(isHidden: true)
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.startAnimating()
        let _ = SerieViewModel(with: idSerie) { [weak self] (serie) in
            self?.serieViewModel = SerieViewModel(with: serie)
            DispatchQueue.main.async {
                self?.update()
            }
        }
    }
    
    // MARK: - Create
    static func create(idSerie: Int) -> SerieDetailsViewController {
        let identifier = String.init(describing: SerieDetailsViewController.self)
        let viewController = UIStoryboard(name: "TVShow", bundle: nil)
            .instantiateViewController(withIdentifier: identifier) as! SerieDetailsViewController
        viewController.idSerie = idSerie
        return viewController
    }
    
    // MARK: - Methods
    private func update() {
        setupTitle()
        setupTableView()
        self.overviewLabel.text = serieViewModel.overview
        self.hiddenViewDetail(isHidden: false)
        self.activityIndicator.removeFromSuperview()
        DataManger().checkMyList(idSerie: serieViewModel.id) { (isMyList) in
            self.addButton.isEnabled = !isMyList
            self.addButton.alpha = isMyList ? 0.5 : 1.0
        }
    }
    
    private func setupTitle() {
        self.navigationItem.title = serieViewModel.name
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }    
    
    // MARK: - Actions
    @IBAction func addMyList(_ sender: Any) {
        DataManger().addSerieMyList(with: serieViewModel, isFavorite: true)
        self.addButton.isEnabled = false
        self.addButton.alpha = 0.4
    }
}

extension SerieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serieViewModel.seasons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = serieViewModel.seasons[indexPath.row].name
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let number = serieViewModel.seasons[indexPath.row].seasonNumber ?? 0
        let name = serieViewModel.seasons[indexPath.row].name
        let controller = EpisodeViewController.create(idSeason: idSerie,
                                                      seasonNumber: number,
                                                      title: name)
        self.navigationController?.pushViewController(controller, animated: true)
    }
        
}
