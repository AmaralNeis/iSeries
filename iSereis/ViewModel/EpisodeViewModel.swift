//
//  EpisodeViewModel.swift
//  iSereis
//
//  Created by Filipe Amaral Neis on 01/07/19.
//  Copyright © 2019 Filipe Amaral Neis. All rights reserved.
//

import Foundation

class EpisodeViewModel: EpisodeProtocol {
    
    let episode: Episode
    
    init(with episode: Episode) {
        self.episode = episode
    }
    
    var stillPath: String {
        if let path = episode.stillPath {
            return String(format: "%@%@", Constants.baseUrlImage, path)
        }
        
        return ""
    }
    
    var name: String {
        return episode.name ?? ""
    }
    
    var overview: String {
        return episode.overview ?? ""
    }
    
    var episodeNumber: Int {
        return episode.episodeNumber ?? 0
    }
    
    var airDate: String {
        return episode.airDate ?? ""
    }
    
}
