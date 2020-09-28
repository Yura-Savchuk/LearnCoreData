//
//  EditEmployeeViewController.swift
//  LearnCoreData
//
//  Created by Yura Savchuk on 15.09.2020.
//  Copyright © 2020 Yura Savchuk. All rights reserved.
//

import UIKit

class EditEmployeeViewController: UIViewController {

    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfMiddleName: UITextField!
    @IBOutlet weak var tfAge: UITextField!
    @IBOutlet weak var tfCity: UITextField!
    @IBOutlet weak var tfStreet: UITextField!
    @IBOutlet weak var tfPostalCode: UITextField!
    @IBOutlet weak var btnJob: UIButton!
    
    private var selectedJob: JobEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func didTapBack(_ sender: Any) {
        closeSelf()
    }
    
    private func closeSelf() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        let coreDataManager = CoreDataManager(modelName: "LearnCoreData")
        let employeeEntity = EmployeeEntity(context: coreDataManager.mainContext!)
        employeeEntity.firstName = tfFirstName.text
        employeeEntity.lastName = tfLastName.text
        employeeEntity.middleName = tfMiddleName.text
        employeeEntity.age = Int16(tfAge.text ?? "") ?? 0
        
        let address = AddressEntity(context: coreDataManager.mainContext!)
        address.city = tfCity.text
        address.street = tfStreet.text
        address.postalCode = tfPostalCode.text
        employeeEntity.address = address
        
        employeeEntity.jobId = selectedJob?.id
        
        do {
            try coreDataManager.mainContext?.save()
            closeSelf()
        }
        catch {
            print("Error saving managed object context.")
        }
    }
    
    @IBAction func didTapJobButton(_ sender: Any) {
        
    }
    
}
