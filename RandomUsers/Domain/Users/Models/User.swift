//
//  User.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 1/12/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation

struct User {
    var gender: String?
    var nameTitle: String?
    var fullName: String?
    var nameFirst: String?
    var nameLast: String?
    var location: UserLocation?
    var email: String?
    var phone: String?
    var registered: String?
    var picture: String?
    
    init(gender: String?,
         nameTitle: String?,
         fullName: String?,
         nameFirst: String?,
         nameLast: String?,
         location: UserLocation?,
         email: String?,
         phone: String?,
         registered: String?,
         picture: String?) {
        self.gender = gender
        self.nameTitle = nameTitle
        self.fullName = fullName
        self.nameFirst = nameFirst
        self.nameLast = nameLast
        self.location = location
        self.email = email
        self.phone = phone
        self.registered = registered
        self.picture = picture
    }
}
