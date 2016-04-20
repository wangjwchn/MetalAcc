//
//  AccImageFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/3/30.
//  Copyright © 2016年 JW. All rights reserved.
//

import MetalKit
public class AccImageFilter{
    public var pipelineState:MTLComputePipelineState?
    public var name:String?
    
    public init(name:String){
        self.name = name
        self.pipelineState = MTLCreateSystemDefaultDevice()!.newComputePipelineStateWithName(self.name!)
    }
    
    public func updatePipeline(){
        self.pipelineState = MTLCreateSystemDefaultDevice()!.newComputePipelineStateWithName(self.name!)
    }
    public func getFactors()->[Float]{return []}
}
