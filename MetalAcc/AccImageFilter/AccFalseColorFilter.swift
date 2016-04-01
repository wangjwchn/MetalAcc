//
//  AccFalseColorFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

public class AccFalseColorFilter: AccImageFilter {
    var firstColor:(R:Float,G:Float,B:Float)?
    var secondColor:(R:Float,G:Float,B:Float)?
    override init(){
        super.init()
        self.name = "FalseColor"
        self.firstColor = (0.0, 0.0, 0.5)
        self.secondColor = (1.0, 0.0, 0.0)
    }
    override public func applyFilter() {
        addCommandWithFactor([firstColor!.R,firstColor!.G,firstColor!.B,secondColor!.R,secondColor!.G,secondColor!.B])
    }
}