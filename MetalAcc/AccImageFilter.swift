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

/*
 AccPixelateFilter:Pixelate an image
 - pixelSize:The degree of pixelating (>0)
*/
class AccPixelateFilter:AccImageFilter{
    var pixelSize:UInt?//0~?
    override init(){
        super.init()
        self.name = "Pixelate"
    }
    override func applyFilter() {
        addCommandWithOneFactor(pixelSize)
    }
}

/*
 AccGaussianBlurFilter:Gaussian blur
 - sigma:The standard deviation of gaussian blur filter
*/
 
class AccGaussianBlurFilter:AccImageFilter{
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
        addCommandWithOneFactor(grayscale)
    }

}

/*
 AccBrightnessFilter: Adjusts the brightness of the image
 - brightness: The adjusted brightness (-1.0 ~ 1.0, with 0.0 as the default)
*/
class AccBrightnessFilter: AccImageFilter {
    var brightness:Float?//0.0~1.0
    override init(){
        super.init()
        self.name = "Brightness"
    }
    override func applyFilter() {
        addCommandWithOneFactor(brightness)
    }
    
}

/*
 AccSaturationFilter: Adjusts the saturation of an image
 - saturation: The degree of saturation or desaturation to apply to the image (0.0 ~ 2.0, with 1.0 as the default)
*/
class AccSaturationFilter: AccImageFilter {
    var saturation:Float?//0.0~1.0
    override init(){
        super.init()
        self.name = "Saturation"
    }
    override func applyFilter() {
        addCommandWithOneFactor(saturation)
    }
    
}

/*
 AccImageGammaFilter: Adjusts the gamma of an image
 - gamma: The gamma adjustment to apply (0.0 ~ 3.0, with 1.0 as the default)
*/
class AccGammaFilter: AccImageFilter {
    var gamma:Float?//0.0~3.0
    override init(){
        super.init()
        self.name = "Gamma"
    }
    override func applyFilter() {
        addCommandWithOneFactor(gamma)
    }
    
}

/*
 AccColorInvertFilter: Inverts the colors of an image
*/
class AccColorInvertFilter: AccImageFilter {
    override init(){
        super.init()
        self.name = "ColorInvert"
    }
    override func applyFilter() {
        addCommandWithZeroFactor()
    }
}

/*
 AccContrastFilter: Adjusts the contrast of the image
 - contrast: The adjusted contrast (0.0 ~ 4.0, with 1.0 as the default)
*/
class AccContrastFilter: AccImageFilter {
    var contrast:Float?//0.0~3.0
    override init(){
        super.init()
        self.name = "Contrast"
    }
    override func applyFilter() {
        addCommandWithOneFactor(contrast)
    }
}

class AccExposureFilter: AccImageFilter {
    var exposure:Float?
    override init(){
        super.init()
        self.name = "Exposure"
    }
    override func applyFilter() {
        addCommandWithOneFactor(exposure)
    }
}

class AccLuminanceThresholdFilter: AccImageFilter {
    var threshold:Float?
    override init(){
        super.init()
        self.name = "LuminanceThreshold"
    }
    override func applyFilter() {
        addCommandWithOneFactor(threshold)
    }
}

class AccLuminanceRangeFilter: AccImageFilter {
    var rangeReduction:Float?
    override init(){
        super.init()
        self.name = "LuminanceRange"
    }
    override func applyFilter() {
        addCommandWithOneFactor(rangeReduction)
    }
}