//
//  AccMonochromeFilter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
kernel void Monochrome(
    texture2d<float, access::write> outTexture [[texture(0)]],
    texture2d<float, access::read> inTexture [[texture(1)]],
    device float *intensity [[buffer(0)]],
    device float *R [[buffer(1)]],
    device float *G [[buffer(2)]],
    device float *B [[buffer(3)]],
    uint2 gid [[thread_position_in_grid]])
{
    const float3 filterColor = float3(*R,*G,*B);
    const float3 luminanceWeighting = float3(0.2125, 0.7154, 0.0721);
    const float4 inColor = inTexture.read(gid);
    const float luminance = dot(inColor.rgb, luminanceWeighting);
    const float4 desat = float4(float3(luminance), 1.0);
    const float4 outColor = float4(
                                 (desat.r < 0.5 ? (2.0 * desat.r * filterColor.r) : (1.0 - 2.0 * (1.0 - desat.r) * (1.0 - filterColor.r))),
                                 (desat.g < 0.5 ? (2.0 * desat.g * filterColor.g) : (1.0 - 2.0 * (1.0 - desat.g) * (1.0 - filterColor.g))),
                                 (desat.b < 0.5 ? (2.0 * desat.b * filterColor.b) : (1.0 - 2.0 * (1.0 - desat.b) * (1.0 - filterColor.b))),
                                 1.0
                                 );
    outTexture.write(outColor, gid);
}


