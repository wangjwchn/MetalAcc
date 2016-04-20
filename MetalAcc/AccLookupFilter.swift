//
//  AccLookupFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/20.
//  Copyright © 2016年 wangjwchn. All rights reserved.
//

public class AccLookupFilter: AccImageFilter {
    public var intensity:Float = 1.0
    public init(){
        super.init(name: "Lookup")
    }
    override public func getFactors()->[Float]{
        return [intensity]
    }
}