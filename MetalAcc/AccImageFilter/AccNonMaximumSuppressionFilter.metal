//
//  AccNonMaximumSuppressionFilter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/5.
//  Copyright © 2016年 JW. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
kernel void NonMaximumSuppression(texture2d<float, access::read> inTexture [[texture(0)]],
                                texture2d<float, access::write> outTexture [[texture(1)]],
                                uint2 gid [[thread_position_in_grid]])
{
    const float bottomIntensity = inTexture.read(uint2(gid.x,gid.y-1)).r;
    const float bottomLeftIntensity = inTexture.read(uint2(gid.x-1,gid.y-1)).r;
    const float bottomRightIntensity = inTexture.read(uint2(gid.x,gid.y+1)).r;
    const float leftIntensity = inTexture.read(uint2(gid.x-1,gid.y)).r;
    const float rightIntensity = inTexture.read(uint2(gid.x+1,gid.y)).r;
    const float topIntensity = inTexture.read(uint2(gid.x,gid.y+1)).r;
    const float topRightIntensity = inTexture.read(uint2(gid.x+1,gid.y+1)).r;
    const float topLeftIntensity = inTexture.read(uint2(gid.x-1,gid.y+1)).r;
    const float4 centerIntensity = inTexture.read(gid);
    
    // Use a tiebreaker for pixels to the left and immediately above this one
    float multiplier = 1.0 - step(centerIntensity.r, topIntensity);
    multiplier = multiplier * (1.0 - step(centerIntensity.r, topLeftIntensity));
    multiplier = multiplier * (1.0 - step(centerIntensity.r, leftIntensity));
    multiplier = multiplier * (1.0 - step(centerIntensity.r, bottomLeftIntensity));
    
    float maxValue = max(centerIntensity.r, bottomIntensity);
    maxValue = max(maxValue, bottomRightIntensity);
    maxValue = max(maxValue, rightIntensity);
    maxValue = max(maxValue, topRightIntensity);
    
    float4 outColor = float4((centerIntensity.rgb * step(maxValue, centerIntensity.r) * multiplier), 1.0);
    outTexture.write(outColor,gid);
}

