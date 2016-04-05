//
//  AccSharpenFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/5.
//  Copyright © 2016年 JW. All rights reserved.
//

public class AccSharpenFilter: AccImageFilter {
    public var sharpness:Float?
    private var texel:(width:Float,height:Float)?
    override public init(){
        super.init()
        self.sharpness = 0.0
        self.name = "Sharpen"
    }
    override public func applyFilter() {
        self.texel = (1.0/Float(self.base!.inTexture!.width),1.0/Float(self.base!.inTexture!.height))
        addCommandWithFactor([sharpness,texel!.width,texel!.height])
    }
}