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
    func resolve() -> UserListAdapter
    func resolve(with adapter: UserListAdapter) -> CollectionViewDataSource<UserListAdapter>
    func resolve() -> UserDetailRouterType
}

extension UserListAssembler where Self: Assembler {
    func resolve() -> UserListViewController {
        let viewController = UserListViewController(presenter: resolve(),
                                                    dataSource: resolve(with: resolve()))
        
        return viewController
    }
    
    func resolve() -> UserListPresenterType {
        return UserListPresenter(getUsersUseCase: resolve(),
                                 userDetailRouter: resolve())
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
        return AlamofireClient(baseURL: URL(string: "https://api.randomuser.me/")!)
    }
    
    func resolve() -> UserListAdapter {
        return UserListAdapter()
    }
    
    func resolve(with adapter: UserListAdapter) -> CollectionViewDataSource<UserListAdapter> {
        return CollectionViewDataSource(adapter: adapter)
    }
    
    func resolve() -> UserDetailRouterType {
        return UserDetailRouter(assembler: self)
    }
}
