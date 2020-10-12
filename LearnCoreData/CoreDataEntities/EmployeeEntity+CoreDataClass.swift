//
//  EmployeeEntity+CoreDataClass.swift
//  LearnCoreData
//
//  Created by Yura Savchuk on 28.09.2020.
//  Copyright © 2020 Yura Savchuk. All rights reserved.
//
//

import Foundation
import CoreData

@objc(EmployeeEntity)
public class EmployeeEntity: NSManagedObject {
    
    func fullName() -> String {
        return [firstName, middleName, lastName]
            .compactMap { $0 }
            .joined(separator: " ")
    }

}
