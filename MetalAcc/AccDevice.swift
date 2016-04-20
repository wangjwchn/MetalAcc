//
//  AccDevice.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/19.
//  Copyright © 2016年 wangjwchn. All rights reserved.
//

import MetalKit
public extension MTLDevice{
    public func newComputePipelineStateWithName(functionName:String) -> MTLComputePipelineState{
        let library = self.newDefaultLibrary()!
        let function = library.newFunctionWithName(functionName)!
        do {
            let pipelineState = try self.newComputePipelineStateWithFunction(function)
            return pipelineState
        }
        catch {
            fatalError("Unable to setup Metal")
        }
    }
}