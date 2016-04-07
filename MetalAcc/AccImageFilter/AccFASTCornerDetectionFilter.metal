//
//  AccFASTCornerDetectionFilter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/5.
//  Copyright © 2016年 JW. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
kernel void FASTCornerDetection(texture2d<float, access::read> inTexture [[texture(0)]],
                         texture2d<float, access::write> outTexture [[texture(1)]],
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
    const float centerIntensity = inTexture.read(gid).r;
    
    float byteTally = 1.0 / 255.0 * step(centerIntensity, topRightIntensity);
    byteTally += 2.0 / 255.0 * step(centerIntensity, topIntensity);
    byteTally += 4.0 / 255.0 * step(centerIntensity, topLeftIntensity);
    byteTally += 8.0 / 255.0 * step(centerIntensity, leftIntensity);
    byteTally += 16.0 / 255.0 * step(centerIntensity, bottomLeftIntensity);
    byteTally += 32.0 / 255.0 * step(centerIntensity, bottomIntensity);
    byteTally += 64.0 / 255.0 * step(centerIntensity, bottomRightIntensity);
    byteTally += 128.0 / 255.0 * step(centerIntensity, rightIntensity);
    
    // TODO: Replace the above with a dot product and two vec4s
    // TODO: Apply step to a matrix, rather than individually
    
    float4 outColor = float4(byteTally, byteTally, byteTally, 1.0);
    outTexture.write(outColor,gid);
}

