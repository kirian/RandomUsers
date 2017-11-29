//
//  GetUsersUseCase.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 29/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import RxSwift

protocol GetUsersUseCaseType {
    func execute() -> Single<[UserEntity]>
}

class GetUsersUseCase: GetUsersUseCaseType {
    private let usersRepository: UsersRepositoryType
    
    init(usersRepository: UsersRepositoryType) {
        self.usersRepository = usersRepository
    }
    
    func execute() -> Single<[UserEntity]> {
        return usersRepository.getUsers()
    }
}
