//
//  NetworkClientStub.swift
//  RandomUsersTests
//
//  Created by Kirian Anglès on 2/12/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

class NetworkClientStub: NetworkClient {
    private let filename: String
    
    init(filename: String) {
        self.filename = filename
    }
    
    func requestObject<T: Mappable>(with definition: APIDefinition) -> Single<T> {
        if let data = NetworkClientStub.read(filename) {
            do {
                if let jsonString = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                    let object: T = Mapper<T>().map(JSON: jsonString) {
                    return Single.just(object)
                }
            } catch {
                print("Couldn't parse object from contents of \(filename).json")
            }
        }
        print("Couldn't read contents of \(filename).json")
        
        return Single.error(NSError(domain: "Couldn't read contents of \(filename).json", code: 0, userInfo: nil))
    }
    
    func requestArray<T: Mappable>(with definition: APIDefinition) -> Single<[T]> {
        if let data = NetworkClientStub.read(filename) {
            do {
                if let jsonString = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                    let array = jsonString[definition.path]
                    let objectArray: [T] = Mapper<T>().mapArray(JSONArray: array as! [[String : Any]])
                    
                    if let results:UInt16 = definition.parameters?["results"] as? UInt16 {
                        let resultsArray = Array(objectArray.prefix(Int(results)))
                        return Single.just(resultsArray)
                    }
                    
                    return Single.just(objectArray)
                }
            } catch {
                print("Couldn't parse object from contents of \(filename).json")
            }
        }
        print("Couldn't read contents of \(filename).json")
        
        return Single.error(NSError(domain: "Couldn't read contents of \(filename).json", code: 0, userInfo: nil))
    }
    
    private static func read(_ filename: String) -> Data? {
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                
                return data
            } catch {
                print("Couldn't read contents of \(filename).json")            }
        }
        
        return nil
    }
}
