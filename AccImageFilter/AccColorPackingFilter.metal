//
//  AccColorPackingFilter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/6.
//  Copyright © 2016年 JW. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
kernel void ColorPacking(texture2d<float, access::read> inTexture [[texture(0)]],
                                          texture2d<float, access::write> outTexture [[texture(1)]],
                                          uint2 gid [[thread_position_in_grid]])
{
    const float bottomLeftIntensity = inTexture.read(uint2(gid.x-1,gid.y-1)).r;
    const float bottomRightIntensity = inTexture.read(uint2(gid.x,gid.y+1)).r;
    const float topRightIntensity = inTexture.read(uint2(gid.x+1,gid.y+1)).r;
    const float topLeftIntensity = inTexture.read(uint2(gid.x-1,gid.y+1)).r;
    float4 outColor = float4(topLeftIntensity, topRightIntensity, bottomLeftIntensity, bottomRightIntensity);
    outTexture.write(outColor,gid);
}

