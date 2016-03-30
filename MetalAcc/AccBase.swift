//
//  AccBase.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/3/30.
//  Copyright © 2016年 JW. All rights reserved.
//

import MetalKit
class AccBase{
    var device:MTLDevice? = nil
    var library:MTLLibrary? = nil
    var commandQueue:MTLCommandQueue? = nil
    init(){
        device = MTLCreateSystemDefaultDevice()
        library = self.device!.newDefaultLibrary()
        commandQueue = self.device!.newCommandQueue()
    }
}