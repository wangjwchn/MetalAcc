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
    public var saturation:Float = 1.0
    public init(){
        super.init(name: "Saturation")
    }
    override public func getFactors()->[Float]{
        return [saturation]
    }
}
