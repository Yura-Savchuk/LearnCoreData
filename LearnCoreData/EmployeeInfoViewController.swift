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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectEmployee(_:)), name: Notification.Name("DidSelectEmployee"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func didSelectEmployee(_ notification: NSNotification) {
        guard let employee = notification.userInfo?["employee"] as? EmployeeEntity else {
            return
        }
        lblFullName.text = employee.fullName()
    }

}
