//
//  EmployeeEntity+CoreDataProperties.swift
//  LearnCoreData
//
//  Created by Yura Savchuk on 15.09.2020.
//  Copyright © 2020 Yura Savchuk. All rights reserved.
//
//

import Foundation
import CoreData


extension EmployeeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmployeeEntity> {
        return NSFetchRequest<EmployeeEntity>(entityName: "Employee")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var middleName: String?
    @NSManaged public var age: Int16

}
