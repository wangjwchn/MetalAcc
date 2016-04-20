//
//  AccFalseColorFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

public class AccFalseColorFilter: AccImageFilter {
    public var firstColor:(R:Float,G:Float,B:Float) = (0.0, 0.0, 0.5)
    public var secondColor:(R:Float,G:Float,B:Float) = (1.0, 0.0, 0.0)
    public init(){
        super.init(name: "FalseColor")
    }
    override public func getFactors()->[Float]{
        return [firstColor.R,firstColor.G,firstColor.B,secondColor.R,secondColor.G,secondColor.B]
    }
}