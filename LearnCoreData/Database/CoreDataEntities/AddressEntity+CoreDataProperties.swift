//
//  AddressEntity+CoreDataProperties.swift
//  LearnCoreData
//
//  Created by Yura Savchuk on 28.09.2020.
//  Copyright © 2020 Yura Savchuk. All rights reserved.
//
//

import Foundation
import CoreData


extension AddressEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AddressEntity> {
        return NSFetchRequest<AddressEntity>(entityName: "Address")
    }

    @NSManaged public var street: String?
    @NSManaged public var postalCode: String?
    @NSManaged public var city: String?

}
