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
    var location: UserLocationEntity?
    var email: String?
    var phone: String?
    var registered: Date?
    var picture: String?
    
    required init?(map: Map) {}
    
    init(gender: String?,
         nameTitle: String?,
         nameFirst: String?,
         nameLast: String?,
         location: UserLocationEntity?,
         email: String?,
         phone: String?,
         registered: Date?,
         picture: String?) {
        self.gender = gender
        self.nameTitle = nameTitle
        self.nameFirst = nameFirst
        self.nameLast = nameLast
        self.location = location
        self.email = email
        self.phone = phone
        self.registered = registered
        self.picture = picture
    }
    
    func mapping(map: Map) {
        gender      <- map["gender"]
        nameTitle   <- map["name.title"]
        nameFirst   <- map["name.first"]
        nameLast    <- map["name.last"]
        location    <- map["location"]
        email       <- map["email"]
        phone       <- map["phone"]
        registered  <- (map["registered"], RegisteredDateTransform())
        picture     <- map["picture.large"]
    }
}

extension UserEntity: Equatable {
    static func ==(lhs: UserEntity, rhs: UserEntity) -> Bool {
        if let lhsEmail = lhs.email,
            let rhsEmail = rhs.email {
        return lhsEmail.range(of: rhsEmail) != nil
        } else {
            return false
        }
    }
}
