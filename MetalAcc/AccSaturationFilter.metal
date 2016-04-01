//
//  AccSaturationFilter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
kernel void Saturation(texture2d<float, access::read> inTexture [[texture(0)]],
                       texture2d<float, access::write> outTexture [[texture(1)]],
                       device float *saturation [[buffer(0)]],
                       uint2 gid [[thread_position_in_grid]])
{
    float4 inColor = inTexture.read(gid);
    float value = dot(inColor.rgb, float3(0.2125, 0.7154, 0.0721));
    float4 grayColor(value, value, value, 1.0);
    float4 outColor = mix(grayColor, inColor, *saturation);
    outTexture.write(outColor, gid);
}
