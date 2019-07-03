//
//  Season.swift
//  iSereis
//
//  Created by Filipe Amaral Neis on 30/06/19.
//  Copyright © 2019 Filipe Amaral Neis. All rights reserved.
//

import Foundation

protocol SeasonProtocol {
    var id: Int { get }
    var airDate: String { get }
    var episodeCount: Int { get }
    var name: String { get }
    var overview: String { get }
    var posterPath: String { get }
    var seasonNumber: Int { get }
    var episodes: [Episode] { get }
}

class Season: Codable {
    
    var id: Int? = nil
    var airDate: String? = nil
    var episodeCount: Int? = nil
    var name: String? = nil
    var overview: String? = nil
    var posterPath: String? =  nil
    var seasonNumber: Int? = nil
    var episodes: [Episode]? = nil
}

