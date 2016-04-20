//
//  AccHighlightShadowFilter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
kernel void HighlightShadow(
    texture2d<float, access::write> outTexture [[texture(0)]],
    texture2d<float, access::read> inTexture [[texture(1)]],
    device float *shadows [[buffer(0)]],
    device float *highlights [[buffer(1)]],
    uint2 gid [[thread_position_in_grid]])
{
    const float3 luminanceWeighting = float3(0.3, 0.3, 0.3);
    const float4 inColor = inTexture.read(gid);
    const float luminance = dot(inColor.rgb, luminanceWeighting);
    const float shadow = clamp((pow(luminance, 1.0/(*shadows+1.0)) + (-0.76)*pow(luminance, 2.0/(*shadows+1.0))) - luminance, 0.0, 1.0);
    const float highlight = clamp((1.0 - (pow(1.0-luminance, 1.0/(2.0-*highlights)) + (-0.8)*pow(1.0-luminance, 2.0/(2.0-*highlights)))) - luminance, -1.0, 0.0);
    const float3 result = float3(0.0, 0.0, 0.0) + ((luminance + shadow + highlight) - 0.0) * ((inColor.rgb - float3(0.0, 0.0, 0.0))/(luminance - 0.0));
    const float4 outColor  = float4(result.rgb, inColor.a);
    outTexture.write(outColor, gid);
}


