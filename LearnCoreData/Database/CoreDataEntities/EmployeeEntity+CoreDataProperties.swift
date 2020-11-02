//
//  EmployeeEntity+CoreDataProperties.swift
//  LearnCoreData
//
//  Created by MultisAudios on 06.10.2020.
//  Copyright © 2020 Yura Savchuk. All rights reserved.
//
//

import Foundation
import CoreData


extension EmployeeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmployeeEntity> {
        return NSFetchRequest<EmployeeEntity>(entityName: "Employee")
    }

    @NSManaged public var id: Int16
    @NSManaged public var age: Int16
    @NSManaged public var firstName: String?
    @NSManaged public var isOnApprobation: Bool
    @NSManaged public var position: String?
    @NSManaged public var lastName: String?
    @NSManaged public var middleName: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var address: AddressEntity?

}
