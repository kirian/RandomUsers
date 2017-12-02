//
//  UsersLocalDataSource.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 1/12/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

protocol UsersLocalDataSourceType {
    func getUsers() -> Single<[UserEntity]>
    func saveUsers(userEntities: [UserEntity])
    func removeUser(userEntity: UserEntity) -> Single<Bool>
}

class UsersLocalDataSource: UsersLocalDataSourceType {
    private let dataStack: CoreDataStack
    
    init(dataStack: CoreDataStack) {
        self.dataStack = dataStack
    }
    
    func getUsers() -> Single<[UserEntity]> {
        let single = Single<[UserEntity]>.create {single -> Disposable in
            self.dataStack.persistentContainer.performBackgroundTask { context  in
                let fetchRequest: NSFetchRequest<CDUserEntity> = CDUserEntity.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "isRemoved == false")
                
                do {
                    let fetchedEntities = try context.fetch(fetchRequest)
                    let userEntities: [UserEntity] = fetchedEntities.flatMap({cdUserEntity -> UserEntity in
                        let userLocationEntity = UserLocationEntity(street: cdUserEntity.street,
                                                                    city: cdUserEntity.city,
                                                                    state: cdUserEntity.state,
                                                                    postcode: cdUserEntity.postcode)
                        
                        return UserEntity(gender: cdUserEntity.gender,
                                          nameTitle: cdUserEntity.nameTitle,
                                          nameFirst:cdUserEntity.nameFirst,
                                          nameLast: cdUserEntity.nameLast,
                                          location: userLocationEntity,
                                          email: cdUserEntity.email,
                                          phone: cdUserEntity.phone,
                                          registered: cdUserEntity.registered as Date?,
                                          picture: cdUserEntity.picture,
                                          isRemoved: cdUserEntity.isRemoved)
                    })
                    single(.success(userEntities))
                } catch {
                    single(.error(error))
                }
            }
            return Disposables.create()
            }.observeOn(MainScheduler.instance)
        return single
    }
    
    func removeUser(userEntity: UserEntity) -> Single<Bool> {
        return saveUserEntity(userEntity: userEntity)
    }
    
    func saveUsers(userEntities: [UserEntity]) {
        self.dataStack.persistentContainer.performBackgroundTask { context  in
            userEntities.forEach { userEntity in
                userEntity.prepare(for: context)
            }
            do {
                try context.save()
            } catch {
                fatalError("error saving users in local\(error)")
            }
        }
    }
    
    private func saveUserEntity(userEntity: UserEntity) -> Single<Bool> {
        let single = Single<Bool>.create {single -> Disposable in
            self.dataStack.persistentContainer.performBackgroundTask { context  in
                userEntity.prepare(for: context)
                do {
                    try context.save()
                    
                    single(.success(true))
                } catch {
                    single(.error(error))
                }
            }
            return Disposables.create()
            }.observeOn(MainScheduler.instance)
        return single
    }
}
