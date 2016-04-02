//
//  AccTransformFilter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/2.
//  Copyright © 2016年 JW. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
kernel void Transform(texture2d<float, access::read> inTexture [[texture(0)]],
                     texture2d<float, access::write> outTexture [[texture(1)]],
                     device unsigned int *a [[buffer(0)]],
                      device unsigned int *b [[buffer(1)]],
                      device unsigned int *c [[buffer(2)]],
                      device unsigned int *d [[buffer(3)]],
                      device unsigned int *tx [[buffer(4)]],
                      device unsigned int *ty [[buffer(5)]],
                      uint2 gid [[thread_position_in_grid]])
{

    float a1 = *a;
    float a2 = *c;
    float a3 = *tx;
    float b1 = *b;
    float b2 = *d;
    float b3 = *ty;
    float c1 = 0;
    float c2 = 0;
    float c3 = 1;
    
    
    const float3x3 inverse = float3x3(float3(b2*c3-c2*b3,c1*b3-b1*c3,b1*c2-c1*b2),
                                      float3(c2*a3-a2*c3,a1*c3-c1*a3,a2*c1-a1*c2),
                                      float3(a2*b3-b2*a3,b1*a3-a1*b3,a1*b2-a2*b1));
    float3 position = float3(gid.x,gid.y,1)*inverse;
    float4 outcolor = inTexture.read(position.x,position.y);
    outTexture.write(outcolor, gid);
}



