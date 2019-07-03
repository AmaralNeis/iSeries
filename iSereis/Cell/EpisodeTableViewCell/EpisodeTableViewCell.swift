//
//  EpisodeTableViewCell.swift
//  iSereis
//
//  Created by Filipe Amaral Neis on 01/07/19.
//  Copyright © 2019 Filipe Amaral Neis. All rights reserved.
//

import UIKit
import Kingfisher

class EpisodeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(with episode: Episode) {
        let viewModel = EpisodeViewModel(with: episode)
        titleLabel.text = viewModel.name
        overviewLabel.text = viewModel.overview
        if !viewModel.stillPath.isEmpty {
            let url = URL(string: viewModel.stillPath)    
            photoImageView.kf.setImage(with: url)
        }        
    }
}
