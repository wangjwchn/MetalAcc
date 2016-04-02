//
//  ViewController.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/3/29.
//  Copyright © 2016年 JW. All rights reserved.
//

import UIKit
import MetalAcc
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let inimage = UIImage(named: "AnimalImage")!
        
        let imageview = UIImageView()
        imageview.frame = CGRect(x: 0.0, y: 40 , width: 250, height: 200)
        
        let accimage = AccImage()
        accimage.AddImage(inimage)

        let filter = AccBrightnessFilter()
        /*
        let filter = AccTransformFilter()
        filter.affineTransform = CGAffineTransform(a: 1.0, b: 0.0, c: 0.0, d: 1.0, tx: 0.0, ty: 0.0)
        */
        accimage.AddFilter(filter)
        
        let outimage = accimage.Processing()
        imageview.image = outimage
        
        self.view.addSubview(imageview)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

