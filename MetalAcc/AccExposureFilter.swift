//
//  AccExposureFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//
/*
 AccExposureFilter: Adjusts the exposure of the image
 - exposure: The adjusted exposure (-10.0 - 10.0, with 0.0 as the default)
 */
public class AccExposureFilter: AccImageFilter {
    public var exposure:Float = 0.0
    public init(){
        super.init(name: "Exposure")
    }
    override public func getFactors()->[Float]{
        return [exposure]
    }
}