//
//  AccColorPackingFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/6.
//  Copyright © 2016年 JW. All rights reserved.
//

public class AccColorPackingFilter:AccImageFilter{
    override public init(){
        super.init()
        self.name = "ColorPacking"
    }
    override public func applyFilter() {
        addCommandWithoutFactor()
    }
}