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
    func resolve() -> RemoveUserUseCaseType
    func resolve() -> UsersRepositoryType
    func resolve() -> UsersRemoteDataSourceType
    func resolve() -> UsersLocalDataSourceType
    func resolve() -> UserListAdapter
    func resolve(with adapter: UserListAdapter) -> CollectionViewDataSource<UserListAdapter>
    func resolve() -> UserDetailRouterType
    func resolve() -> NetworkClient
}

extension UserListAssembler where Self: Assembler {
    func resolve() -> UserListViewController {
        let viewController = UserListViewController(presenter: resolve(),
                                                    dataSource: resolve(with: resolve()))
        
        return viewController
    }
    
    func resolve() -> UserListPresenterType {
        return UserListPresenter(getUsersUseCase: resolve(),
                                 removeUserUseCase: resolve(),
                                 userDetailRouter: resolve())
    }
    
    func resolve() -> GetUsersUseCaseType {
        return GetUsersUseCase(usersRepository: resolve())
    }
    
    func resolve() -> RemoveUserUseCaseType {
        return RemoveUserUseCase(usersRepository: resolve())
    }
    
    func resolve() -> UsersRepositoryType {
        return UsersRepository(remoteDataSource: resolve(),
                               localDataSource: resolve())
    }
    
    func resolve() -> UsersRemoteDataSourceType {
        return UsersRemoteDataSource(networkClient: resolve())
    }
    
    func resolve() -> UsersLocalDataSourceType {
        return UsersLocalDataSource(dataStack: resolve())
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
    
    func resolve() -> NetworkClient {
        return AlamofireClient(baseURL: URL(string: "https://api.randomuser.me/")!)
    }
    
    private func resolve() -> CoreDataStack {
        return CoreDataStack()
    }
}
