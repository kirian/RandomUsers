//
//  TestAssembler.swift
//  RandomUsersTests
//
//  Created by Kirian Anglès on 2/12/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation

@testable import RandomUsers

class TestAssembler: Assembler {}

extension UserListAssembler where Self: TestAssembler {
    func resolve() -> UserListPresenterType {
        return UserListPresenter(getUsersUseCase: resolve(), removeUserUseCase: resolve(), userDetailRouter: nil)
    }
    
    func resolve() -> UsersRepositoryType {
        return UsersRepository(remoteDataSource: resolve(),
                               localDataSource: resolve())
    }
    
    func resolve() -> UsersRemoteDataSourceType {
        return UsersRemoteDataSourceTest(networkClient: resolve())
    }
    
    func resolve() -> UsersLocalDataSourceType {
        return UsersLocalDataSourceTest()
    }
    
    func resolve() -> NetworkClient {
        return NetworkClientStub(filename: "GET_Users_v1.1")
    }
}
