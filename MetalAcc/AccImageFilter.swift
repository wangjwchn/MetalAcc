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
    weak var base:AccImage?
    func applyFilter(){}
    func addCommandWithZeroFactor(){
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
    func addCommandWithOneFactor<T>(factor:T){
        var factor = factor
        let size = max(sizeof(T),16)
        let commandBuffer = self.base!.commandQueue!.commandBuffer()
        let commandEncoder = commandBuffer.computeCommandEncoder()
        commandEncoder.setComputePipelineState(self.base!.pipelineState!)
        commandEncoder.setTexture(self.base!.inTexture!, atIndex: 0)
        commandEncoder.setTexture(self.base!.outTexture!, atIndex: 1)
        let buffer = self.base!.device!.newBufferWithBytes(&factor, length: size, options: [MTLResourceOptions.StorageModeShared])
        commandEncoder.setBuffer(buffer, offset: 0, atIndex: 0)
        commandEncoder.dispatchThreadgroups(self.base!.threadGroups!, threadsPerThreadgroup: self.base!.threadGroupCount)
        commandEncoder.endEncoding()
        commandBuffer.commit()
        commandBuffer.waitUntilCompleted()

    }
}

class Pixelate:AccImageFilter{
    var pixelSize:UInt?//0~?
    override init(){
        super.init()
        self.name = "Pixelate"
    }
    override func applyFilter() {
        addCommandWithOneFactor(pixelSize)
    }
}

class GaussianBlur:AccImageFilter{
    var sigma:Float?//0.0~10.0
    override init(){
        super.init()
        self.name = "GaussianBlur"
    }
    override func applyFilter() {
        let commandBuffer = self.base!.commandQueue!.commandBuffer()
        let gaussianblur = MPSImageGaussianBlur(device: self.base!.device!, sigma: sigma!)
        gaussianblur.encodeToCommandBuffer(commandBuffer, sourceTexture: self.base!.inTexture!, destinationTexture: self.base!.outTexture!)
        commandBuffer.commit()
        commandBuffer.waitUntilCompleted()
    }
}

class Sobel: AccImageFilter {
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


class Grayscale: AccImageFilter {
    var grayscale:Float?
    override init(){
        super.init()
        self.name = "Grayscale"
    }
    override func applyFilter() {
        addCommandWithOneFactor(grayscale)
    }

}

class Brightness: AccImageFilter {
    var brightness:Float?//0.0~1.0
    override init(){
        super.init()
        self.name = "Brightness"
    }
    override func applyFilter() {
        addCommandWithOneFactor(brightness)
    }
    
}

class Saturation: AccImageFilter {
    var saturation:Float?//0.0~1.0
    override init(){
        super.init()
        self.name = "Saturation"
    }
    override func applyFilter() {
        addCommandWithOneFactor(saturation)
    }
    
}

// Gamma ranges from 0.0 to 3.0, with 1.0 as the normal level
class Gamma: AccImageFilter {
    var gamma:Float?//0.0~3.0
    override init(){
        super.init()
        self.name = "Gamma"
    }
    override func applyFilter() {
        addCommandWithOneFactor(Gamma)
    }
    
}

class ColorInvert: AccImageFilter {
    override init(){
        super.init()
        self.name = "ColorInvert"
    }
    override func applyFilter() {
        addCommandWithZeroFactor()
    }
}

//Contrast ranges from 0.0 to 4.0 (max contrast), with 1.0 as the normal level
class Contrast: AccImageFilter {
    var contrast:Float?//0.0~3.0
    override init(){
        super.init()
        self.name = "Contrast"
    }
    override func applyFilter() {
        addCommandWithOneFactor(contrast)
    }
}
