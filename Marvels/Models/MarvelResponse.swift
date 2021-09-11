//
//  MarvelResponse.swift
//  Marvels
//
//  Created by Ekin Barış Demir on 16.08.2021.
//

import Foundation
import UIKit


class MarvelResponse: Codable {
    
    var code: Int?
    var statuss: String?
    var copyright: String?
    var attributionText: String?
    var attributionHTML: String?
    var etag: String?
    var data: Dataa?
    
}

class Dataa: Codable {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [ResultModel]?

    
}
