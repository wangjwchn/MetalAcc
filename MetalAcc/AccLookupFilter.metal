//
//  AccLookupFilter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/20.
//  Copyright © 2016年 wangjwchn. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
kernel void Lookup(
    texture2d<float, access::write> outTexture [[texture(0)]],
    texture2d<float, access::read> inTexture [[texture(1)]],
    texture2d<float, access::read> lookupTexture [[texture(2)]],
    device float *intensity [[buffer(0)]],
    uint2 gid [[thread_position_in_grid]])
{
    
    const float4 textureColor = inTexture.read(gid);
    const float blueColor = textureColor.b * 63.0;
    
    float2 quad1;
    quad1.y = floor(floor(blueColor) / 8.0);
    quad1.x = floor(blueColor) - (quad1.y * 8.0);
    
    float2 quad2;
    quad2.y = floor(ceil(blueColor) / 8.0);
    quad2.x = ceil(blueColor) - (quad2.y * 8.0);
    
    float2 texPos1;
    texPos1.x = (quad1.x * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.r);
    texPos1.y = (quad1.y * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.g);
    
    float2 texPos2;
    texPos2.x = (quad2.x * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.r);
    texPos2.y = (quad2.y * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.g);
    
    const float4  newColor1 = lookupTexture.read(uint2(texPos1));
    const float4  newColor2 = lookupTexture.read(uint2(texPos2));
    const float4  outColor = mix(newColor1, newColor2, fract(blueColor));

    outTexture.write(outColor, gid);
}