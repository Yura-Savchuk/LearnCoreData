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
        do {
            return try CoreDataManager.shared.mainContext?.fetch(request) ?? []
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEmployee = employees[indexPath.row]
        NotificationCenter.default.post(name: Notification.Name("DidSelectEmployee"), object: nil, userInfo: ["employee": selectedEmployee])
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let employee = employees[indexPath.row]
            CoreDataManager.shared.mainContext?.delete(employee)
            employees.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            do {
                try CoreDataManager.shared.mainContext?.save()
            }
            catch {
                print("Error saving managed object context.")
            }
        }
    }
    
}
