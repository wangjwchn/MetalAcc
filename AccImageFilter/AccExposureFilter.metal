//
//  AccExposureFilter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
kernel void Exposure(texture2d<float, access::read> inTexture [[texture(0)]],
                     texture2d<float, access::write> outTexture [[texture(1)]],
                     device float *exposure [[buffer(0)]],
                     uint2 gid [[thread_position_in_grid]])
{
    float4 inColor = inTexture.read(gid);
    float4 outColor(inColor.r * pow(2.0, *exposure),
                    inColor.g * pow(2.0, *exposure),
                    inColor.b * pow(2.0, *exposure),
                    inColor.a);
    outTexture.write(outColor, gid);
}



