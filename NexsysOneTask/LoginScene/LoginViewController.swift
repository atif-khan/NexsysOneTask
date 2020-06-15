//
//  ViewController.swift
//  NexsysOneTask
//
//  Created by Atif Khan on 15/06/2020.
//  Copyright © 2020 Atif Khan. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class LoginViewController: UIViewController {

    let USER_KEY = "user"
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let userEncoded = UserDefaults.standard.value(forKey: USER_KEY) as? Data {
            do {
                let user = try JSONDecoder().decode(User.self, from: userEncoded)
                self.setFields(user: user)
                performSegue(withIdentifier: "UserProfileSegue", sender: user)
            } catch (let err) {
                debugPrint(err)
                //Show error message
            }
        }
    }
    
    func setFields(user: User) {
        userNameTF.text = user.userName
        passwordTF.text = user.password
    }
    
    @IBAction func LoginButtonAction(_ sender: Any) {
        if !validateFields() {
            showAlertMessage(message: Constants.Messages.fillAllFieldsMsg)
            return
        }
        requestLogin()
    }
    
    private func requestLogin() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let param = ["userName": userNameTF.text, "password": passwordTF.text]
         
        AF.request(Constants.baseURL + Constants.EndPoints.login, method: .post, parameters: param as Parameters, encoding: JSONEncoding.default)
        .response {[weak self] response in
            guard let weakSelf = self else { return }
            MBProgressHUD.hide(for: weakSelf.view, animated: true )
            guard let responseData = response.data else { return }
            
            do {
                let viewModel = try JSONDecoder().decode(LoginViewModel.Response.self, from: responseData)
                if viewModel.status == "success" {
                    weakSelf.saveUser(user: viewModel.user)
                    weakSelf.setFields(user: viewModel.user)
                    weakSelf.performSegue(withIdentifier: "UserProfileSegue", sender: viewModel.user)
                } else {
                    weakSelf.showAlertMessage(message: viewModel.message)
                }
            } catch (let err) {
                debugPrint(err)
            }
        }
    }
    
    private func validateFields() -> Bool {
        return userNameTF.hasText && passwordTF.hasText
    }
    
    private func showAlertMessage(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func saveUser(user: User) {
        do {
            let encodeData = try JSONEncoder().encode(user)
            UserDefaults.standard.set(encodeData, forKey: USER_KEY)
        } catch (let err) {
            debugPrint(err)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? UserProfileViewController, let user = sender as? User  {
            vc.user = user
        }
    }
}

