//
//  AccConvolution3x3Filter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/5.
//  Copyright © 2016年 JW. All rights reserved.
//

public class AccConvolution3x3Filter: AccImageFilter {
    var convolutionKernel:(
    x11:Float,x12:Float,x13:Float,
    x21:Float,x22:Float,x23:Float,
    x31:Float,x32:Float,x33:Float)?
    override init(){
        super.init()
        self.name = "convolution3x3"
        self.convolutionKernel =
            (0, 0, 0,
             0, 1, 0,
             0, 0, 0)
    }
    override public func applyFilter() {
        addCommandWithFactor([convolutionKernel!.x11,convolutionKernel!.x12,convolutionKernel!.x13,convolutionKernel!.x21,convolutionKernel!.x22,convolutionKernel!.x23,convolutionKernel!.x31,convolutionKernel!.x32,convolutionKernel!.x33])

    }
}
