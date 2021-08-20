//
//  ResultModel.swift
//  Marvels
//
//  Created by Ekin Barış Demir on 16.08.2021.
//

import Foundation
import UIKit
import ObjectMapper


class ResultModel: BaseResponseModel {
    
    
    var id: Int?
    var name: String?
    var description: String?
    var thumbnail: Thumbnail?
    var resourceURI: String?
    var comics: Comics?
    var series: Series?
    var stories: Stories?
    var events: Events?
    var urls: [Urls]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["id"]
        name <- map["name"]
        description <- map["description"]
        thumbnail <- map["thumbnail"]
        resourceURI <- map["resourceURI"]
        comics <- map["comics"]
        series <- map["series"]
        stories <- map["stories"]
        events <- map["events"]
        urls <- map["urls"]

    }
}

class Thumbnail: BaseResponseModel {
    var path: String?
    var `extension`: String?

    enum CodingKeys: String, CodingKey {
        case `extension` = "extension"
        case path = "path"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        path <- map["path"]
        `extension` <- map["`extension`"]
        
    }
}


class Comics: BaseResponseModel {
    var available: Int?
    var collectionURI: String?
    var items: [Itemm]?
    var returned: Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        available <- map["available"]
        collectionURI <- map["collectionURI"]
        items <- map["items"]
        returned <- map["returned"]

        
    }
    
}
class Urls: BaseResponseModel {
    var type: String?
    var url: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        type <- map["type"]
        url <- map["url"]
        
    }
}

class Itemm: BaseResponseModel {
    var resourceURI: String?
    var name: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        resourceURI <- map["resourceURI"]
        name <- map["name"]
        
    }
}


class Series: BaseResponseModel {
    var available: Int?
    var collectionURI: String?
    var items: [Itemm]?
    var returned: Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        available <- map["available"]
        collectionURI <- map["collectionURI"]
        items <- map["items"]
        returned <- map["returned"]

    }
}

class Stories: BaseResponseModel {
    var available: Int?
    var collectionURI: String?
    var items: [Itemss]?
    var returned: Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        available <- map["available"]
        collectionURI <- map["collectionURI"]
        items <- map["items"]
        returned <- map["returned"]
        
    }
}

class Itemss: BaseResponseModel {
    var resourceURl: String?
    var name: String?
    var type: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        resourceURl <- map["resourceURl"]
        name <- map["name"]
        type <- map["type"]

    }
}

class Events: BaseResponseModel {
    var available: Int?
    var collectionURI: String?
    var items: [Itemm]?
    var returned: Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        available <- map["available"]
        collectionURI <- map["collectionURI"]
        items <- map["items"]
        returned <- map["returned"]
        
    }
}



class Items : BaseResponseModel {
    var resourceURI : String?
    var name : String?
    var role : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        resourceURI <- map["resourceURI"]
        name <- map["name"]
        role <- map["role"]
        
    }
}

