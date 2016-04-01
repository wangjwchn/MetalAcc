//
//  AccColorInvert.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//
/*
 AccColorInvertFilter: Inverts the colors of an image
 */
class AccColorInvertFilter: AccImageFilter {
    override init(){
        super.init()
        self.name = "ColorInvert"
    }
    override func applyFilter() {
        addCommandWithoutFactor()
    }
}
