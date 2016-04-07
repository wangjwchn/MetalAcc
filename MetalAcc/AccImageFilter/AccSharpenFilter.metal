//
//  AccSharpenFilter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/5.
//  Copyright © 2016年 JW. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
kernel void Sharpen(texture2d<float, access::read> inTexture [[texture(0)]],
                     texture2d<float, access::write> outTexture [[texture(1)]],
                     device float *sharpness [[buffer(0)]],
                     uint2 gid [[thread_position_in_grid]])
{
    float centerMultiplier = 1.0 + 4.0 * *sharpness;
    float edgeMultiplier = *sharpness;
    
    float4 textureColor = inTexture.read(gid);
    float3 leftTextureColor = inTexture.read(uint2(gid.x-1,gid.y)).rgb;
    float3 rightTextureColor = inTexture.read(uint2(gid.x+1,gid.y)).rgb;
    float3 topTextureColor = inTexture.read(uint2(gid.x,gid.y+1)).rgb;
    float3 bottomTextureColor = inTexture.read(uint2(gid.x,gid.y-1)).rgb;
    float4 outColor = float4((textureColor.rgb * centerMultiplier - (leftTextureColor * edgeMultiplier + rightTextureColor * edgeMultiplier + topTextureColor * edgeMultiplier + bottomTextureColor * edgeMultiplier)), textureColor.w);
    outTexture.write(outColor,gid);
}



