//
//  EmployeesViewController.swift
//  LearnCoreData
//
//  Created by Yura Savchuk on 07.09.2020.
//  Copyright © 2020 Yura Savchuk. All rights reserved.
//

import UIKit
import CoreData
import NotificationCenter

class EmployeesViewController: UITableViewController {
    
    private var employees: [EmployeeEntity] = []
    private let coreDataManager = CoreDataManager(modelName: "LearnCoreData")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employees = fetchAllEmployees()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTableView), name: Notification.Name("EmployeeSaved"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func fetchAllEmployees() -> [EmployeeEntity] {
        let request: NSFetchRequest<EmployeeEntity> = EmployeeEntity.fetchRequest()
        
//        request.predicate = NSPredicate(format: "firstName == %@", "Oleg")
//        request.predicate = NSPredicate(format: "age > %i", 20)
//        request.predicate = NSPredicate(format: "firstName ==[c] %@", "oleG")
//        request.predicate = NSPredicate(format: "firstName == %@ OR age >= %i", "Oleg", 30)
//        request.predicate = NSPredicate(format: "isOnApprobation == %@ AND age < %i", NSNumber(value: false), 30)
//        request.predicate = NSPredicate(format: "isOnApprobation == %@ OR firstName == %@", NSNumber(value: false), "Oleg")
//        request.predicate = NSPredicate(format: "firstName BEGINSWITH[c] %@", "s")
//        request.predicate = NSPredicate(format: "lastName ENDSWITH %@", "a")
//        request.predicate = NSPredicate(format: "middleName CONTAINS[c] %@", "e"
        
        do {
            return try coreDataManager.mainContext?.fetch(request) ?? []
        }
        catch {
            print("Fetch employees error \(error.localizedDescription)")
            return []
        }
    }
    
    @objc private func refreshTableView() {
        employees = fetchAllEmployees()
        tableView.reloadData()
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

