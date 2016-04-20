//
//  AccLuminanceFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//
/*
 AccLuminanceFilter: Pixels with a luminance above the threshold will appear white, and those below will be black
 - luminance: The luminance factor, from 0.0 to 1.0, with a default of 0.5
 */
public class AccLuminanceFilter: AccImageFilter {
    public var luminance:Float = 0.5
    public init(){
        super.init(name: "Luminance")
    }
    override public func getFactors()->[Float]{
        return [luminance]
    }
}

