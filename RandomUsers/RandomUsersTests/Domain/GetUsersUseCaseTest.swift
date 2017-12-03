//
//  GetUsersUseCaseTest.swift
//  RandomUsersTests
//
//  Created by Kirian Anglès on 2/12/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

@testable import RandomUsers

class GetUsersUseCaseTest: XCTestCase {
    private var userListObserver: TestableObserver<[User]>!
    private let disposeBag = DisposeBag()
    private let assembler = TestAssembler()

    override func setUp() {
        super.setUp()
        let scheduler = TestScheduler(initialClock: 0)
        userListObserver = scheduler.createObserver([User].self)
        scheduler.start()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetUsersFromUseCaseHappyCase() {
        // Given
        let usersRepository: UsersRepositoryType = assembler.resolve()
        let getUsersUseCase = GetUsersUseCase(usersRepository: usersRepository)
        
        // When
        getUsersUseCase.execute(results: 20).asObservable().subscribe(userListObserver).disposed(by: disposeBag)
        
        // Then
        XCTAssertEqual(userListObserver.events[0].value.element?.count, 20)
    }
    
    func testGetUsersFromUseCaseSortedByFullNameHappyCase() {
        // Given
        let usersRepository: UsersRepositoryType = assembler.resolve()
        let getUsersUseCase = GetUsersUseCase(usersRepository: usersRepository)
        
        // When
        getUsersUseCase.execute(results: 20).asObservable().subscribe(userListObserver).disposed(by: disposeBag)
        
        // Then
        XCTAssertEqual(userListObserver.events[0].value.element?.first?.fullName, "adrualdo das neves")
        XCTAssertEqual(userListObserver.events[0].value.element?.last?.fullName, "patricia barnes")
    }
}
