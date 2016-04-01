//
//  AccColorInvert.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
kernel void ColorInvert(texture2d<float, access::read> inTexture [[texture(0)]],
                        texture2d<float, access::write> outTexture [[texture(1)]],
                        uint2 gid [[thread_position_in_grid]])
{
    float4 inColor = inTexture.read(gid);
    float4 outColor(1.0 - inColor.r,
                    1.0 - inColor.g,
                    1.0 - inColor.b,
                    inColor.a);
    
    outTexture.write(outColor, gid);
}

