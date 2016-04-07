//
//  AccMedian5x5Filter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/5.
//  Copyright © 2016年 JW. All rights reserved.
//

public class AccMedian5x5Filter: AccImageFilter {
    override init(){
        super.init()
        self.name = "Median5x5"
    }
    override public func applyFilter(){
        addCommandWithoutFactor()
    }
}
