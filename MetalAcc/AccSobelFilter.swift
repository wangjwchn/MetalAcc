//
//  AccSobelFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//
/*
 AccSobelFilter: Initialize a Sobel filter on a given device using the default color
 - transform. Default: BT.601/JPEG {0.299f, 0.587f, 0.114f}
 */
import MetalPerformanceShaders
class AccSobelFilter: AccImageFilter {
    override init(){
        super.init()
        self.name = "ImageSobel"
    }
    override func applyFilter() {
        let commandBuffer = self.base!.commandQueue!.commandBuffer()
        let sobel = MPSImageSobel(device: self.base!.device!)
        sobel.encodeToCommandBuffer(commandBuffer, sourceTexture: self.base!.inTexture!, destinationTexture: self.base!.outTexture!)
        commandBuffer.commit()
        commandBuffer.waitUntilCompleted()
    }
}


