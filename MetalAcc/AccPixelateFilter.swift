//
//  AccPixelateFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

import Foundation
/*
 AccPixelateFilter:Pixelate an image
 - pixelSize:The degree of pixelating (>0)
 */
class AccPixelateFilter:AccImageFilter{
    var pixelSize:UInt?//0~?
    override init(){
        super.init()
        self.name = "Pixelate"
    }
    override func applyFilter() {
        addCommandWithFactor([pixelSize])
    }
}