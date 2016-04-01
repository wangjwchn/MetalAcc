//
//  AccFalseColorFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

class AccFalseColorFilter: AccImageFilter {
    var firstColor:(R:Float,G:Float,B:Float)?
    var secondColor:(R:Float,G:Float,B:Float)?
    override init(){
        super.init()
        self.name = "FalseColor"
    }
    override func applyFilter() {
        addCommandWithFactor([firstColor!.R,firstColor!.G,firstColor!.B,secondColor!.R,secondColor!.G,secondColor!.B])
    }
}