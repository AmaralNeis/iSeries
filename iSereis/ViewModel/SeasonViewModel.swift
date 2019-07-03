//
//  SeasonViewModel.swift
//  iSereis
//
//  Created by Filipe Amaral Neis on 30/06/19.
//  Copyright © 2019 Filipe Amaral Neis. All rights reserved.
//

import Foundation

class SeasonViewModel: SeasonProtocol {
    
    var season: Season!
    
    init(with season: Season) {
        self.season = season
    }
    
    init(idSeason: Int, seasonNumber: Int, completion: @escaping (Season) -> Void) {
        getDetailsSeason(idSerie: idSeason, seasonNumber: seasonNumber) { (_, season) in
            completion(season)
        }
    }
    
    var id: Int {
        return season.id ?? 0
    }
    
    var airDate: String {
        return season.airDate ?? ""
    }
    
    var episodeCount: Int {
        return season.episodeCount ?? 0
    }
    
    var name: String {
        return season.name ?? ""
    }
    
    var overview: String {
        return season.overview ?? ""
    }
    
    var posterPath: String {
        return season.posterPath ?? ""
    }
    
    var seasonNumber: Int {
        return season.seasonNumber ?? 0
    }
    var episodes: [Episode] {
        return season.episodes ?? []
    }
    
    private func getDetailsSeason(idSerie: Int, seasonNumber: Int, completion: @escaping (Bool, Season) -> Void) {
        SerieService().getDetailsSeason(idSerie: idSerie, seasonNumber: seasonNumber,
                                        completion: { (response, isSuccess) in
            completion(isSuccess, response as! Season)
        })
    }
}
