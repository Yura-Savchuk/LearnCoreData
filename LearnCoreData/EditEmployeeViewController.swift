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
        do {
            try coreDataManager.mainContext?.save()
            closeSelf()
        }
        catch {
            print("Error saving managed object context.")
        }
    }

}
