//
//  API.swift
//  Marvels
//
//  Created by Ekin Barış Demir on 16.08.2021.
//

import Foundation
import Alamofire
class API {
    
    static let sharedManager = API()
    private var sessionManager = SessionManager()
    private init() { }
    private let ts = "1"
    private let apiKey = "453a2f649b48728a377d1e793eaeb5cc"
    private let hash = "d8c67412160cc9867e95fcf658bfe806"
    
    
    fileprivate let encoding = JSONEncoding.default
    
    func getMarvels(itemCount: Int, sucees:@escaping ((_ status: MarvelResponse)-> Void), errorHandler:@escaping ((_ status: Bool)-> Void)){
        
        let endpoint = "http://gateway.marvel.com/v1/public/characters?ts=\(ts)&apikey=\(apiKey)&hash=\(hash)&offset=\(itemCount)"
        sessionManager.request(endpoint, method: .get,encoding: JSONEncoding.default).responseData { (response) in
            let result = response.result
            switch result {
                case .success(let data):
                    do {
                        let responseArray = try JSONDecoder().decode(MarvelResponse.self, from: data)
                        sucees(responseArray)
                    } catch  {
                        errorHandler(true)
                    }
                case .failure(_ ):
                    errorHandler(true)
            }
        }
    }

}


