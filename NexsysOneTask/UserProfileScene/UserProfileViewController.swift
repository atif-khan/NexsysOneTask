//
//  UserProfileViewController.swift
//  NexsysOneTask
//
//  Created by Atif Khan on 15/06/2020.
//  Copyright © 2020 Atif Khan. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var departmentTF: UITextField!
    
    
    var user: User!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameTF.text = user.name
        emailTF.text = user.email
        ageTF.text = "\(user.age)"
        departmentTF.text = user.department
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
