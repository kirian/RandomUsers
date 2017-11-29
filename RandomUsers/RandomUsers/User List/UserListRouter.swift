//
//  UserListRouter.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 29/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import UIKit

protocol UserListRouterType {
    func navigateToUserList(window: UIWindow?)
}

class UserListRouter: UserListRouterType {
    private let assembler: Assembler
    
    init(assembler: Assembler) {
        self.assembler = assembler
    }
    
    func navigateToUserList(window: UIWindow?) {
        let viewController: UserListViewController = assembler.resolve()
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
    }
}
