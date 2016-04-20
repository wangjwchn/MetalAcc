//
//  AccImage.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/19.
//  Copyright © 2016年 wangjwchn. All rights reserved.
//

import MetalKit
import ImageIO
public class AccImage{

    private var commandQueue:MTLCommandQueue
    private var textures = [MTLTexture]()
    public var filter:AccImageFilter?
    
    init(){
        self.commandQueue = MTLCreateSystemDefaultDevice()!.newCommandQueue()
    }
    
    public func Input(image:UIImage){
        let texture = image.toMTLTexture()
        if(textures.isEmpty==true){
            textures.append(texture.sameSizeEmptyTexture())//outTexture
        }
        textures.append(texture)
    }
    
    public func AddProcessor(filter:AccImageFilter){
        self.filter = filter
    }
    
    public func Processing(){
        self.commandQueue.addAccCommand((self.filter!.pipelineState!), textures: textures, factors: self.filter!.getFactors())
    }
    public func Output()->UIImage{
        let image = textures[0].toImage()
        return image
    }
}
