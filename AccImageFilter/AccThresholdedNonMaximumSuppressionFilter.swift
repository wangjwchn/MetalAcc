//
//  AccThresholdedNonMaximumSuppressionFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/5.
//  Copyright © 2016年 JW. All rights reserved.
//

public class AccThresholdedNonMaximumSuppressionFilter: AccImageFilter {
    public var threshold:Float?
    override init(){
        super.init()
        self.threshold = 0.8
        self.name = "ThresholdedNonMaximumSuppression"
    }
    override public func applyFilter() {
        addCommandWithFactor([threshold])
    }
}