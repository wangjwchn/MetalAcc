//
//  AccSharpenFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/5.
//  Copyright © 2016年 JW. All rights reserved.
//

public class AccSharpenFilter: AccImageFilter {
    public var sharpness:Float?
    override public init(){
        super.init()
        self.sharpness = 0.0
        self.name = "Sharpen"
    }
    override public func applyFilter() {
        addCommandWithFactor([sharpness])
    }
}