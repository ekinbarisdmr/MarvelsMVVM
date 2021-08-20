//
//  DetailsCellModel.swift
//  Marvels
//
//  Created by Ekin Barış Demir on 16.08.2021.
//

import Foundation


class DetailsCellModel: NSObject {
    
    var resultModel: ResultModel?
    var placeHolder = "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg"
    
    init(resultModel: ResultModel = ResultModel()) {
        self.resultModel = resultModel
    }
}

extension DetailsCellModel: DetailsTableViewCellDataSource {
    
    
    func imageForCell(_ cell: DetailsTableViewCell) -> URL {
        if let path = resultModel?.thumbnail?.path, let imageUrl = URL(string: path + ".jpg") {
            return imageUrl
        }
        else {
            return URL(string: self.placeHolder)!
        }
    }
    
    func nameForCell(_ cell: DetailsTableViewCell) -> String {
        if let name = resultModel?.name {
            return name
        }
        else {
            return ""
        }
    }
    
    
    func seriesForCell(_ cell: DetailsTableViewCell) -> String {
        var seriesLabel = ""
        if let seriesList = resultModel?.series?.items {
            for series in seriesList {
                seriesLabel += "- \(series.name ?? "") \n"
            }
            return seriesLabel
        }
        else {
            return ""
        }
        
    }
    
    func comicForCell(_ cell: DetailsTableViewCell) -> String {
        var comicsLabel = ""
        if let comicsList = resultModel?.comics?.items {
            for comic in comicsList {
                comicsLabel += "- \(comic.name ?? "") \n"
            }
            return comicsLabel
        }
        else {
            return ""
        }
    }
    
    func eventsForCell(_ cell: DetailsTableViewCell) -> String {
        var eventsLabel = ""
        if let eventsList = resultModel?.events?.items {
            for event in eventsList {
                eventsLabel += "- \(event.name ?? "") \n"
            }
            return eventsLabel
        }
        else {
            return ""
        }
    }
    
    func storiesForCell(_ cell: DetailsTableViewCell) -> String {
        var storiesLabel = ""
        if let storiesList = resultModel?.stories?.items {
            for story in storiesList {
                storiesLabel += "- \(story.name ?? "") \n"
            }
            return storiesLabel
        }
        else {
            return ""
        }
    }
    
    
}
