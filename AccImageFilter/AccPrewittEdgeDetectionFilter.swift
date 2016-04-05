//
//  AccPrewittEdgeDetectionFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/5.
//  Copyright © 2016年 JW. All rights reserved.
//

public class AccPrewittEdgeDetectionFilter: AccImageFilter {
    override init(){
        super.init()
        self.name = "PrewittEdgeDetection"
    }
    override public func applyFilter() {
        addCommandWithoutFactor()
    }
}