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

class UsersLocalDataSourceTest {//}: UsersLocalDataSourceType {
   /* func getUsers() -> Single<[UserEntity]> {
        return LocalData
    }
    */
    func saveUsers(userEntities: [UserEntity]) {
        
    }
    
    func removeUser(userEntity: UserEntity) -> Single<Bool> {
        return Single.just(false)
    }
    
    
}
