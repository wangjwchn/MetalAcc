//
//  AccRGBFilter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

kernel void RGB(
    texture2d<float, access::write> outTexture [[texture(0)]],
    texture2d<float, access::read> inTexture [[texture(1)]],
    device float *redAdjustment [[buffer(0)]],
    device float *greenAdjustment [[buffer(1)]],
    device float *blueAdjustment [[buffer(2)]],
    uint2 gid [[thread_position_in_grid]])
{
    const float4 inColor = inTexture.read(gid);
    const float4 outColor = float4(inColor.r * *redAdjustment, inColor.g * *greenAdjustment, inColor.b * *blueAdjustment, inColor.a);
    outTexture.write(outColor, gid);
}

