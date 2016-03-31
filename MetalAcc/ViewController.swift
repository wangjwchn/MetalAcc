//
//  ViewController.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/3/29.
//  Copyright © 2016年 JW. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: "AnimalImage")!
        
        // Create ImageView and add animated image
        let imageview = UIImageView()
        imageview.frame = CGRect(x: 0.0, y: 40 , width: 250, height: 200)
        
        let imagebase = AccImage()
        imagebase.AddImage(image)
        
        let filter = Gamma()
        filter.factor = 1.0
        //filter.sigma  = 3.0
        /*
        let filter = Pixelate()
        filter.pixelSize = 5
         */
        imagebase.AddFilter(filter)
        //let after = image
        let after = imagebase.Processing()
        imageview.image = after
 
        self.view.addSubview(imageview)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

