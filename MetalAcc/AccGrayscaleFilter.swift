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
class AccGrayscaleFilter: AccImageFilter {
    var grayscale:Float?
    override init(){
        super.init()
        self.name = "Grayscale"
    }
    override func applyFilter() {
        addCommandWithFactor([grayscale])
    }
    
}