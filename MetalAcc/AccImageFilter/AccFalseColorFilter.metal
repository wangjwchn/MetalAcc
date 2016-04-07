//
//  AccFalseColorFilter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
kernel void FalseColor(texture2d<float, access::read> inTexture [[texture(0)]],
                       texture2d<float, access::write> outTexture [[texture(1)]],
                       device float *R1 [[buffer(0)]],
                       device float *G1 [[buffer(1)]],
                       device float *B1 [[buffer(2)]],
                       device float *R2 [[buffer(3)]],
                       device float *G2 [[buffer(4)]],
                       device float *B2 [[buffer(5)]],
                       uint2 gid [[thread_position_in_grid]])
{
    const float3 firstColor = float3(*R1,*G1,*B1);
    const float3 secondColor = float3(*R2,*G2,*B2);
    const float3 luminanceWeighting = float3(0.2125, 0.7154, 0.0721);
    float4 inColor = inTexture.read(gid);
    float luminance = dot(inColor.rgb, luminanceWeighting);
    
    float4 outColor = float4(mix(firstColor.rgb, secondColor.rgb, luminance), inColor.a);
    outTexture.write(outColor, gid);
}




