//
//  AccOpacityFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

import Foundation
class AccOpacityFilter: AccImageFilter {
    var opacity:Float?
    override init(){
        super.init()
        self.name = "Opacity"
    }
    override func applyFilter() {
        addCommandWithFactor([opacity])
    }
}