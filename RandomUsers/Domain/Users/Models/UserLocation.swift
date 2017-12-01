//
//  UserLocation.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 1/12/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation

struct UserLocation {
    var street: String?
    var city: String?
    var state: String?
    var postcode: UInt64?
    var address: String?
    
    init(street: String?,
         city: String?,
         state: String?,
         postcode: UInt64?,
         address: String?) {
        self.street = street
        self.city = city
        self.state = state
        self.postcode = postcode
        self.address = address
    }
}
