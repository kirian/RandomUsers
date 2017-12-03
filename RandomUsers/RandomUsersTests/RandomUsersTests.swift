//
//  RandomUsersTests.swift
//  RandomUsersTests
//
//  Created by Kirian Anglès on 28/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

@testable import RandomUsers

class RandomUsersTests: XCTestCase {
    private var userListObserver: TestableObserver<[UserEntity]>!
    let disposeBag = DisposeBag()

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
    
    func testGetUsersHappyCase() {
        // Given
        let networkClientStub = NetworkClientStub(filename: "GET_Users_v1.1")
        let dataSource = UsersRemoteDataSourceTest(networkClient: networkClientStub)
        
        // When
        dataSource.getUsers(results: 3).asObservable().subscribe(userListObserver).disposed(by: disposeBag)
        
        // Then
        XCTAssertEqual(userListObserver.events[0].value.element?.count, 3)
    }
}
