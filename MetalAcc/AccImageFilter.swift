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
        addCommandWithFactor([pixelSize])
    }
}

/*
 AccGaussianBlurFilter:Gaussian blur
 - sigma:The standard deviation of gaussian blur filter(0.0 ~ 10.0, with 0.0 as the default)
*/
 
class AccGaussianBlurFilter:AccImageFilter{
    var sigma:Float?
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
        addCommandWithFactor([grayscale])
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
        addCommandWithoutFactor()
    }
}

/*
 AccLuminanceThresholdFilter: Pixels with a luminance above the threshold will appear white, and those below will be black
 - threshold: The luminance threshold, from 0.0 to 1.0, with a default of 0.5
*/
class AccLuminanceThresholdFilter: AccImageFilter {
    var threshold:Float?
    override init(){
        super.init()
        self.name = "LuminanceThreshold"
    }
    override func applyFilter() {
        addCommandWithFactor([threshold])
    }
}
//-----
class AccLuminanceRangeFilter: AccImageFilter {
    var rangeReduction:Float?
    override init(){
        super.init()
        self.name = "LuminanceRange"
    }
    override func applyFilter() {
        addCommandWithFactor([rangeReduction])
    }
}


class AccWhiteBalanceFilter: AccImageFilter {
    var temperature:Float?
    var tint:Float?
    override init(){
        super.init()
        self.name = "WhiteBalance"
    }
    override func applyFilter() {
        addCommandWithFactor([temperature,tint])
    }
}

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

class AccSolidColorGenerator: AccImageFilter {
    var color:(R:Float,G:Float,B:Float,A:Float)?
    override init(){
        super.init()
        self.name = "SolidColor"
    }
    override func applyFilter() {
        addCommandWithFactor([color!.R,color!.G,color!.B,color!.A])
    }
}

class AccOpacityFilter: AccImageFilter {
    var opacity:Float?
    override init(){
        super.init()
        self.name = "Opacity"
    }
    override func applyFilter() {
        addCommandWithFactor([opacity])
    }
}

class AccHighlightShadowFilter: AccImageFilter {
    var shadows:Float?
    var highlights:Float?
    override init(){
        super.init()
        self.name = "HighlightShadow"
    }
    override func applyFilter() {
        addCommandWithFactor([shadows,highlights])
    }
}

class AccHistogramGenerator: AccImageFilter {
    var height:Float?
    var backgroundColor:(R:Float,G:Float,B:Float,A:Float)?
    override init(){
        super.init()
        self.name = "HistogramGenerator"
    }
    override func applyFilter() {
    addCommandWithFactor([height,backgroundColor!.R,backgroundColor!.G,backgroundColor!.B,backgroundColor!.A])
    }
}

