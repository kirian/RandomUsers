//
//  UserDetailAssembler.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 30/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import UIKit

protocol UserDetailAssembler {
    func resolve(user: User) -> UserDetailViewController
    
    func resolve(user: User) -> UserDetailPresenterType
}

extension UserDetailAssembler {
    func resolve(user: User) -> UserDetailViewController {
        return UserDetailViewController(presenter: resolve(user: user))
    }
    
    func resolve(user: User) -> UserDetailPresenterType {
        return UserDetailPresenter(user: user)
    }
}
