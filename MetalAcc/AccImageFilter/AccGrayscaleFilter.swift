//
//  AccGrayscaleFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//
/*
 AccGrayscaleFilter: Converts an image to grayscale
 */
public class AccGrayscaleFilter: AccImageFilter {
    var grayscale:Float?
    override init(){
        super.init()
        self.name = "Grayscale"
        self.grayscale = 1.0
    }
    override public func applyFilter() {
        addCommandWithFactor([grayscale])
    }
}