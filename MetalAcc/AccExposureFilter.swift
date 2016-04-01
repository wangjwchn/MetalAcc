//
//  AccExposureFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//
/*
 AccExposureFilter: Adjusts the exposure of the image
 - exposure: The adjusted exposure (-10.0 - 10.0, with 0.0 as the default)
 */
class AccExposureFilter: AccImageFilter {
    var exposure:Float?
    override init(){
        super.init()
        self.name = "Exposure"
    }
    override func applyFilter() {
        addCommandWithFactor([exposure])
    }
}