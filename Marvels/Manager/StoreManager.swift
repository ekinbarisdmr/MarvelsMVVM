//
//  StoreManager.swift
//  Marvels
//
//  Created by Ekin Barış Demir on 16.08.2021.
//

import Foundation

class StoreManager {
    
    static let shared = StoreManager()
    
    
    private static func storeLikesArray(data : [LikeModel]) -> NSData {
        
        return NSKeyedArchiver.archivedData(withRootObject: data as NSArray) as NSData
    }
    
    
    func loadLikesArray() -> [LikeModel]? {
        
        if let unarchivedObject = UserDefaults.standard.object(forKey: "likesArray") as? Data {
            
            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? [LikeModel]
        }
        
        return nil
    }
    
    func saveLikesArray(data : [LikeModel]?) {
        
        let archivedObject = StoreManager.storeLikesArray(data: data!)
        UserDefaults.standard.set(archivedObject, forKey: "likesArray")
        UserDefaults.standard.synchronize()
    }
    
    func getLikesArray() -> [LikeModel] {
        var likesArray: [LikeModel] = [LikeModel]()
        if StoreManager.shared.loadLikesArray() == nil {
            StoreManager.shared.saveLikesArray(data: likesArray)
        }
        else {
            likesArray = StoreManager.shared.loadLikesArray() ?? []
        }
        return likesArray
    }
    
}

