//
//  UsersRepositoryTests.swift
//  RandomUsersTests
//
//  Created by Kirian Anglès on 2/12/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

@testable import RandomUsers

class UsersRepositoryTests: XCTestCase {
    private var userListObserver: TestableObserver<[UserEntity]>!
    private var userListLocalObserver: TestableObserver<[UserEntity]>!
    private let disposeBag = DisposeBag()
    private let assembler = TestAssembler()

    override func setUp() {
        super.setUp()
        let scheduler = TestScheduler(initialClock: 0)
        userListObserver = scheduler.createObserver([UserEntity].self)
        scheduler.start()

        let schedulerLocal = TestScheduler(initialClock: 1)
        userListLocalObserver = schedulerLocal.createObserver([UserEntity].self)
        schedulerLocal.start()

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetUsersHappyCase() {
        // Given
        let usersRepository: UsersRepositoryType = assembler.resolve()
        // When
        usersRepository.getUsers(results: 3).asObservable().subscribe(userListObserver).disposed(by: disposeBag)
        
        // Then
        XCTAssertEqual(userListObserver.events[0].value.element?.count, 3)
    }
    
    func testGetUsersRemoteDataSourceCalled() {
        // Given
        let networkClientStub = NetworkClientStub(filename: "GET_Users_v1.1")
        let remoteDataSource = UsersRemoteDataSourceTest(networkClient: networkClientStub)
        let localDataSource = UsersLocalDataSourceTest()
        let usersRepository = UsersRepository(remoteDataSource: remoteDataSource,
                                              localDataSource: localDataSource)
        // When
        usersRepository.getUsers(results: 10).asObservable().subscribe(userListObserver).disposed(by: disposeBag)

        // Then
        XCTAssertTrue(remoteDataSource.getUsersCalled)
    }
    
    func testGetUsersLocalDataSourceCalled() {
        // Given
        let networkClientStub = NetworkClientStub(filename: "GET_Users_v1.1")
        let remoteDataSource = UsersRemoteDataSourceTest(networkClient: networkClientStub)
        let localDataSource = UsersLocalDataSourceTest()
        let usersRepository = UsersRepository(remoteDataSource: remoteDataSource,
                                              localDataSource: localDataSource)
        // When
        usersRepository.getUsers(results: 10).asObservable().subscribe(userListObserver).disposed(by: disposeBag)
        
        // Then
        XCTAssertTrue(localDataSource.getUsersCalled)
    }
    
    func testGetUsersSaveUsersIntoLocalDataSource() {
        // Given
        let networkClientStub = NetworkClientStub(filename: "GET_Users_v1.1")
        let remoteDataSource = UsersRemoteDataSourceTest(networkClient: networkClientStub)
        let localDataSource = UsersLocalDataSourceTest()
        let usersRepository = UsersRepository(remoteDataSource: remoteDataSource,
                                              localDataSource: localDataSource)
        // When
        usersRepository.getUsers(results: 10).asObservable().subscribe(userListObserver).disposed(by: disposeBag)
        
        // Then
        XCTAssertTrue(localDataSource.saveUsersCalled)
    }
    
    func testGetUsersFromRemoteAndSaveToLocalHappyCase() {
        // Given
        let remoteDataSource: UsersRemoteDataSourceType = assembler.resolve()
        let localDataSource: UsersLocalDataSourceType = assembler.resolve()
        let usersRepository = UsersRepository(remoteDataSource: remoteDataSource,
                                              localDataSource: localDataSource)
        
        // When
        usersRepository.getUsers(results: 3).asObservable().subscribe(userListObserver).disposed(by: disposeBag)
        localDataSource.getUsers().asObservable().subscribe(userListLocalObserver).disposed(by: disposeBag)
        
        // Then
        XCTAssertEqual(userListObserver.events[0].value.element?.count, 3)
        XCTAssertEqual(userListLocalObserver.events[0].value.element?.count, 3)
    }
}
