//
//  TrackService.swift
//  iSereis
//
//  Created by Filipe Amaral Neis on 29/06/19.
//  Copyright © 2019 Filipe Amaral Neis. All rights reserved.
//

import Foundation

protocol TrackProtocol {
    func fetch(page: Int, query: String, completion: @escaping (Any, Bool) -> Void)
}

class TrackService: TrackProtocol {
    
    private let endpPoint = Endpoint(type: .track)
    
    func fetch(page: Int,  query: String = "", completion: @escaping (Any, Bool) -> Void) {
        let url = EndPoints.getShowsPopular(page, query).url
        print(url)
        DispatchQueue.global(qos: .background).async {
            self.endpPoint.get(url: url , parameters: nil, success: { (_, header, response) in
                let itens = self.parseJson(response: response)
                var page: Page = Page()
                if(!itens.isEmpty) {
                    page = self.endpPoint.readHeaderTrack(header: header)
                }
                let trackPage =  TrackPage(page: page, track: itens)
                completion(trackPage, !itens.isEmpty)
            }, failure: { (_, error) in
                completion(error, false)
            })
        }
    }
    
    private func parseJson(response: Any) -> [Track] {
        guard let data = response as? Data else { return [] }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result: [Track] = try decoder.decode([Track].self, from: data)
            return result
        } catch let error {
            NSLog("Erro ao converter para JSON: %@", error.localizedDescription)
            return []
        }
    }
}
