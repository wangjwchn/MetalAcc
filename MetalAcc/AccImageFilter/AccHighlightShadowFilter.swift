//
//  AccHighlightShadowFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//
public class AccHighlightShadowFilter: AccImageFilter {
    var shadows:Float?
    var highlights:Float?
    override init(){
        super.init()
        self.name = "HighlightShadow"
        self.shadows = 0.0
        self.highlights = 1.0
    }
    override public func applyFilter() {
        addCommandWithFactor([shadows,highlights])
    }
}
