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
    public var brightness:Float = 0.0
    public init(){
        super.init(name: "Brightness")
    }
    override public func getFactors()->[Float]{
        return [brightness]
    }
}

