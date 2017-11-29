//
//  InterfaceLoaderApplicationService.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 28/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import UIKit

final class InterfaceLoaderApplicationService: ApplicationService {
    fileprivate weak var appDelegate: AppDelegate?
    fileprivate lazy var assembler: AppAssembler = AppAssembler()
    
    init(appDelegate: AppDelegate) {
        self.appDelegate = appDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]?, window: UIWindow?) {
        window?.makeKeyAndVisible()
        let userListRouter = UserListRouter(assembler: assembler)
        userListRouter.navigateToUserList(window: window)
    }
}
