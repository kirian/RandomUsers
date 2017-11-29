//
//  UserEntity.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 29/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import ObjectMapper

class UserEntity: Mappable {
    var gender: String?
    var nameTitle: String?
    var nameFirst: String?
    var nameLast: String?
    var location: LocationEntity?
    var email: String?
    var registered: Date?
    var picture: String?
    
    required init?(map: Map) {}
    
    init(gender: String?,
         nameTitle: String?,
         nameFirst: String?,
         nameLast: String?,
         location: LocationEntity?,
         email: String?,
         registered: Date?,
         picture: String?) {
        self.gender = gender
        self.nameTitle = nameTitle
        self.nameFirst = nameFirst
        self.nameLast = nameLast
        self.location = location
        self.email = email
        self.registered = registered
        self.picture = picture
    }
    
    func mapping(map: Map) {
        let dateTransform = DateTransform()
        gender      <- map["gender"]
        nameTitle   <- map["name.title"]
        nameFirst   <- map["name.first"]
        nameLast    <- map["name.last"]
        location    <- map["location"]
        email       <- map["email"]
        registered  <- (map["registered"], dateTransform)
        picture     <- map["picture"]
    }
}
