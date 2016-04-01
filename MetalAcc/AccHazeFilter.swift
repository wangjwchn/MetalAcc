//
//  AccHazeFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//
class AccHazeFilter: AccImageFilter {
    var hazeDistance:Float?
    var slope:Float?
    override init(){
        super.init()
        self.name = "FalseColor"
    }
    override func applyFilter() {
        addCommandWithFactor([hazeDistance,slope])
    }
}
