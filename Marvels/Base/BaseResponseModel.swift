//
//  BaseResponseModel.swift
//  Marvels
//
//  Created by Ekin Barış Demir on 16.08.2021.
//

import ObjectMapper

public class BaseResponseModel:  Mappable {
    
    @objc dynamic var status = false
    @objc dynamic var timestamp = ""
    @objc dynamic var message = ""
    @objc dynamic var debugMessage = ""
    @objc dynamic var errorCode = Int()
    @objc dynamic var subErrors = ""
    
    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        status              <- map["status"]
        timestamp              <- map["timestamp"]
        message             <- map["message"]
        debugMessage           <- map["debugMessage"]
        errorCode              <- map["errorCode"]
        subErrors              <- map["subErrors"]
    }
    
}

