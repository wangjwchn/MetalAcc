//
//  AccGammaFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//


/*
 AccGammaFilter: Adjusts the gamma of an image
 - gamma: The gamma adjustment to apply (0.0 ~ 3.0, with 1.0 as the default)
 */
public class AccGammaFilter: AccImageFilter {
    var gamma:Float?
    override init(){
        super.init()
        self.name = "Gamma"
        self.gamma = 1.0
    }
    override public func applyFilter() {
        addCommandWithFactor([gamma])
    }
}