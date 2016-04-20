//
//  AccRGBFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

/*
 AccRGBFilter: Adjusts the individual RGB channels of an image
  - red,green,blue: Normalized values by which each color channel is multiplied. The range is from 0.0 up, with 1.0 as the default.
*/

public class AccRGBFilter: AccImageFilter {
    public var color:(R:Float,G:Float,B:Float) = (1.0,1.0,1.0)
    public init(){
        super.init(name: "RGB")
    }
    override public func getFactors()->[Float]{
        return [color.R,color.G,color.B]
    }
}