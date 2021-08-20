//
//  MarvelResponse.swift
//  Marvels
//
//  Created by Ekin Barış Demir on 16.08.2021.
//

import Foundation
import UIKit
import ObjectMapper


class MarvelResponse: BaseResponseModel {
    var code: Int?
    var statuss: String?
    var copyright: String?
    var attributionText: String?
    var attributionHTML: String?
    var etag: String?
    var data: Dataa?
    
    
    private enum CodingKeys : String, CodingKey {
           case status = "status"
       }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        code <- map["code"]
        statuss <- map["statuss"]
        copyright <- map["copyright"]
        attributionText <- map["attributionText"]
        attributionHTML <- map["attributionHTML"]
        etag <- map["etag"]
        data <- map["data"]

    }
    
    
}

class Dataa: BaseResponseModel {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [ResultModel]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        offset <- map["offset"]
        limit <- map["limit"]
        total <- map["total"]
        count <- map["count"]
        results <- map["results"]
      

    }
}
