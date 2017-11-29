//
//  AlamofireClient.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 28/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import RxSwift

class AlamofireClient: NetworkClient {
    let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func requestObject<T: Mappable>(with definition: APIDefinition) -> Single<T> {
        let request = APIRequest(baseURL: baseURL, definition: definition)
        
        return Single<T>.create { single -> Disposable in
            let alamofireRequest = Alamofire.request(request)
                .validate()
                .responseObject(completionHandler: { (dataResponse: DataResponse<T>) in
                    switch dataResponse.result {
                    case .success(let response):
                        single(.success(response))
                    case .failure(let error):
                        single(.error(error))
                    }
                })
            
            return Disposables.create(with: {
                alamofireRequest.cancel()
            })
        }
    }
    
    public func requestArray<T: Mappable>(with definition: APIDefinition) -> Single<[T]> {
        let request = APIRequest(baseURL: baseURL, definition: definition)
        
        return Single<[T]>.create { single -> Disposable in
            let alamofireRequest = Alamofire.request(request)
                .validate()
                .responseArray(completionHandler: { (dataResponse: DataResponse<[T]>) in
                    switch dataResponse.result {
                    case .success(let response):
                        single(.success(response))
                    case .failure(let error):
                        single(.error(error))
                    }
                })
            
            return Disposables.create(with: {
                alamofireRequest.cancel()
            })
        }
    }
}
