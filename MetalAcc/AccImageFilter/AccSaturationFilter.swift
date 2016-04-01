//
//  AccSaturationFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

/*
 AccSaturationFilter: Adjusts the saturation of an image
 - saturation: The degree of saturation or desaturation to apply to the image (0.0 ~ 2.0, with 1.0 as the default)
 */
public class AccSaturationFilter: AccImageFilter {
    var saturation:Float?
    override init(){
        super.init()
        self.name = "Saturation"
        self.saturation = 1.0
    }
    override public func applyFilter() {
        addCommandWithFactor([saturation])
    }
    
}
