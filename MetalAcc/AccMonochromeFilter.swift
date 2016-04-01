//
//  AccMonochromeFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//
/*
 AccMonochromeFilter: Converts the image to a single-color version, based on the luminance of each pixel
 - intensity: The degree to which the specific color replaces the normal image color (0.0 - 1.0, with 1.0 as the default)
 - color: The color to use as the basis for the effect, with (0.6, 0.45, 0.3, 1.0) as the default.
*/
class AccMonochromeFilter: AccImageFilter {
    var intensity:Float?
    var filterColor:(R:Float,G:Float,B:Float)?
    override init(){
        super.init()
        self.name = "Monochrome"
    }
    override func applyFilter() {
        addCommandWithFactor([intensity,filterColor!.R,filterColor!.G,filterColor!.B])
    }
}