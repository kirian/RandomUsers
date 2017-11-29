//
//  UserListAssembler.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 28/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import UIKit

protocol UserListAssembler {
    func resolve() -> UserListViewController
    func resolve() -> UserListPresenterType
    func resolve() -> GetUsersUseCaseType
    func resolve() -> UsersRepositoryType
    func resolve() -> UsersRemoteDataSourceType
    func resolve() -> NetworkClient
}

extension UserListAssembler {
    func resolve() -> UserListViewController {
        let viewController = UserListViewController(presenter: resolve())
        
        return viewController
    }
    
    func resolve() -> UserListPresenterType {
        return UserListPresenter(getUsersUseCase: resolve())
    }
    
    func resolve() -> GetUsersUseCaseType {
        return GetUsersUseCase(usersRepository: resolve())
    }
    
    func resolve() -> UsersRepositoryType {
        return UsersRepository(remoteDataSource: resolve())
    }
    
    func resolve() -> UsersRemoteDataSourceType {
        return UsersRemoteDataSource(networkClient: resolve())
    }
    
    func resolve() -> NetworkClient {
        return AlamofireClient(baseURL: URL(string: "http://api.randomuser.me/")!)
    }
}
