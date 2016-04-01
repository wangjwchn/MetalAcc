//
//  AccSepiaFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

class AccSepiaFilter: AccColorMatrixFilter {
    override init(){
        super.init()
        self.name = "ColorMatrix"
        self.intensity = 1.0
        self.colorMatrix = (0.3588, 0.7044, 0.1368, 0.0,
                           0.2990, 0.5870, 0.1140, 0.0,
                           0.2392, 0.4696, 0.0912 ,0.0,
                           0,0,0,1.0)
    }
}