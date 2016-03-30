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
    var needPipeline:Bool?
    weak var base:AccImageBase?
    func applyFilter(){}
}

class Pixelate:AccImageFilter{
    var pixelSize:UInt?
    override init(){
        super.init()
        self.name = "Pixelate"
    }
    override func applyFilter() {
        let commandBuffer = self.base!.commandQueue!.commandBuffer()
        let commandEncoder = commandBuffer.computeCommandEncoder()
        
        commandEncoder.setComputePipelineState(self.base!.pipelineState!)
        commandEncoder.setTexture(self.base!.inTexture!, atIndex: 0)
        commandEncoder.setTexture(self.base!.outTexture!, atIndex: 1)
        
        let buffer = self.base!.device!.newBufferWithBytes(&pixelSize, length: sizeof(UInt), options: [MTLResourceOptions.StorageModeShared])
        commandEncoder.setBuffer(buffer, offset: 0, atIndex: 0)
        
        commandEncoder.dispatchThreadgroups(self.base!.threadGroups!, threadsPerThreadgroup: self.base!.threadGroupCount)
        commandEncoder.endEncoding()
        
        commandBuffer.commit()
        commandBuffer.waitUntilCompleted()
    }
}

class GaussianBlur:AccImageFilter{
    var sigma:Float?
    override init(){
        super.init()
        self.name = "GaussianBlur"
    }
    override func applyFilter() {
        //得到MetalPerformanceShaders需要使用的命令缓存区
        let commandBuffer = self.base!.commandQueue!.commandBuffer()
        
        // 初始化MetalPerformanceShaders高斯模糊，模糊半径(sigma)为slider所设置的值
        let gaussianblur = MPSImageGaussianBlur(device: self.base!.device!, sigma: sigma!)
        
        // 运行MetalPerformanceShader高斯模糊
        gaussianblur.encodeToCommandBuffer(commandBuffer, sourceTexture: self.base!.inTexture!, destinationTexture: self.base!.outTexture!)
        
        // 提交`commandBuffer`
        commandBuffer.commit()
        commandBuffer.waitUntilCompleted()
    }
}