//
//  AccOpacityFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

public class AccOpacityFilter: AccImageFilter {
    public var opacity:Float?
    override public init(){
        super.init()
        self.opacity = 1.0
        self.name = "Opacity"
    }
    override public func applyFilter() {
        addCommandWithFactor([opacity])
    }
}