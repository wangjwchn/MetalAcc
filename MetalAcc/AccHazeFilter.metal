//
//  AccHazeFilter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
kernel void Haze(texture2d<float, access::read> inTexture [[texture(0)]],
                texture2d<float, access::write> outTexture [[texture(1)]],
                device float *hazeDistance [[buffer(0)]],
                device float *slope [[buffer(1)]],
                uint2 gid [[thread_position_in_grid]])
{
    //todo reconsider precision modifiers
    float4 color = float4(1.0);//todo reimplement as a parameter
    float  d = gid.y * *slope + *hazeDistance;
    float4 inColor = inTexture.read(gid); // consider using unpremultiply
    float4 outColor = float4(inColor - d * color) / (1.0 - d);
    outTexture.write(outColor, gid);
}



