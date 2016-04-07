//
//  AccNonMaximumSuppressionFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/5.
//  Copyright © 2016年 JW. All rights reserved.
//

public class AccNonMaximumSuppressionFilter: AccImageFilter {
    override init(){
        super.init()
        self.name = "NonMaximumSuppression"
    }
    override public func applyFilter() {
        addCommandWithoutFactor()
    }
}