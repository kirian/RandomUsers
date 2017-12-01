//
//  UserLocationMapper.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 1/12/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation

public class UserLocationMapper {
    static func transform(userLocationEntity: UserLocationEntity) -> UserLocation {
        var address: String? = nil
        if let street = userLocationEntity.street,
            let city = userLocationEntity.city,
            let state = userLocationEntity.state {
            address = street + " " + city + " " + state
        }
        
        return UserLocation(street: userLocationEntity.street,
                            city: userLocationEntity.city,
                            state: userLocationEntity.state,
                            postcode: userLocationEntity.postcode,
                            address: address)
    }
    
    static func transform(userLocationEntities: [UserLocationEntity]) -> [UserLocation] {
        return userLocationEntities.map { UserLocationMapper.transform(userLocationEntity: $0) }
    }
    
    static func reverseTransform(userLocation: UserLocation?) -> UserLocationEntity {
        return UserLocationEntity(street: userLocation?.street,
                                  city: userLocation?.city,
                                  state: userLocation?.state,
                                  postcode: userLocation?.postcode)
    }
    
    static func reverseTransform(userLocations: [UserLocation]) -> [UserLocationEntity] {
        return userLocations.map { UserLocationMapper.reverseTransform(userLocation: $0) }
    }
}
