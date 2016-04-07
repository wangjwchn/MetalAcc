//
//  AccSobelEdgeDetectionFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/5.
//  Copyright © 2016年 JW. All rights reserved.
//

public class AccSobelEdgeDetectionFilter:AccImageFilter{
    public var edgeStrength:Float?
    override public init(){
        super.init()
        self.name = "SobelEdgeDetection"
        self.edgeStrength = 1.0;
    }
    override public func applyFilter() {
        addCommandWithFactor([edgeStrength])
    }
}