//
//  SerieViewModel.swift
//  iSereis
//
//  Created by Filipe Amaral Neis on 30/06/19.
//  Copyright © 2019 Filipe Amaral Neis. All rights reserved.
//

import Foundation

class SerieViewModel: SerieProtocol {
    
    var serie: Serie!
    
    init(with idSerie: Int, completion: @escaping (Serie) -> Void) {
        self.getDetails(idSerie: idSerie) { (_, serie) in
            self.serie = serie
            completion(serie)
        }
    }
    
    init(with serie: Serie) {
        self.serie = serie
    }
    
    init(with data: SerieData) {
        self.serie = Serie(id: Int(data.id),
        name: data.name,
        overview: data.overview,
        posterPath: data.posterPath,
        numberOfSeasons: Int(data.numberOfSeasons),
        numberOfEpisodes: Int(data.numberOfEpisodes),
        firstAirDate: data.firstAirDate,
        voteAverage: data.voteAverage,
//        isFavorite: data.isFavorite,
        seasons: [])
        
    }
    
    var id: Int {
        return serie.id ?? 0
    }
    
    
    var name: String {
        return serie.name ?? ""
    }
    
    var overview: String {
        return serie.overview ?? ""
    }
    
    var poster: String {
        if let path = serie.posterPath {
            return String(format: "%@%@", Constants.baseUrlImage, path)
        }
        
        return ""
    }
    
    var numberOfSeasons: Int {
        return serie.numberOfSeasons ?? 0
    }
    
    var numberOfEpisodes: Int {
        return serie.numberOfEpisodes ?? 0
    }
    
    var firstAirDate: String {
        return serie.firstAirDate ?? ""
    }
    
    var rating: Double {
        return serie.voteAverage ?? 0.0
    }
    
    var seasons: [Season] {
        return serie.seasons ?? []
    }
    
//    var isFavorite: Bool {
//        return serie.isFavorite
//    }
    
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
