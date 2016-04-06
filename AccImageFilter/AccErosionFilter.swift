//
//  AccErosionFilter.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/6.
//  Copyright © 2016年 JW. All rights reserved.
//

public class AccErosionFilter: AccImageFilter {
    public enum Radius:Int{
        case One = 1
        case Two = 2
        case Three = 3
        case Four = 4
    }
    public var erosionRadius:Radius?
    override init(){
        super.init()
        self.erosionRadius = Radius.One
        self.name = "Erosion"
    }
    override public func applyFilter() {
        addCommandWithFactor([erosionRadius!.rawValue])
    }
}