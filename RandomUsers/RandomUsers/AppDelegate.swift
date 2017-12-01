//
//  AppDelegate.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 28/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    fileprivate var applicationServices = [ApplicationService]()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        initializeServices(window: window)
        applicationServices.forEach { $0.application(application, didFinishLaunchingWithOptions: launchOptions, window: window) }

        return true
    }

    func initializeServices(window: UIWindow?) {
        applicationServices = initializeServices()
    }
}

extension AppDelegate {
    func initializeServices() -> [ApplicationService] {
        let interfaceLoaderService = InterfaceLoaderApplicationService(appDelegate: self)
        
        return [interfaceLoaderService]
    }
}
