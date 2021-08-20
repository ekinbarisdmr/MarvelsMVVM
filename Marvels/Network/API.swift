//
//  API.swift
//  Marvels
//
//  Created by Ekin Barış Demir on 16.08.2021.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class API {
    
    static let sharedManager = API()
    private var sessionManager = SessionManager()
    private init() { }
    private let ts = "1"
    private let apiKey = "453a2f649b48728a377d1e793eaeb5cc"
    private let hash = "d8c67412160cc9867e95fcf658bfe806"

    fileprivate let encoding = JSONEncoding.default

    func getMarvels(itemCount: Int, completion: @escaping (MarvelResponse?, Error?) -> Void) {
        let endpoint = "http://gateway.marvel.com/v1/public/characters?ts=\(ts)&apikey=\(apiKey)&hash=\(hash)&offset=\(itemCount)"
        
        request(endpoint: .getMarvels, method: .get, endpointURL: endpoint).responseObject {
            (response: DataResponse<MarvelResponse>) in self.handle(response: response, completion: completion)
        }
    }
    
    func getDetails(characterId: Int, completion: @escaping (ResultModel?, Error?) -> Void) {
        let endpoint = "http://gateway.marvel.com/v1/public/characters/\(characterId)?ts=\(ts)&apikey=\(apiKey)&hash=\(hash)"
        
        request(endpoint: .getDetails, method: .get, endpointURL: endpoint).responseObject { (response: DataResponse<ResultModel>) in self.handle(response: response, completion: completion)
            
        }
    }
}

extension API {
    
    fileprivate func handle<T>(response: DataResponse<T>, completion: @escaping (T?, Error?) -> Void) {
        
        if response.error != nil {
            completion(nil, response.error)
        }
        if let responseResultValue = response.result.value {
            completion(responseResultValue, nil)
        }
        else {
            completion(nil, response.result.error)
        }
    }
}

extension API {
    
    fileprivate func request(endpoint: Endpoint,method: HTTPMethod, endpointURL: String) -> DataRequest {
        
        return sessionManager.request(endpointURL,
                                      method: method,
                                      encoding: API.sharedManager.encoding)
    }
    
    enum Endpoint {
        case getMarvels
        case getDetails
    }
}
