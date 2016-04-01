//
//  AccChromaKeyFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//
class AccChromaKeyFilter: AccImageFilter {
    var thresholdSensitivity:Float?
    var smoothing:Float?
    var colorToReplace:(R:Float,G:Float,B:Float)?
    override init(){
        super.init()
        self.name = "ChromaKey"
    }
    override func applyFilter() {
        addCommandWithFactor([thresholdSensitivity,smoothing,colorToReplace?.R,colorToReplace?.G,colorToReplace?.B])
    }
}
