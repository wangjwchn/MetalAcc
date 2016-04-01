//
//  AccContrastFilter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
kernel void Contrast(texture2d<float, access::read> inTexture [[texture(0)]],
                     texture2d<float, access::write> outTexture [[texture(1)]],
                     device float *contrast [[buffer(0)]],
                     uint2 gid [[thread_position_in_grid]])
{
    float4 inColor = inTexture.read(gid);
    float4 outColor((inColor.r - 0.5) * (*contrast + 0.5),
                    (inColor.g - 0.5) * (*contrast + 0.5),
                    (inColor.b - 0.5) * (*contrast + 0.5),
                    inColor.a);
    
    outTexture.write(outColor, gid);
}

