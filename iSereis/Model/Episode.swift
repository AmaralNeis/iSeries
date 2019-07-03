//
//  Episode.swift
//  iSereis
//
//  Created by Filipe Amaral Neis on 01/07/19.
//  Copyright © 2019 Filipe Amaral Neis. All rights reserved.
//

import Foundation

protocol EpisodeProtocol {
    var stillPath: String { get }
    var name: String { get }
    var overview: String { get }
    var episodeNumber: Int { get }
    var airDate: String { get }
}

struct Episode: Codable {
    var stillPath: String? = nil
    var name: String? = nil
    var overview: String? = nil
    var episodeNumber: Int? = nil
    var airDate: String? = nil
}
