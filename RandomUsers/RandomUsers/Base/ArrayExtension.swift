//
//  ArrayExtension.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 30/11/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        
        return result
    }
}
