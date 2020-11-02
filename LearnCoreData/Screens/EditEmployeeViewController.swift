//
//  EditEmployeeViewController.swift
//  LearnCoreData
//
//  Created by Yura Savchuk on 15.09.2020.
//  Copyright © 2020 Yura Savchuk. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreData

class EditEmployeeViewController: UIViewController {
    
    var editableEmployeeId: Int16?
    private var editableEmployee: EmployeeEntity?

    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfMiddleName: UITextField!
    @IBOutlet weak var tfAge: UITextField!
    @IBOutlet weak var tfCity: UITextField!
    @IBOutlet weak var tfStreet: UITextField!
    @IBOutlet weak var tfPostalCode: UITextField!
    @IBOutlet weak var btnJob: UIButton!
    @IBOutlet weak var dpStartDate: UIDatePicker!
    @IBOutlet weak var isOnApprobation: UISwitch!
    
    private var selectedJob: JobEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchEditableEmployeeIfNeed()
        prefillWithEditableEmployeeIfExisted()
    }
    
    private func fetchEditableEmployeeIfNeed() {
        if let editableEmployeeId = editableEmployeeId {
            let fetchRequest: NSFetchRequest<EmployeeEntity> = EmployeeEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == \(editableEmployeeId)")
            do {
                editableEmployee = try CoreDataManager.shared.mainContext?.fetch(fetchRequest).first
            } catch {
                print("Error happend: \(error.localizedDescription)")
            }
        }
    }
    
    private func prefillWithEditableEmployeeIfExisted() {
        if let editableEmployee = editableEmployee {
            prefill(with: editableEmployee)
        }
    }
    
    private func prefill(with employee: EmployeeEntity) {
        tfFirstName.text = employee.firstName
        tfLastName.text = employee.lastName
        tfMiddleName.text = employee.middleName
        tfAge.text = String(employee.age)
        tfCity.text = employee.address?.city
        tfStreet.text = employee.address?.street
        tfPostalCode.text = employee.address?.postalCode
        isOnApprobation.isOn = employee.isOnApprobation
        if let startDate = employee.startDate { dpStartDate.date = startDate
        }
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        closeSelf()
    }
    
    private func closeSelf() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        let employeeEntity = editableEmployee ?? EmployeeEntity(context: CoreDataManager.shared.mainContext!)        
        employeeEntity.id = Int16.random(in: 0..<Int16.max)
        employeeEntity.firstName = tfFirstName.text
        employeeEntity.lastName = tfLastName.text
        employeeEntity.middleName = tfMiddleName.text
        employeeEntity.age = Int16(tfAge.text ?? "") ?? 0
        
        let address = AddressEntity(context: CoreDataManager.shared.mainContext!)
        address.city = tfCity.text
        address.street = tfStreet.text
        address.postalCode = tfPostalCode.text
        employeeEntity.address = address
        
        employeeEntity.isOnApprobation = isOnApprobation.isOn
        employeeEntity.startDate = dpStartDate.date
        
        employeeEntity.jobId = selectedJob?.id
        
        do {
            try CoreDataManager.shared.mainContext?.save()
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "EmployeeSaved")))
            closeSelf()
        }
        catch {
            print("Error saving managed object context.")
        }
    }
    
    @IBAction func didTapJobButton(_ sender: Any) {
        
    }
    
}
