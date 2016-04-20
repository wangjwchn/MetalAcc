//
//  AccHighlightShadowFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//
public class AccHighlightShadowFilter: AccImageFilter {
    var shadows:Float = 0.0
    var highlights:Float = 1.0
    
    public init(){
        super.init(name: "HighlightShadow")
    }
    override public func getFactors()->[Float]{
        return [shadows,highlights]
    }
}
