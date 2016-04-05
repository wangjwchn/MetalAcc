//
//  AccTransformFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/2.
//  Copyright © 2016年 JW. All rights reserved.
//
import CoreGraphics
public class AccTransformFilter:AccImageFilter{
    public var affineTransform:CGAffineTransform?
    //var transform3D:CATransform3D?
    override public init(){
        super.init()
        self.name = "Transform"
        self.affineTransform = CGAffineTransform(a: 1.0, b: 0.0, c: 0.0, d: 1.0, tx: 0.0, ty: 0.0)
    }
    override public func applyFilter() {
        addCommandWithFactor([Float(affineTransform!.a),Float(affineTransform!.b),Float(affineTransform!.c),Float(affineTransform!.d),Float(affineTransform!.tx),Float(affineTransform!.ty)])
    }
}