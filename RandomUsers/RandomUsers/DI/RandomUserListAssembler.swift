//
//  RandomUserListAssembler.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 28/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import UIKit

protocol RandomUserListAssembler {
    func resolve() -> ViewController
}

extension RandomUserListAssembler {
    func resolve() -> ViewController {
        let viewController = ViewController(nibName: "ViewController", bundle: nil)
        
        return viewController
    }
}
