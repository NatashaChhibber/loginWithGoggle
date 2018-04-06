//
//  ViewController.swift
//  24_03
//
//  Created by Appinventiv on 24/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UIPageViewControllerDataSource {
   // View where the pages scrolling take place and skip button to proceed further
    
    var imageArray = ["1","2","3"]

    var pageViewController:UIPageViewController!
 
    func changeSlide() {
        
        print("Slide Change!")
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let nav = UINavigationController()
//        let mainStartView = ViewController(nibName: nil, bundle: nil)
//        nav.viewControllers = [mainStartView]
        
        self.pageViewController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)

        pageViewController.dataSource = self
        let initialContent = self.pageTutorialAtIndex(0) as ImageScrollView

        self.pageViewController.setViewControllers([initialContent],direction: UIPageViewControllerNavigationDirection.forward,animated: true, completion: nil)
        // creation pageViewController programatically
        self.pageViewController.view.frame = CGRect(x:0 ,y: 100 , width: self.view.frame.size.width,height: self.view.frame.size.height-100)

        
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGray
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
    
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func skipButton(_ sender: UIBarButtonItem) {
        
        let defaults = UserDefaults.standard
        defaults.setValue(true, forKey: "skipTutorialPages")
        defaults.synchronize()

        // to replace existing view with next view controller

        let MainStartView = storyboard?.instantiateViewController(withIdentifier: "MainStartViewid") as! MainStartView
        let addNavigator = UINavigationController(rootViewController: MainStartView)
        let appDelegate: AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
        appDelegate.window?.rootViewController = addNavigator
    }
}
    



extension ViewController
{
    func pageTutorialAtIndex(_ index: Int) ->ImageScrollView
    {
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ImageScrollViewid") as! ImageScrollView
        
        pageContentViewController.imageFile = imageArray[index]
        pageContentViewController.pageIndex = index
        return pageContentViewController
        
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let viewController = viewController as! ImageScrollView
        var index = viewController.pageIndex as Int

        if(index == 0 || index == NSNotFound)
        {
            return nil
        }
        
        index -= 1
        
        return self.pageTutorialAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let viewController = viewController as! ImageScrollView
        var index = viewController.pageIndex as Int
        
        if((index == NSNotFound))
        {
            return nil
        }
        
        index += 1
        
        if(index == imageArray.count)
        {
            return nil
        }
        
        return self.pageTutorialAtIndex(index)
    }
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return imageArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
