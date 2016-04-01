//
//  AccLuminanceThresholdFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//
/*
 AccLuminanceThresholdFilter: Pixels with a luminance above the threshold will appear white, and those below will be black
 - threshold: The luminance threshold, from 0.0 to 1.0, with a default of 0.5
 */
public class AccLuminanceThresholdFilter: AccImageFilter {
    var threshold:Float?
    override init(){
        super.init()
        self.name = "LuminanceThreshold"
        self.threshold = 0.5
    }
    override public func applyFilter() {
        addCommandWithFactor([threshold])
    }
}


