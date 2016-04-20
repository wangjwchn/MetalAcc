//
//  AccContrastFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//


/*
 AccContrastFilter: Adjusts the contrast of the image
 - contrast: The adjusted contrast (0.0 ~ 4.0, with 1.0 as the default)
 */
public class AccContrastFilter: AccImageFilter {
    public var contrast:Float = 1.0
    public init(){
        super.init(name: "Contrast")
    }
    override public func getFactors()->[Float]{
        return [contrast]
    }
}

