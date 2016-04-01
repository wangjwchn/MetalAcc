//
//  AccGaussianBlurFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//
/*
 AccGaussianBlurFilter:Gaussian blur
 - sigma:The standard deviation of gaussian blur filter(0.0 ~ 10.0, with 0.0 as the default)
 */
import MetalPerformanceShaders
public class AccGaussianBlurFilter:AccImageFilter{
    var sigma:Float?
    override init(){
        super.init()
        self.name = "GaussianBlur"
    }
    override public func applyFilter() {
        let commandBuffer = self.base!.commandQueue!.commandBuffer()
        let gaussianblur = MPSImageGaussianBlur(device: self.base!.device!, sigma: sigma!)
        gaussianblur.encodeToCommandBuffer(commandBuffer, sourceTexture: self.base!.inTexture!, destinationTexture: self.base!.outTexture!)
        commandBuffer.commit()
        commandBuffer.waitUntilCompleted()
    }
}
