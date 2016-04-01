//
//  AccHighlightShadowFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//
class AccHighlightShadowFilter: AccImageFilter {
    var shadows:Float?
    var highlights:Float?
    override init(){
        super.init()
        self.name = "HighlightShadow"
    }
    override func applyFilter() {
        addCommandWithFactor([shadows,highlights])
    }
}
