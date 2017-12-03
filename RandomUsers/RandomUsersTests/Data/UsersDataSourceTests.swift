//
//  UsersDataSourceTests.swift
//  RandomUsersTests
//
//  Created by Kirian Anglès on 28/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

@testable import RandomUsers

class UsersDataSourceTests: XCTestCase {
    private var userListObserver: TestableObserver<[UserEntity]>!
    private let disposeBag = DisposeBag()
    private let assembler = TestAssembler()

    override func setUp() {
        super.setUp()
        let scheduler = TestScheduler(initialClock: 0)
        userListObserver = scheduler.createObserver([UserEntity].self)
        scheduler.start()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetUsersFromRemoteDataSourceHappyCase() {
        // Given
        let dataSource: UsersRemoteDataSourceType = assembler.resolve()
        
        // When
        dataSource.getUsers(results: 2).asObservable().subscribe(userListObserver).disposed(by: disposeBag)
        
        // Then
        XCTAssertEqual(userListObserver.events[0].value.element?.count, 2)
    }
}
