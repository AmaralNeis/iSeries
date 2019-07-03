//
//  Track.swift
//  iSereis
//
//  Created by Filipe Amaral Neis on 29/06/19.
//  Copyright © 2019 Filipe Amaral Neis. All rights reserved.
//

import Foundation

struct Track: Codable {
    var title: String
    var year: Int
    var ids: Ids
}

struct Ids: Codable {
    var tmdb: Int
}

struct Page {
    var currentPage: Int
    var totalPage: Int
    
    init(currentPage: Int = 0, totalPage: Int = 0) {
        self.currentPage = currentPage
        self.totalPage = totalPage
    }
}

struct TrackPage {
    var page: Page
    var track: [Track] = []
}
