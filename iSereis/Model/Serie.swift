//
//  Serie.swift
//  iSereis
//
//  Created by Filipe Amaral Neis on 29/06/19.
//  Copyright © 2019 Filipe Amaral Neis. All rights reserved.
//

import Foundation

protocol SerieProtocol {
    var id: Int { get }
    var name: String { get }
    var overview: String { get }
    var poster: String { get }
    var numberOfSeasons: Int { get }
    var numberOfEpisodes: Int { get }
    var firstAirDate: String { get }
    var rating: Double { get }
    var seasons: [Season] { get }
//    var isFavorite: Bool { get }
}

struct Serie: Codable {
    var id: Int? = nil
    var name: String? =  nil
    var overview: String? =  nil
    var posterPath: String? =  nil
    var numberOfSeasons: Int? =  nil
    var numberOfEpisodes: Int? =  nil
    var firstAirDate: String? =  nil
    var voteAverage: Double? =  nil
//    var isFavorite: Bool = false
    var seasons: [Season]? = []

}
