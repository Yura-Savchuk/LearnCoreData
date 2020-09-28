//
//  JobEntity+CoreDataProperties.swift
//  LearnCoreData
//
//  Created by Yura Savchuk on 28.09.2020.
//  Copyright © 2020 Yura Savchuk. All rights reserved.
//
//

import Foundation
import CoreData


extension JobEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JobEntity> {
        return NSFetchRequest<JobEntity>(entityName: "Job")
    }

    @NSManaged public var name: String?
    @NSManaged public var salary: Int16
    @NSManaged public var id: String?

}
