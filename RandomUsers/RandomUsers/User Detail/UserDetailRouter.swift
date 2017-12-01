//
//  UserDetailRouter.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 30/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import UIKit

protocol UserDetailRouterType {
    func navigateTo(user: User, sourceViewController: UIViewController)
}

struct UserDetailRouter: UserDetailRouterType {
    private let assembler: Assembler
    
    init(assembler: Assembler) {
        self.assembler = assembler
    }
    
    func navigateTo(user: User, sourceViewController: UIViewController) {
        let viewController: UserDetailViewController = assembler.resolve(user: user)
        sourceViewController.navigationController?.pushViewController(viewController, animated: true)
    }
}
