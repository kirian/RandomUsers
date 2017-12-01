//
//  RegisteredDataTransform.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 1/12/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import ObjectMapper

class RegisteredDateTransform: TransformType {
    typealias Object = Date
    typealias JSON = Double
    
    func transformFromJSON(_ value: Any?) -> Date? {
        if let timeStr = value as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            return dateFormatter.date(from: timeStr)
        }
        
        return nil
    }
    
    func transformToJSON(_ value: Date?) -> Double? {
        if let date = value {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            return Double(dateFormatter.string(from: date))
        }
        
        return nil
    }
}
