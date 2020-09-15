//
//  EmployeesViewController.swift
//  LearnCoreData
//
//  Created by Yura Savchuk on 07.09.2020.
//  Copyright © 2020 Yura Savchuk. All rights reserved.
//

import UIKit
import CoreData

class EmployeesViewController: UITableViewController {
    
    private var employees: [EmployeeEntity] = []
    private let coreDataManager = CoreDataManager(modelName: "LearnCoreData")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employees = fetchAllEmployees()
    }
    
    private func fetchAllEmployees() -> [EmployeeEntity] {
        let request: NSFetchRequest<EmployeeEntity> = EmployeeEntity.fetchRequest()
        do {
            return try coreDataManager.mainContext?.fetch(request) ?? []
        }
        catch {
            print("Fetch employees error \(error.localizedDescription)")
            return []
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeTableViewCell", for: indexPath) as! EmployeeTableViewCell
        cell.populate(employees[indexPath.row])
        return cell
    }

}

