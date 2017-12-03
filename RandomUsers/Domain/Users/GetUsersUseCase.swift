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
    func execute(results: UInt16) -> Single<[User]>
}

class GetUsersUseCase: GetUsersUseCaseType {
    private let usersRepository: UsersRepositoryType
    
    init(usersRepository: UsersRepositoryType) {
        self.usersRepository = usersRepository
    }
    
    func execute(results: UInt16 = 10) -> Single<[User]> {
        return usersRepository.getUsers(results: results).map { userEntities -> [User] in
            let entities = userEntities.removeDuplicates()
            let users:[User] = UserMapper.transform(userEntities: entities)
            let sorted = self.sortUsersByName(userEntities: users)
            
            return sorted
        }
    }
    
    fileprivate func sortUsersByName(userEntities: [User]) -> [User] {
        return userEntities.sorted { (lhs, rhs) -> Bool in
            if let leftElement = lhs.fullName,
                let rightElement = rhs.fullName {
                return leftElement < rightElement
            } else {
                return false
            }
        }
    }
}
