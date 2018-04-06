//
//  SignupController.swift
//  24_03
//
//  Created by Appinventiv on 29/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import UIKit

class SignupController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var lastNameTextfield: UITextField!
    @IBOutlet weak var dobTexfield: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad()
    {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
    }
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SignUpAction(_ sender: UIButton) {
    
//        if(emailTextField.text?.isValidEmail(enteredEmail: <#String#>)){
           let NextScreen = storyboard?.instantiateViewController(withIdentifier: "TableViewScreenid") as! TableViewScreen
           self.navigationController?.pushViewController(NextScreen, animated: true)
        }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
     
        
        if (textField == passwordTextField)
        {
            let name_reg = "[A-Z0-9a-z._%@+-]{6,10}"
            
            let name_test = NSPredicate(format: "SELF MATCHES %@", name_reg)
            
            if name_test.evaluate(with: passwordTextField.text) == false
            {
                showAlert(message: "Enter the password in correct format")
//                let alert = UIAlertController(title: "Information", message: "Enter the password in correct format", preferredStyle: .alert)
//                let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
//                let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
//
//                alert.addAction(ok)
//                alert.addAction(cancel)
//
//                self.present(alert, animated: true, completion: nil)
            }
        }
        
        if (textField == emailTextField)
        {
            let name_reg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            
            let name_test = NSPredicate(format: "SELF MATCHES %@", name_reg)
            
            if name_test.evaluate(with: emailTextField.text) == false
            {
                showAlert(message: "Enter the E-mail in correct format")
//                let alert = UIAlertController(title: "Information", message: "Enter the E-mail in correct format", preferredStyle: .alert)
//                let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
//                let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
//
//                alert.addAction(ok)
//                alert.addAction(cancel)
//
//                self.present(alert, animated: true, completion: nil)
            }
        }
        
       
    
    
    }
    func showAlert(message: String)
    {
        let alert = UIAlertController(title: "Alert !", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        UIApplication.shared.keyWindow?.rootViewController?.present( alert,animated: true, completion: nil)
        return
    }

}

extension SignupController: UITextFieldDelegate{
// on Enter button the user can write to nextfield
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            firstNameTextField.becomeFirstResponder()
        case firstNameTextField:
            lastNameTextfield.becomeFirstResponder()
        case lastNameTextfield:
            dobTexfield.becomeFirstResponder()
        default:
            emailTextField.becomeFirstResponder()
        }
        return true
    }
}
extension String{
    
    func isValidEmail(enteredEmail:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: enteredEmail)
    }
}

