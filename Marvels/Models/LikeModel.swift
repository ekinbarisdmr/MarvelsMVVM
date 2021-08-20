//
//  LikeModel.swift
//  Marvels
//
//  Created by Ekin Barış Demir on 16.08.2021.
//

import Foundation

class LikeModel: NSObject, NSCoding  {
    
    var characterId: String
    
    required init(characterId: String) {
        self.characterId = characterId
    }
    
    required init(coder aDecoder: NSCoder) {
        characterId = (aDecoder.decodeObject(forKey: "characterId")) as! String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(characterId, forKey: "characterId")
    }
}

