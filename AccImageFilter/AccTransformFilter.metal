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
                     device float *a [[buffer(0)]],
                      device float *b [[buffer(1)]],
                      device float *c [[buffer(2)]],
                      device float *d [[buffer(3)]],
                      device float *tx [[buffer(4)]],
                      device float *ty [[buffer(5)]],
                      uint2 gid [[thread_position_in_grid]])
{
    float4 inColor = inTexture.read(gid);
    float3x3 transform= float3x3(float3(*a,*b,0),float3(*c,*d,0),float3(*tx,*ty,1));
    float3 position = float3(gid.x,gid.y,1)*transform;
    uint2 after = uint2(position.x,position.y);
    outTexture.write(inColor,after);
}



