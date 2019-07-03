//
//  DataManager.swift
//  iSereis
//
//  Created by Filipe Amaral Neis on 02/07/19.
//  Copyright © 2019 Filipe Amaral Neis. All rights reserved.
//

import UIKit
import CoreData

protocol DataMangerProtocol {
    func save(with serie: SerieViewModel, isMyList: Bool)
    func addSerieMyList(with serie: SerieViewModel, isFavorite: Bool)
    func getAllSeries(filter mylist: Bool, completion: @escaping ([SerieData]) -> Void)
    func checkMyList(idSerie: Int, completion: @escaping (Bool) -> Void)
    
}

class DataManger: DataMangerProtocol {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SerieData")
    
    func save(with serie: SerieViewModel, isMyList: Bool = false) {
        
        fetchRequest.predicate = NSPredicate(format: "id = %i", serie.id)
        
        do{
            let values = try context.fetch(fetchRequest)
            if values.isEmpty {
                let data = SerieData(context: context)
                data.id = Int64(serie.id)
                data.name = serie.name
                data.overview = serie.overview
                data.posterPath = serie.poster
                data.voteAverage = serie.rating
                data.firstAirDate = serie.firstAirDate
                data.numberOfEpisodes = Int64(serie.numberOfEpisodes)
                data.numberOfSeasons = Int64(serie.numberOfSeasons)
                try self.context.save()
                return
            }
        } catch {
            NSLog("Falha ao salvar serie")
        }
    }
    
    func addSerieMyList(with serie: SerieViewModel, isFavorite: Bool) {
        fetchRequest.predicate = NSPredicate(format: "id = %i", serie.id)
        
        do{
            let values = try context.fetch(fetchRequest)
            if !values.isEmpty, let dataUpdate = values.first as? SerieData {
                dataUpdate.isFavorite = isFavorite
                try context.save()
            }
        } catch { NSLog("Falha ao salvar serie") }
        
    }
    
    func getAllSeries(filter mylist: Bool = false, completion: @escaping ([SerieData]) -> Void) {
        
        var series: [SerieData] = []
        do {
            if mylist {
                fetchRequest.predicate = NSPredicate(format: "isFavorite = 1")
            }
            
            let result = try self.context.fetch(fetchRequest)
            guard let seriesData = result as? [SerieData] else { return }
            series = seriesData
        } catch {
             NSLog("Falha ao carregar series")
        }
        
        completion(series)
    }
    
    func checkMyList(idSerie: Int, completion: @escaping (Bool) -> Void) {
        let predicate1 = NSPredicate(format: "id = %i", idSerie)
        let predicate2 = NSPredicate(format: "isFavorite = 1")
        let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate1,predicate2])
        fetchRequest.predicate = predicateCompound
        do{
            let values = try context.fetch(fetchRequest)
            completion(!values.isEmpty)
            
        } catch {
            NSLog("Falha checkMyList")
            completion(false)
        }
    }
    
//    private func getSeasons() -> [Season] {
//        var seasons: [Season] = []
//        
//        return seasons
//    }
//    
//    
//    private func getEpisodes() -> [Episode] {
//        var episodes: [Episode] = []
//        
//        return episodes
//    }
}

