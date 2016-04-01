//
//  AccColorMatrixFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//
/*
 AccColorMatrixFilter: Transforms the colors of an image by applying a matrix to them

 - colorMatrix: A 4x4 matrix used to transform each color in an image
 - intensity: The degree to which the new transformed color replaces the original color for each pixel
*/
public class AccColorMatrixFilter: AccImageFilter {
    var intensity:Float?
    var colorMatrix:(   x11:Float,x12:Float,x13:Float,x14:Float,
                        x21:Float,x22:Float,x23:Float,x24:Float,
                        x31:Float,x32:Float,x33:Float,x34:Float,
                        x41:Float,x42:Float,x43:Float,x44:Float)?
    override init(){
        super.init()
        self.name = "ColorMatrix"
        self.intensity = 0.0
        self.colorMatrix = (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
    }
    override public func applyFilter() {
        addCommandWithFactor([intensity,
colorMatrix!.x11,colorMatrix!.x12,colorMatrix!.x13,colorMatrix!.x14,
colorMatrix!.x21,colorMatrix!.x22,colorMatrix!.x23,colorMatrix!.x24,
colorMatrix!.x31,colorMatrix!.x32,colorMatrix!.x33,colorMatrix!.x34,
colorMatrix!.x41,colorMatrix!.x42,colorMatrix!.x43,colorMatrix!.x44])
    }
}
