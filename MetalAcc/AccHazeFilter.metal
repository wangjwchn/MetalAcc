//
//  AccHazeFilter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/20.
//  Copyright © 2016年 wangjwchn. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
kernel void Haze(
    texture2d<float, access::write> outTexture [[texture(0)]],
    texture2d<float, access::read> inTexture [[texture(1)]],
    device float *hazeDistance [[buffer(0)]],
    device float *slope [[buffer(1)]],
    uint2 gid [[thread_position_in_grid]])
{
    const float4 color = float4(1.0);
    const float d = gid.y * *slope  +  *hazeDistance;
    const float4 c = inTexture.read(gid);
    const float4 outColor = (c - d * color) / (1.0 -d);
    outTexture.write(outColor, gid);
}

