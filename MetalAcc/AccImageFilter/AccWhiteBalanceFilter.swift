//
//  AccWhiteBalanceFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

public class AccWhiteBalanceFilter: AccImageFilter {
    var temperature:Float?
    var tint:Float?
    override init(){
        super.init()
        self.name = "WhiteBalance"
        self.temperature = 5000
        self.tint = 0
    }
    override public func applyFilter() {
        addCommandWithFactor([temperature,tint])
    }
}
