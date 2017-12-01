//
//  UserMapper.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 1/12/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation

class UserMapper {
    static func transform(userEntity: UserEntity) -> User {
        var userLocation: UserLocation? = nil
        var fullName: String? = nil
        var registered: String? = nil
        
        if let location = userEntity.location {
            userLocation = UserLocationMapper.transform(userLocationEntity: location)
        }
        
        if let name = userEntity.nameFirst,
            let surname = userEntity.nameLast {
            fullName = name + " " + surname
        }
        
        if let registeredDate = userEntity.registered {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            registered = formatter.string(from: registeredDate)
        }
        
        return User(gender: userEntity.gender, nameTitle: userEntity.nameTitle, fullName: fullName,
                    nameFirst: userEntity.nameFirst, nameLast: userEntity.nameLast,
                    location: userLocation, email: userEntity.email, phone: userEntity.phone,
                    registered: registered, picture: userEntity.picture)
    }
    
    static func transform(userEntities: [UserEntity]) -> [User] {
        return userEntities.map { UserMapper.transform(userEntity: $0) }
    }
    
    
    static func reverseTransform(user: User) -> UserEntity {
        var registeredDate: Date? = nil
        if let registered = user.registered {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            registeredDate = dateFormatter.date(from: registered)
        }
        
        return UserEntity(gender: user.gender, nameTitle: user.nameTitle,
                          nameFirst: user.nameFirst, nameLast: user.nameLast,
                          location: UserLocationMapper.reverseTransform(userLocation: user.location),
                          email: user.email, phone: user.picture, registered: registeredDate, picture: user.picture)
    }
    
    static func reverseTransform(users: [User]) -> [UserEntity] {
        return users.map { UserMapper.reverseTransform(user: $0) }
    }
}
