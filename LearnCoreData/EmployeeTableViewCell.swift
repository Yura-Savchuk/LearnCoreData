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
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblIsOnApprobation: UILabel!
    
    func populate(_ employee: EmployeeEntity) {
        lblFullName.text = fullName(of: employee)
        lblStartDate.text = stringFromDate(employee.startDate ?? Date())
        lblIsOnApprobation.text = employee.isOnApprobation ? "ДА" : "НЕТ"
    }
    
    private func fullName(of employee: EmployeeEntity) -> String {
        return [employee.lastName,
                employee.firstName,
                employee.middleName]
            .compactMap {$0}
            .joined(separator: " ")
    }
    
    private func stringFromDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
}
