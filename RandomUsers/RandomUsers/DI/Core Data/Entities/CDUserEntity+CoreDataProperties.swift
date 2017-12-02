//
//  CDUserEntity+CoreDataProperties.swift
//  
//
//  Created by Kirian Anglès on 2/12/17.
//
//

import Foundation
import CoreData


extension CDUserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUserEntity> {
        return NSFetchRequest<CDUserEntity>(entityName: "CDUserEntity")
    }

    @NSManaged public var email: String?
    @NSManaged public var gender: String?
    @NSManaged public var isRemoved: Bool
    @NSManaged public var nameFirst: String?
    @NSManaged public var nameLast: String?
    @NSManaged public var nameTitle: String?
    @NSManaged public var phone: String?
    @NSManaged public var picture: String?
    @NSManaged public var registered: NSDate?
    @NSManaged public var street: String?
    @NSManaged public var city: String?
    @NSManaged public var state: String?
    @NSManaged public var postcode: Int64

}
