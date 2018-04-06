//
//  TableViewScreen.swift
//  
//
//  Created by Appinventiv on 05/04/18.
//

import UIKit

class TableViewScreen: UIViewController {
    var menuShown = AppDelegate().menuShown

    var Profileview = ProfileMenuBarController()

    override func viewDidLoad() {
        super.viewDidLoad()
        Profileview = storyboard?.instantiateViewController(withIdentifier: "ProfileMenuBarControllerid") as! ProfileMenuBarController
       navigationController?.setNavigationBarHidden(true, animated: true)
        Menu()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func SlideBarButton(_ sender: UIButton) {
        
       if menuShown {
        
                showMenu()

            }
            else{
                 hideMenu()

          }
        }
    
    func Menu(){
        
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondsToGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondsToGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
        
    }
    
    
    @objc func respondsToGesture(gesture : UISwipeGestureRecognizer){
        switch gesture.direction{
        case UISwipeGestureRecognizerDirection.right: print("swipe Right")
        showMenu()
        //AppDelegate.menuBool = true
        case UISwipeGestureRecognizerDirection.left: print("swipe Left")
        hideMenu()
        default : break
        }
    }
    
    
    
    func showMenu() {
        UIView.animate(withDuration: 0.3, animations: {
            self.Profileview.view.frame = CGRect(x: 0, y:50, width: self.view.frame.width, height: self.view.frame.height)
            self.Profileview.view.backgroundColor = UIColor.black.withAlphaComponent(0)
            self.addChildViewController(self.Profileview)
            self.view.addSubview(self.Profileview.view)
        }, completion: { (Bool) -> Void in
            self.menuShown = false
        })
    }
    
    func hideMenu() {
        UIView.animate(withDuration: 0.3, animations: {
            self.Profileview.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 50, width: self.view.frame.width, height: self.view.frame.height)
            print("removing")
        }, completion: { (Bool) -> Void in
            self.Profileview.view.removeFromSuperview()
            print("remove menu")
            self.menuShown = true
        })
    }

}
