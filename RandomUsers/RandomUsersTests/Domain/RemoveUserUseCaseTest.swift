//
//  RemoveUserUseCaseTest.swift
//  RandomUsersTests
//
//  Created by Kirian Anglès on 2/12/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

@testable import RandomUsers

class RemoveUserUseCaseTest: XCTestCase {
    private var userListObserver: TestableObserver<[User]>!
    private var userToRemoveObserver: TestableObserver<Bool>!
    private var userListEmptyObserver: TestableObserver<[User]>!
    private var userListLocalObserver: TestableObserver<[UserEntity]>!
    private let disposeBag = DisposeBag()
    private let assembler = TestAssembler()

    override func setUp() {
        super.setUp()
        let scheduler = TestScheduler(initialClock: 0)
        userListObserver = scheduler.createObserver([User].self)
        scheduler.start()
        
        let schedulerToRemove = TestScheduler(initialClock: 0)
        userToRemoveObserver = schedulerToRemove.createObserver(Bool.self)
        schedulerToRemove.start()
        
        let schedulerEmpty = TestScheduler(initialClock: 0)
        userListLocalObserver = schedulerEmpty.createObserver([UserEntity].self)
        schedulerEmpty.start()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRemoveUserFromUseCaseHappyCase() {
        // Given
        let usersRepository: UsersRepositoryType = assembler.resolve()
        let getUsersUseCase = GetUsersUseCase(usersRepository: usersRepository)
        let removeUserUseCase = RemoveUserUseCase(usersRepository: usersRepository)

        // When
        getUsersUseCase.execute(results: 1).asObservable().subscribe(userListObserver).disposed(by: disposeBag)
        removeUserUseCase.execute(user: userListObserver.events[0].value.element?.first ?? User.mock())
            .asObservable().subscribe(userToRemoveObserver).disposed(by: disposeBag)
        // Then
        XCTAssertTrue(userToRemoveObserver.events[0].value.element ?? false)
    }
    
    func testUserIsRemovedFromLocalDataSourceCaseHappyCase() {
        // Given
        let remoteDataSource: UsersRemoteDataSourceType = assembler.resolve()
        let localDataSource: UsersLocalDataSourceType = assembler.resolve()
        let usersRepository = UsersRepository(remoteDataSource: remoteDataSource,
                                              localDataSource: localDataSource)
        let getUsersUseCase = GetUsersUseCase(usersRepository: usersRepository)
        let removeUserUseCase = RemoveUserUseCase(usersRepository: usersRepository)
        
        // When
        getUsersUseCase.execute(results: 1).asObservable().subscribe(userListObserver).disposed(by: disposeBag)
        removeUserUseCase.execute(user: userListObserver.events[0].value.element?.first ?? User.mock())
            .asObservable().subscribe(userToRemoveObserver).disposed(by: disposeBag)
        localDataSource.getUsers().asObservable().subscribe(userListLocalObserver).disposed(by: disposeBag)
        
        // Then
        XCTAssertEqual(userListLocalObserver.events[0].value.element?.first?.isRemoved, true)
    }
    
    func testGetUsersAfterRemoveUserUseCaseHappyCase() {
        // Given
        let remoteDataSource: UsersRemoteDataSourceType = assembler.resolve()
        let localDataSource: UsersLocalDataSourceType = assembler.resolve()
        let usersRepository = UsersRepository(remoteDataSource: remoteDataSource,
                                              localDataSource: localDataSource)
        let getUsersUseCase = GetUsersUseCase(usersRepository: usersRepository)
        let removeUserUseCase = RemoveUserUseCase(usersRepository: usersRepository)
        
        // When
        getUsersUseCase.execute(results: 1).asObservable().subscribe(userListObserver).disposed(by: disposeBag)
        removeUserUseCase.execute(user: userListObserver.events[0].value.element?.first ?? User.mock())
            .asObservable().subscribe(userToRemoveObserver).disposed(by: disposeBag)
        localDataSource.getUsers().asObservable().subscribe(userListLocalObserver).disposed(by: disposeBag)
        getUsersUseCase.execute(results: 3).asObservable().subscribe(userListObserver).disposed(by: disposeBag)
        
        // Then
        XCTAssertEqual(userListObserver.events[0].value.element?.count, 1)
        XCTAssertTrue(userToRemoveObserver.events[0].value.element ?? false)
        XCTAssertEqual(userListLocalObserver.events[0].value.element?.count, 1)
        XCTAssertEqual(userListObserver.events[2].value.element?.count, 2)
    }
}

extension User {
    static func mock() -> User {
        return User(gender: "female", nameTitle: "ms", fullName: "mock user", nameFirst: "mock", nameLast: "user", location: nil, email: "mock.user@example.com", phone: "070-706-6006", registered: "2017-03-20 07:59:40", picture: "https://randomuser.me/api/portraits/women/46.jpg")
    }
}
