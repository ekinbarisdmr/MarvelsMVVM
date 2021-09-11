//
//  ResultModel.swift
//  Marvels
//
//  Created by Ekin Barış Demir on 16.08.2021.
//

import Foundation
import UIKit
class ResultModel: Codable {
    
    
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
    
 
}

class Thumbnail: Codable {
    var path: String?
    var `extension`: String?

    enum CodingKeys: String, CodingKey {
        case `extension` = "extension"
        case path = "path"
    }
    

}


class Comics: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [Itemm]?
    var returned: Int?
    

    
}
class Urls: Codable {
    var type: String?
    var url: String?
    

}

class Itemm: Codable {
    var resourceURI: String?
    var name: String?
    

}


class Series: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [Itemm]?
    var returned: Int?
    

}

class Stories: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [Itemss]?
    var returned: Int?
    

}

class Itemss: Codable {
    var resourceURl: String?
    var name: String?
    var type: String?
    

}

class Events: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [Itemm]?
    var returned: Int?
    

}



class Items : Codable {
    var resourceURI : String?
    var name : String?
    var role : String?

    
}

