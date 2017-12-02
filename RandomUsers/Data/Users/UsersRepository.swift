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
    func removeUser(userEntity: UserEntity) -> Single<Bool>
}

class UsersRepository: UsersRepositoryType {
    private let remoteDataSource: UsersRemoteDataSourceType
    private let localDataSource: UsersLocalDataSourceType
    
    init(remoteDataSource: UsersRemoteDataSourceType,
         localDataSource: UsersLocalDataSourceType) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func getUsers() -> Single<[UserEntity]> {
        return Single.zip(remoteDataSource.getUsers(results: 9)
            .do(onNext: { [weak self] userEntities in
                // Remove duplicated users from server and save to disk
                let remoteEntities = userEntities.removeDuplicates()
                self?.localDataSource.saveUsers(userEntities: remoteEntities)
            })
            .catchError { _ in return Single.just([]) },
            // Get the non removed users from disk
            localDataSource.getUsers()
                .catchError { _ in return Single.just([]) },
            resultSelector: {
                remoteUserEntities, localUserEntities in
                let availableUsers = self.availableUserEntities(remoteUserEntities: remoteUserEntities,
                                                  localUserEntities: localUserEntities)
                return availableUsers
        })
    }
    
    func removeUser(userEntity: UserEntity) -> Single<Bool> {
        return localDataSource.removeUser(userEntity: userEntity)
    }
    
    private func availableUserEntities(remoteUserEntities: [UserEntity],
                                       localUserEntities: [UserEntity]) -> [UserEntity] {
        return (remoteUserEntities + localUserEntities).removeDuplicates()
    }
}
