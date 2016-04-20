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
public class AccHueFilter: AccImageFilter {
    public var hue:Float = 90.0
    public init(){
        super.init(name: "Hue")
    }
    override public func getFactors()->[Float]{
        return [hue]
    }
}