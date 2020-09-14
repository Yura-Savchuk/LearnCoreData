//
//  EmployeeTableViewCell.swift
//  LearnCoreData
//
//  Created by Yura Savchuk on 15.09.2020.
//  Copyright © 2020 Yura Savchuk. All rights reserved.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var lblFullName: UILabel!
    
    func populate(_ employee: EmployeeEntity) {
        lblFullName.text = fullName(of: employee)
    }
    
    private func fullName(of employee: EmployeeEntity) -> String {
        return [employee.lastName,
                employee.firstName,
                employee.middleName]
            .compactMap {$0}
            .joined(separator: " ")
    }
    
}
