//
//  AccOpacityFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

public class AccOpacityFilter: AccImageFilter {
    public var opacity:Float = 1.0
    public init(){
        super.init(name: "Opacity")
    }
    override public func getFactors()->[Float]{
        return [opacity]
    }
}
