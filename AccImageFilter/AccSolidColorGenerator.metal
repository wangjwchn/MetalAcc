//
//  AccSolidColorGenerator.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
kernel void SolidColor(texture2d<float, access::read> inTexture [[texture(0)]],
                       texture2d<float, access::write> outTexture [[texture(1)]],
                       device float *R [[buffer(0)]],
                       device float *G [[buffer(1)]],
                       device float *B [[buffer(2)]],
                       device float *A [[buffer(3)]],
                       uint2 gid [[thread_position_in_grid]])
{
    float4 outColor = float4(*R,*G,*B,*A);
    outTexture.write(outColor, gid);
}

