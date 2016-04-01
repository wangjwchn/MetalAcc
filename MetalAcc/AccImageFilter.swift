//
//  AccImageFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/3/30.
//  Copyright © 2016年 JW. All rights reserved.
//

import MetalKit
import MetalPerformanceShaders
class AccImageFilter{
    var name:String?
    weak var base:AccImage?
    func applyFilter(){}
    func addCommandWithoutFactor(){
        let commandBuffer = self.base!.commandQueue!.commandBuffer()
        let commandEncoder = commandBuffer.computeCommandEncoder()
        commandEncoder.setComputePipelineState(self.base!.pipelineState!)
        commandEncoder.setTexture(self.base!.inTexture!, atIndex: 0)
        commandEncoder.setTexture(self.base!.outTexture!, atIndex: 1)
        commandEncoder.dispatchThreadgroups(self.base!.threadGroups!, threadsPerThreadgroup: self.base!.threadGroupCount)
        commandEncoder.endEncoding()
        commandBuffer.commit()
        commandBuffer.waitUntilCompleted()
    }
    func addCommandWithFactor<T>(factors:[T]){
        let commandBuffer = self.base!.commandQueue!.commandBuffer()
        let commandEncoder = commandBuffer.computeCommandEncoder()
        commandEncoder.setComputePipelineState(self.base!.pipelineState!)
        commandEncoder.setTexture(self.base!.inTexture!, atIndex: 0)
        commandEncoder.setTexture(self.base!.outTexture!, atIndex: 1)
        for i in 0..<factors.count{
            var factor = factors[i]
            let size = max(sizeof(T),16)
            let buffer = self.base!.device!.newBufferWithBytes(&factor, length: size, options: [MTLResourceOptions.StorageModeShared])
            commandEncoder.setBuffer(buffer, offset: 0, atIndex: i)
        }
        commandEncoder.dispatchThreadgroups(self.base!.threadGroups!, threadsPerThreadgroup: self.base!.threadGroupCount)
        commandEncoder.endEncoding()
        commandBuffer.commit()
        commandBuffer.waitUntilCompleted()
    }
}





/*
 AccSobelFilter: Initialize a Sobel filter on a given device using the default color
 - transform. Default: BT.601/JPEG {0.299f, 0.587f, 0.114f}
*/
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

