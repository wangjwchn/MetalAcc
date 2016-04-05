//
//  AccSolidColorGenerator.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

public class AccSolidColorGenerator: AccImageFilter {
    var color:(R:Float,G:Float,B:Float,A:Float)?
    override init(){
        super.init()
        self.name = "SolidColor"
        self.color = (1.0,1.0,1.0,1.0)
    }
    override public func applyFilter() {
        addCommandWithFactor([color!.R,color!.G,color!.B,color!.A])
    }
}

