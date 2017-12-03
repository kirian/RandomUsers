//
//  UserListPresenterTests.swift
//  RandomUsersTests
//
//  Created by Kirian Anglès on 3/12/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

@testable import RandomUsers

class UserListPresenterTests: XCTestCase {
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
    
    func testListFirstTenUsersFromPresenter() {
        // Given
        let view: UserListViewTest = UserListViewTest()
        var userListPresenter: UserListPresenterType = assembler.resolve()
        userListPresenter.view = view
        
        // When
        userListPresenter.viewDidLoad()

        // Then
        XCTAssertEqual(view.userList.count, 10)
    }
    
    func testFilterUsernameAction() {
        // Given
        let view: UserListViewTest = UserListViewTest()
        var userListPresenter: UserListPresenterType = assembler.resolve()
        userListPresenter.view = view
        
        // When
        userListPresenter.viewDidLoad()
        userListPresenter.filterUsers(by: "kasper")
        
        // Then
        XCTAssertEqual(view.userList.count, 1)
    }
    
    func testRemoveUserAction() {
        // Given
        let view: UserListViewTest = UserListViewTest()
        var userListPresenter: UserListPresenterType = assembler.resolve()
        userListPresenter.view = view
        
        // When
        userListPresenter.viewDidLoad()
        
        if let user = view.userList.first {
            userListPresenter.willRemoveUser(user: user, at: IndexPath(row: 0, section: 0))
        }
        // Then
        XCTAssertEqual(view.userList.count, 9)
    }
}

