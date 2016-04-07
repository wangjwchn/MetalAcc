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
public class AccPixelateFilter:AccImageFilter{
    public var pixelSize:UInt?//1~?
    override public init(){
        super.init()
        self.name = "Pixelate"
        self.pixelSize = 1;
    }
    override public func applyFilter() {
        addCommandWithFactor([pixelSize])
    }
}