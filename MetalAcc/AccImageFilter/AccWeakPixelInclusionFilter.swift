//
//  AccWeakPixelInclusionFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/5.
//  Copyright © 2016年 JW. All rights reserved.
//

public class AccWeakPixelInclusionFilter:AccImageFilter{
    override public init(){
        super.init()
        self.name = "WeakPixelInclusion"
    }
    override public func applyFilter() {
        addCommandWithoutFactor()
    }
}