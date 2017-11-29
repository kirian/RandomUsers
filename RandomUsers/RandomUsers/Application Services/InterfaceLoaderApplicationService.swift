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
    fileprivate lazy var assembler: AppAssembler = {
        let networkClient = AlamofireClient(baseURL: URL(string: "http://api.randomuser.me/?results=40")!)
        let assembler = AppAssembler(networkClient: networkClient)
        
        return assembler
    }()
    
    init(appDelegate: AppDelegate) {
        self.appDelegate = appDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]?, window: UIWindow?) {
        let viewController: ViewController = assembler.resolve()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible() 
    }
}
