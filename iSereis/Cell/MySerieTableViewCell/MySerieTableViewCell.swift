//
//  MySerieTableViewCell.swift
//  iSereis
//
//  Created by Filipe Amaral Neis on 02/07/19.
//  Copyright © 2019 Filipe Amaral Neis. All rights reserved.
//

import UIKit

class MySerieTableViewCell: UITableViewCell {
    
    // MARK: - Outlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var serieImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var numberOfSeasonsLabel: UILabel!
    @IBOutlet weak var airDateLabel: UILabel!

    // MARK: - Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(with serie: SerieData) {
        let viewModel = SerieViewModel(with: serie)
        
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
}
