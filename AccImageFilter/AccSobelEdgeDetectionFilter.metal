//
//  AccSobelEdgeDetectionFilter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/5.
//  Copyright © 2016年 JW. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
kernel void SobelEdgeDetection(texture2d<float, access::read> inTexture [[texture(0)]],
                     texture2d<float, access::write> outTexture [[texture(1)]],
                     device unsigned int *edgeStrength [[buffer(0)]],
                     uint2 gid [[thread_position_in_grid]])
{
    const float bottomIntensity = inTexture.read(uint2(gid.x,gid.y-1)).r;
    const float bottomLeftIntensity = inTexture.read(uint2(gid.x-1,gid.y-1)).r;
    const float bottomRightIntensity = inTexture.read(uint2(gid.x,gid.y+1)).r;
    const float leftIntensity = inTexture.read(uint2(gid.x-1,gid.y)).r;
    const float rightIntensity = inTexture.read(uint2(gid.x+1,gid.y)).r;
    const float topIntensity = inTexture.read(uint2(gid.x,gid.y+1)).r;
    const float topRightIntensity = inTexture.read(uint2(gid.x+1,gid.y+1)).r;
    const float topLeftIntensity = inTexture.read(uint2(gid.x-1,gid.y+1)).r;
    float h = -topLeftIntensity - 2.0 * topIntensity - topRightIntensity + bottomLeftIntensity + 2.0 * bottomIntensity + bottomRightIntensity;
    float v = -bottomLeftIntensity - 2.0 * leftIntensity - topLeftIntensity + bottomRightIntensity + 2.0 * rightIntensity + topRightIntensity;
    float mag = length(float2(h, v)) * *edgeStrength;
    
    float4 outColor = float4(float3(mag), 1.0);
    outTexture.write(outColor,gid);
}