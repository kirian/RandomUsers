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
    func execute() -> Single<[User]>
}

class GetUsersUseCase: GetUsersUseCaseType {
    private let usersRepository: UsersRepositoryType
    
    init(usersRepository: UsersRepositoryType) {
        self.usersRepository = usersRepository
    }
    
    func execute() -> Single<[User]> {
        return usersRepository.getUsers().map { userEntities -> [User] in
            let entities = userEntities.removeDuplicates()
            let users:[User] = UserMapper.transform(userEntities: entities)
            return self.sortUsersByName(userEntities: users)
        }
    }
    
    fileprivate func sortUsersByName(userEntities: [User]) -> [User] {
        return userEntities.sorted { (first, next) -> Bool in
            if let firstName = first.nameFirst,
                let nextName = next.nameFirst {
                return firstName < nextName
            } else {
                return false
            }
        }
    }
}
