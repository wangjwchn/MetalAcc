//
//  AccLuminanceRangeFilter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

kernel void LuminanceRange(texture2d<float, access::read> inTexture [[texture(0)]],
                           texture2d<float, access::write> outTexture [[texture(1)]],
                           device float *rangeReduction [[buffer(0)]],
                           uint2 gid [[thread_position_in_grid]])
{
    float4 inColor = inTexture.read(gid);
    float luminance = dot(inColor.rgb, float3(0.2125, 0.7154, 0.0721));
    float luminanceRatio = ((0.5 - luminance) * *rangeReduction);
    float4 outColor = float4(float3(inColor.rgb+luminanceRatio),inColor.w);
    outTexture.write(outColor, gid);
}


