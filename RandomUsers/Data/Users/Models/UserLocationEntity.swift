//
//  UserLocationEntity.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 29/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import ObjectMapper

class UserLocationEntity: Mappable {
    var street: String?
    var city: String?
    var state: String?
    var postcode: Int64?
    
    required init?(map: Map) {}
    
    init(street: String?,
         city: String?,
         state: String?,
         postcode: Int64?) {
        self.street = street
        self.city = city
        self.state = state
        self.postcode = postcode
    }
    
    func mapping(map: Map) {
        street      <- map["street"]
        city        <- map["city"]
        state       <- map["state"]
        postcode    <- map["postcode"]
    }
    
    func address() -> String {
        var address: String = ""
        if let street = street,
        let city = city,
        let state = state {
            address = street + " " + city + " " + state
        }
        
        return address
    }
}
