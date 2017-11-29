//
//  AppAssembler.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 28/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation

protocol Assembler: RandomUserListAssembler {
    var networkClient: NetworkClient { get }
}

class AppAssembler: Assembler {
    var networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
}
