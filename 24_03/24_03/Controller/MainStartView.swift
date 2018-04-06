//
//  MainStartView.swift
//  24_03
//
//  Created by Appinventiv on 24/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import UIKit

import GoogleSignIn
import FacebookLogin
import FBSDKLoginKit

class MainStartView: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var GoogleSignOut: UIButton!
    @IBOutlet weak var signInButton: GIDSignInButton!
    var dict : [String : AnyObject]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().uiDelegate = self
        NotificationCenter.default.addObserver(self, selector:#selector(MainStartView.receiveToggleAuthUINotification(_:)), name: NSNotification.Name(rawValue: "ToggleAuthUINotification"), object: nil)
        
        toggleAuthUI()
        //creating button
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        loginButton.delegate = self
        //adding it to view
        view.addSubview(loginButton)
        //if the user is already logged in
        if let accessToken = FBSDKAccessToken.current(){
            getFBUserData()
        }
        
    }
    
//    @IBAction func facebookLoginButton(_ sender: UIButton)
//    {
//
//        if let accessToken = FBSDKAccessToken.current() {
//            print(accessToken)
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapViewid") as? MapView
//            self.navigationController?.pushViewController(vc!, animated: true)
//        }
//        FacebookSignInManager.basicInfoWithCompletionHandler(self) { (dataDictionary:Dictionary<String, AnyObject>?, error:NSError?) -> Void in
//            print(dataDictionary)
//        }
//    }
//
    @IBAction func GoogleSignOut(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signOut()
        showToast(message: "You have logged out")
        toggleAuthUI()

    }
    
    func toggleAuthUI() {
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            // Signed in
            let showMap = storyboard?.instantiateViewController(withIdentifier: "MapViewid") as! MapView
            self.navigationController?.pushViewController(showMap, animated: true)
                self.signInButton.isHidden = true
                self.GoogleSignOut.isHidden = false
         
        } else {
            signInButton.isHidden = false
            GoogleSignOut.isHidden = true
        }
    }
    
    @objc func receiveToggleAuthUINotification(_ notification: NSNotification) {
        if notification.name.rawValue == "ToggleAuthUINotification" {
            self.toggleAuthUI()
            if notification.userInfo != nil {
                guard (notification.userInfo as? [String:String]) != nil else { return }
                //self.statusText.text = userInfo["statusText"]!
            }
        }
    }
    
   // when login button clicked
        func loginButtonClicked(){
            let loginManager = LoginManager()
            loginManager.logIn(readPermissions: [ .publicProfile], viewController: self) { (LoginResult) in
                switch LoginResult{
                case .failed(let error) :
                    print(error)
                case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                    self.getFBUserData()
                case .cancelled:
                    print("user cancelled login")
                }
            }
        }
    
    //function is fetching the user data
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    print(result!)
                    print(self.dict)
                }
            })
        }
        
}
    
    @IBAction func RegisterButton(_ sender: UIButton) {
        let signup = storyboard?.instantiateViewController(withIdentifier: "SignupControllerid") as! SignupController
        navigationController?.pushViewController(signup, animated: true)
    }
    

// func for Toast 
 func showToast(message : String) {
 
 let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        toastLabel.textColor = UIColor.black
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
    
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
        toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
 
        toastLabel.removeFromSuperview()
                        })
 }

}

extension MainStartView: LoginButtonDelegate
{
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult)
      {
        let showMap = storyboard?.instantiateViewController(withIdentifier: "MapViewid") as! MapView
        self.navigationController?.pushViewController(showMap, animated: true)
      }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton)
      {
        LoginManager().logOut()
        showToast(message: "signOut From Facebook")
      }
}
