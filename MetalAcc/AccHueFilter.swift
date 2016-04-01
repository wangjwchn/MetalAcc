//
//  AccHueFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

/*
 AccHueFilter: Adjusts the hue of an image
 - hue: The hue angle, in degrees. 90 degrees by default
*/
class AccHueFilter: AccImageFilter {
    var hue:Float?
    override init(){
        super.init()
        self.name = "Hue"
    }
    override func applyFilter() {
        addCommandWithFactor([hue])
    }
}