//
//  SerieService.swift
//  iSereis
//
//  Created by Filipe Amaral Neis on 29/06/19.
//  Copyright © 2019 Filipe Amaral Neis. All rights reserved.
//

import Foundation

protocol TmdbProtocol {
    func getDetailsSerie(idSerie: Int, completion: @escaping (Any, Bool) -> Void )
    func getDetailsSeason(idSerie: Int, seasonNumber: Int, completion: @escaping (Any, Bool) -> Void )
}

class SerieService: TmdbProtocol {
    
    private let endpPoint = Endpoint(type: .tmdb)
    
    func getDetailsSerie(idSerie: Int, completion: @escaping (Any, Bool) -> Void) {
        let url = EndPoints.getDetails(idSerie).url        
        DispatchQueue.global(qos: .background).async {
            self.endpPoint.get(url: url , parameters: nil, success: { (_, header, response) in
                let item = self.parseJson(response: response)
                completion(item, true)
            }, failure: { (_, error) in
                completion(error, false)
            })
        }
    }
    
    func getDetailsSeason(idSerie: Int, seasonNumber: Int, completion: @escaping (Any, Bool) -> Void) {
        let url = EndPoints.getDetailsSeason(idSerie, seasonNumber).url
        DispatchQueue.global(qos: .background).async {
            self.endpPoint.get(url: url , parameters: nil, success: { (_, header, response) in
                let item = self.parseJsonSeason(response: response)
                completion(item, true)
            }, failure: { (_, error) in
                completion(error, false)
            })
        }
    }
    
    private func parseJson(response: Any) -> Serie {
        guard let data = response as? Data else { return Serie() }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Serie.self, from: data)
        } catch let error {
            NSLog("Erro ao converter para Serie: %@", error.localizedDescription)
            return Serie()
        }
    }
    
    private func parseJsonSeason(response: Any) -> Season {
        guard let data = response as? Data else { return Season() }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Season.self, from: data)
        } catch let error {
            NSLog("Erro ao converter para Season: %@", error.localizedDescription)
            return Season()
        }
    }
    
//    func parseJson<T: Decodable>(response: Any) -> T? {
//        guard let data = response as? Data else { return nil }
//        do {
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            return try decoder.decode(T.self, from: data)
//        } catch let error {
//            NSLog("Erro ao converter: %@", error.localizedDescription)
//            return nil
//        }
//    }
}
