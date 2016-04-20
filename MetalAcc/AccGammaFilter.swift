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
    public var gamma:Float = 1.0
    public init(){
        super.init(name: "Gamma")
    }
    override public func getFactors()->[Float]{
        return [gamma]
    }
}