//
//  NetworkClient.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 28/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift

protocol NetworkClient {
    func requestObject<T: Mappable>(with definition: APIDefinition) -> Single<T>
    func requestArray<T: Mappable>(with definition: APIDefinition) -> Single<[T]>
}
