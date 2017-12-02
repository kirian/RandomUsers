//
//  RemoveUserUseCase.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 1/12/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import RxSwift

protocol RemoveUserUseCaseType {
    func execute(user: User) -> Single<Bool>
}

class RemoveUserUseCase: RemoveUserUseCaseType {
    private let usersRepository: UsersRepositoryType
    
    init(usersRepository: UsersRepositoryType) {
        self.usersRepository = usersRepository
    }
    
    func execute(user: User) -> Single<Bool> {
        let userEntity = UserMapper.reverseTransform(user: user)
        userEntity.isRemoved = true
        return usersRepository.removeUser(userEntity: userEntity)
    }
}


