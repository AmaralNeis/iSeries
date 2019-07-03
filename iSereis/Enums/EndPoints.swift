//
//  TrackEndPoint.swift
//  iSereis
//
//  Created by Filipe Amaral Neis on 29/06/19.
//  Copyright © 2019 Filipe Amaral Neis. All rights reserved.
//

import Foundation


enum EndPoints {
    case getShowsPopular(Int, String)
    case getDetails(Int)
    case getDetailsSeason(Int, Int)
}
///tv/{tv_id}/season/{season_number}

extension EndPoints {
    var url : String {
        let baseTrack = Constants.baseUrlTrackShows
        let baseTmdb = Constants.baseUrlTmdbTV
        switch self {
        case .getShowsPopular(let page, let query):
            if(query.isEmpty) {
                return String(format: "%@/popular?page=%i", baseTrack, page)
            }
            return String(format: "%@/popular?page=%i&query=%@", baseTrack, page, query)
                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
        case .getDetails(let page): return String(format: "%@/%i?api_key=%@&language=pt-BR",
                                                  baseTmdb, page, Constants.apiKeyTmdb)
        case .getDetailsSeason(let idSeason, let seasonNumber):
            return String(format: "%@/%i/season/%i?api_key=%@&language=pt-BR",
                         baseTmdb, idSeason, seasonNumber, Constants.apiKeyTmdb)
        }
    }
}

