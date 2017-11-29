//
//  UsersRepository.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 29/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import RxSwift

protocol UsersDataSource {
    func getUsers() -> Single<[UserEntity]>
}

protocol UsersRepositoryType {
    func getUsers() -> Single<[UserEntity]>
}

class UsersRepository: UsersRepositoryType {
    private let remoteDataSource: UsersRemoteDataSourceType
    
    init(remoteDataSource: UsersRemoteDataSourceType) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getUsers() -> Single<[UserEntity]> {
        return remoteDataSource.getUsers(results: 50)
    }
}
