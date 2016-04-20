//
//  AccCmdQueue.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/19.
//  Copyright © 2016年 wangjwchn. All rights reserved.
//

import MetalKit
public extension MTLCommandQueue{
    public func addAccCommand<T>(pipelineState:MTLComputePipelineState,textures:[MTLTexture],factors:[T]){
        
        let commandBuffer = self.commandBuffer()
        let commandEncoder = commandBuffer.computeCommandEncoder()
        commandEncoder.setComputePipelineState(pipelineState)
        
        for i in 0..<textures.count{
            commandEncoder.setTexture(textures[i], atIndex: i)
        }
        
        for i in 0..<factors.count{
            var factor = factors[i]
            let size = max(sizeof(T),16)
            let buffer = MTLCreateSystemDefaultDevice()!.newBufferWithBytes(&factor, length: size, options: [MTLResourceOptions.StorageModeShared])
            commandEncoder.setBuffer(buffer, offset: 0, atIndex: i)
        }
        commandEncoder.dispatchThreadgroups(textures[0].threadGroups(), threadsPerThreadgroup: textures[0].threadGroupCount())
        commandEncoder.endEncoding()
        commandBuffer.commit()
        commandBuffer.waitUntilCompleted()
    }
}