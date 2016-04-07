//
//  AccBrightnessFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

/*
 AccBrightnessFilter: Adjusts the brightness of the image
 - brightness: The adjusted brightness (-1.0 ~ 1.0, with 0.0 as the default)
*/
public class AccBrightnessFilter: AccImageFilter {
    public var brightness:Float?
    override public init(){
        super.init()
        self.brightness = 0.0
        self.name = "Brightness"
    }
    override public func applyFilter() {
        addCommandWithFactor([brightness])
    }
}
