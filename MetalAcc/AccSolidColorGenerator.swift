//
//  AccSolidColorGenerator.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

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

