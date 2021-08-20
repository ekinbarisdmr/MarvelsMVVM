//
//  MarvelGridCellModel.swift
//  Marvels
//
//  Created by Ekin Barış Demir on 16.08.2021.
//

import Foundation

class MarvelGridCellModel: NSObject {
    
    var resultModel: ResultModel?
    var placeHolder = "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg"
   
    init(resultModel: ResultModel = ResultModel()) {
        self.resultModel = resultModel
    }
}


extension MarvelGridCellModel: MarvelGridCollectionViewCellDataSource {
    
    func imageForCell(_ cell: MarvelGridCollectionViewCell) -> URL {
        
        if let path = resultModel?.thumbnail?.path, let imageUrl = URL(string: path + "." + "jpg") {
            return imageUrl
        }
        else {
            return URL(string: self.placeHolder)!
        }
        
    }
    
    func titleForCell(_ cell: MarvelGridCollectionViewCell) -> String {
        if let title = resultModel?.name {
            return title
        }
        else {
            return ""
        }
    }
    
    func seriesForCell(_ cell: MarvelGridCollectionViewCell) -> String {
        
        if let series = resultModel?.series?.available {
            return "\(series) Series"
        }
        else {
            return "0"
        }
    }
}
