//
//  AccDirectionalNonMaximumSuppressionFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/5.
//  Copyright © 2016年 JW. All rights reserved.
//

public class AccDirectionalNonMaximumSuppressionFilter: AccImageFilter {
    public var threshold:(lower:Float,upper:Float)?
    override public init(){
        super.init()
        self.threshold = (0.1,0.5)
        self.name = "DirectionalNonMaximumSuppression"
    }
    override public func applyFilter() {
        addCommandWithFactor([threshold!.lower,threshold!.upper])
    }
}