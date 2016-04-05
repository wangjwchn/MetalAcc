//
//  AccDirectionalNonMaximumSuppressionFilter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/5.
//  Copyright © 2016年 JW. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
kernel void DirectionalNonMaximumSuppression(texture2d<float, access::read> inTexture [[texture(0)]],
                      texture2d<float, access::write> outTexture [[texture(1)]],
                      device float *lowerThreshold [[buffer(0)]],
                      device float *upperThreshold [[buffer(1)]],
                      uint2 gid [[thread_position_in_grid]])
{
    float3 currentGradientAndDirection = inTexture.read(gid).rgb;
    uint2 gradientDirection = uint2((currentGradientAndDirection.gb * 2.0) - 1.0);
    float firstSampledGradientMagnitude = inTexture.read(gid + gradientDirection).r;
    float secondSampledGradientMagnitude = inTexture.read(gid - gradientDirection).r;
    
    float multiplier = step(firstSampledGradientMagnitude, currentGradientAndDirection.r);
    multiplier = multiplier * step(secondSampledGradientMagnitude, currentGradientAndDirection.r);
    
    float thresholdCompliance = smoothstep(*lowerThreshold, *upperThreshold, currentGradientAndDirection.r);
    multiplier = multiplier * thresholdCompliance;
    
    float4 outColor = float4(multiplier, multiplier, multiplier, 1.0);
    outTexture.write(outColor,gid);

}

