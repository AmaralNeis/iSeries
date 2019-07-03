//
//  ItemsViewModel.swift
//  iSereis
//
//  Created by Filipe Amaral Neis on 29/06/19.
//  Copyright © 2019 Filipe Amaral Neis. All rights reserved.
//

class ItemsViewModel {
    var items: [Track] = []
    var error: Error?
    var refreshing = false
    
    private let trackService: TrackService = TrackService()
    
    func fetch(page: Int, query: String = "", completion: @escaping (Bool, Any) -> Void) {
        refreshing = true
        trackService.fetch(page: page, query: query, completion: { [weak self] (response, isSuccess) in
            self?.refreshing = false
            
            if isSuccess {
                guard let trackPage =  response as? TrackPage else { completion(false, []); return }
                self?.items = trackPage.track
                completion(true, trackPage)
                return
            }
            completion(false, [])
        })
    }
}
