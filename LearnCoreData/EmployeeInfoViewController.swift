//
//  EmployeeInfoViewController.swift
//  LearnCoreData
//
//  Created by Yura Savchuk on 12.10.2020.
//  Copyright © 2020 Yura Savchuk. All rights reserved.
//

import UIKit

class EmployeeInfoViewController: UIViewController {
    
    @IBOutlet weak var lblFullName: UILabel!
    
    private var employee: EmployeeEntity?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectEmployee(_:)), name: Notification.Name("DidSelectEmployee"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editEmployee" {
            let editVC = segue.destination as? EditEmployeeViewController
            editVC?.editableEmployeeId = employee?.id
        }
    }
    
    @objc private func didSelectEmployee(_ notification: NSNotification) {
        self.employee = notification.userInfo?["employee"] as? EmployeeEntity
        lblFullName.text = self.employee?.fullName() ?? ""
    }

    @IBAction func didSameDayNewsMembersButton(_ sender: Any) {
        let employees = self.employee?.value(forKey: "sameDateNewsmembers") as? [EmployeeEntity] ?? []
        
        print(employees.map {$0.fullName()})
    }
    
}
