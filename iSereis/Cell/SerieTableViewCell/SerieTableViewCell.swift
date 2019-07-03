//
//  SerieTableViewCell.swift
//  iSereis
//
//  Created by Filipe Amaral Neis on 30/06/19.
//  Copyright © 2019 Filipe Amaral Neis. All rights reserved.
//

import UIKit
import Kingfisher
class SerieTableViewCell: UITableViewCell {
    
    // MARK: - Outlet
    @IBOutlet weak var serieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var dateTitleLabel: UILabel!
    @IBOutlet weak var numberOfSeasonsLabel: UILabel!
    @IBOutlet weak var airDateLabel: UILabel!
    private let dataManger = DataManger()
    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    // MARK: - Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(with track: Track) {
        clearValues()
        setupActivityView()
        let _ = SerieViewModel(with: track.ids.tmdb) { [weak self] (serie) in
            self?.activityIndicator.removeFromSuperview()
            self?.setupCell(with: SerieViewModel(with: serie))
        }
        
    }
    
    private func setupCell(with viewModel: SerieViewModel) {
        self.dataManger.save(with: viewModel)
        self.titleLabel.text = viewModel.name
        self.overviewLabel.text = viewModel.overview
        self.numberOfSeasonsLabel.text = String(format: "%i Temp.",viewModel.numberOfSeasons)
        self.airDateLabel.text = viewModel.firstAirDate.dateFormated
        self.voteAverageLabel.text = String(format: "%.2f", viewModel.rating)
        if !viewModel.poster.isEmpty {            
            let url = URL(string: viewModel.poster)
            self.serieImageView.kf.setImage(with: url)
        }
        
    }
    
    private func setupActivityView() {
        activityIndicator.startAnimating()
        activityIndicator.color = .black
        activityIndicator.center =  contentView.center
        self.contentView.addSubview(activityIndicator)
    }
    
    private func clearValues() {
        self.titleLabel.text = ""
        self.overviewLabel.text = ""
        self.numberOfSeasonsLabel.text = ""
        self.airDateLabel.text = ""
        self.voteAverageLabel.text = ""
        self.imageView?.image = nil
    }
    
    // MARK: - Get Serie Details
    private func getDetails(idSerie: Int, completion: @escaping (Bool, Serie) -> Void) {
        SerieService().getDetailsSerie(idSerie: idSerie) {(response, isSuccess) in
            if isSuccess {
                completion(true, response as! Serie)
                return
            }
            completion(false, Serie())
        }
    }
    
    
}
