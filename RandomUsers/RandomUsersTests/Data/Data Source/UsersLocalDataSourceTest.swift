//
//  UsersLocalDataSourceTest.swift
//  RandomUsersTests
//
//  Created by Kirian Anglès on 2/12/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import RxSwift

@testable import RandomUsers

class UsersLocalDataSourceTest: UsersLocalDataSourceType {
    private var localUsers:[UserEntity] = []
    var getUsersCalled = false
    var saveUsersCalled = false
    var removeUserCalled = false

    func getUsers() -> Single<[UserEntity]> {
        getUsersCalled = true
        return Single.just(localUsers)
    }
    
    func saveUsers(userEntities: [UserEntity]) {
        saveUsersCalled = true
        var usersToInsert: [UserEntity] = []
        
        userEntities.forEach { userEntity in
            if localUsers.contains(where: { localUser -> Bool in
                return localUser.email == userEntity.email
            }) {} else {
                usersToInsert.append(userEntity)
            }
        }
        localUsers.append(contentsOf: usersToInsert)
    }
    
    func removeUser(userEntity: UserEntity) -> Single<Bool> {
        removeUserCalled = true
        if let email = userEntity.email {
            let found: UserEntity? = localUsers.filter({ $0.email == email }).first
            if found != nil {
                found?.isRemoved = true
                
                return Single.just(true)
            }
        }
        
        return Single.just(false)
    }
}
