//
//  ImageScrollView.swift
//  24_03
//
//  Created by Appinventiv on 24/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import UIKit

// IMAGESCROLLING DAURING LAUNCH OF SCREEN

class ImageScrollView: UIViewController {

    @IBOutlet weak var ScrollImageView: UIImageView!

    var imageFile: String!
    var pageIndex:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     ScrollImageView.image = UIImage(named: imageFile)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
