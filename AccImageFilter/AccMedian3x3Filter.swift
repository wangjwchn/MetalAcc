//
//  AccMedian3x3Filter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/5.
//  Copyright © 2016年 JW. All rights reserved.
//

public class AccMedian3x3Filter: AccImageFilter {
    override init(){
        super.init()
        self.name = "Median3x3"
    }
    override public func applyFilter(){
        addCommandWithoutFactor()
    }
}
