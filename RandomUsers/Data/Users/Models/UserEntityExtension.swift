//
//  UserEntityExtension.swift
//  RandomUsers
//
//  Created by Kirian Anglès on 2/12/17.
//  Copyright © 2017 Kirian. All rights reserved.
//

import Foundation
import CoreData

extension UserEntity {
    func prepare(for context: NSManagedObjectContext) {
        if let email = email {
            let fetchRequest: NSFetchRequest<CDUserEntity> = CDUserEntity.fetchRequest()
            // Search some UserEntity using email as a primary key
            fetchRequest.predicate = NSPredicate(format: "email == %@", argumentArray: [email])
            let result:[CDUserEntity]? = try? context.fetch(fetchRequest)
            var entity:NSEntityDescription? = nil
            var managedObject: NSManagedObject? = nil
            if result == nil || (result?.isEmpty)! {
                entity = NSEntityDescription.entity(forEntityName: String(describing: CDUserEntity.self), in: context)
                managedObject = NSManagedObject(entity: entity!, insertInto: context)
            } else {
                managedObject = result?.first
            }
            
            managedObject?.setValue(gender, forKey: "gender")
            managedObject?.setValue(nameTitle, forKey: "nameTitle")
            managedObject?.setValue(nameFirst, forKey: "nameFirst")
            managedObject?.setValue(nameLast, forKey: "nameLast")
            managedObject?.setValue(location?.city, forKey: "city")
            managedObject?.setValue(location?.state, forKey: "state")
            managedObject?.setValue(location?.street, forKey: "street")
            managedObject?.setValue(location?.postcode, forKey: "postcode")
            managedObject?.setValue(email, forKey: "email")
            managedObject?.setValue(phone, forKey: "phone")
            managedObject?.setValue(registered, forKey: "registered")
            managedObject?.setValue(picture, forKey: "picture")
            managedObject?.setValue(isRemoved, forKey: "isRemoved")
        }
    }
}
