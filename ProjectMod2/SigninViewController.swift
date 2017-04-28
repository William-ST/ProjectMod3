//
//  SigninViewController.swift
//  ProjectMod2
//
//  Created by William Sulca Talavera on 27/04/17.
//  Copyright © 2017 Virtualink inc. All rights reserved.
//

import UIKit

var userEntityValidate = UserEntity();
class SigninViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var edtUsername: UITextField!
    @IBOutlet weak var edtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        edtUsername.returnKeyType = UIReturnKeyType.next
        edtPassword.returnKeyType = UIReturnKeyType.go
        
        edtUsername.delegate = self
        edtPassword.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if (self.edtUsername == textField) {
            self.edtPassword.becomeFirstResponder()
        } else {
            signin()
        }
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func actionSigninTouchUp(_ sender: UIButton) {
        if (valid()) {
            signin()
        }
    }
    
    func signin() {
        self.view.endEditing(true)
        
        showLoading(message: "Validando usuario")
        
        let signinBody = SigninBody()
        signinBody.username = getUsername()
        signinBody.password = getPassword()
        
        CDMWebModel.signinCustomer(signinBody, conCompletionCorrecto: { (response) in
            
            self.hideLoading()
            
            if response == nil {
                print("---> 01")
                self.showError()
            } else {
                userEntityValidate = response as! UserEntity
                userEntityValidate.username = signinBody.username//self.getUsername()
                self.performSegue(withIdentifier: "successLoginLink", sender: self)
            }
            
        }, error: { (message) in
            self.hideLoading()
            self.showError(message: message)
            
        })
        
    }
    

    func getUsername() -> String {
        return edtUsername.text!
    }
    
    func getPassword() -> String {
        return edtPassword.text!
    }
    
    func valid() -> Bool {
        if (getUsername().isEmpty) {
            showError(message: "Ingrese un usuario válido")
            return false;
        } else if (getPassword().isEmpty) {
            showError(message: "Ingrese un password válido")
            return false;
        } else {
            return true;
        }
    }
    

}
