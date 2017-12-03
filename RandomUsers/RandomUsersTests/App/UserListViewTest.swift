//
//  UserListViewTest.swift
//  RandomUsersTests
//
//  Created by Kirian Anglès on 3/12/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import XCTest

@testable import RandomUsers

class UserListViewTest: UserListView {
    var showLoadingViewCalled:Bool = false
    var hideLoadingViewCalled:Bool = false
    var userList:[User] = []
    
    func showLoadingView() {
        showLoadingViewCalled = true
    }
    
    func hideLoadingView() {
        hideLoadingViewCalled = true
    }
    
    func show(users: [User]) {
        userList = users
    }
    
    func didRemoveUser(dataSourceIndex: Int, indexPath: IndexPath) {
        userList.remove(at: dataSourceIndex)
    }
    
    func scrollToItem(at index: Int) {}
}
