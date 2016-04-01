//
//  AccLuminanceRangeFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

class AccLuminanceRangeFilter: AccImageFilter {
    var rangeReduction:Float?
    override init(){
        super.init()
        self.name = "LuminanceRange"
    }
    override func applyFilter() {
        addCommandWithFactor([rangeReduction])
    }
}