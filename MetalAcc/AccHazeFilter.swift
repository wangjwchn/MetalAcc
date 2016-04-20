//
//  AccHazeFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/20.
//  Copyright © 2016年 wangjwchn. All rights reserved.
//

public class AccHazeFilter: AccImageFilter {
    public var distance:Float = 0.2
    public var slope:Float = 0.0
    public init(){
        super.init(name: "Haze")
    }
    override public func getFactors()->[Float]{
        return [distance,slope]
    }
}