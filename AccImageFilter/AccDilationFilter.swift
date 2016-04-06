//
//  AccDilationFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/6.
//  Copyright © 2016年 JW. All rights reserved.
//

public class AccDilationFilter: AccImageFilter {
    public enum Radius:Int{
        case One = 1
        case Two = 2
        case Three = 3
        case Four = 4
    }
    public var dilationRadius:Radius?
    override init(){
        super.init()
        self.dilationRadius = Radius.One
        self.name = "Dilation"
    }
    override public func applyFilter() {
        addCommandWithFactor([dilationRadius!.rawValue])
    }
}