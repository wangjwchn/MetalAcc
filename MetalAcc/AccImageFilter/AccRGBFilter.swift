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
    var color:(R:Float,G:Float,B:Float)?
    override init(){
        super.init()
        self.name = "RGB"
        color = (1.0,1.0,1.0)
    }
    override public func applyFilter() {
        addCommandWithFactor([color!.R,color!.G,color!.B])
    }
}