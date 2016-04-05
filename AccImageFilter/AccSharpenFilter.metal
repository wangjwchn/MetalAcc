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
                    device float *texelWidth [[buffer(1)]],
                    device float *texelHeight [[buffer(2)]],
                     uint2 gid [[thread_position_in_grid]])
{
    float2 widthStep = float2(*texelWidth, 0.0);
    float2 heightStep = float2(0.0, *texelHeight);
    
    uint2 textureCoordinate = gid.xy;
    uint2 leftTextureCoordinate = uint2((float2)gid.xy - widthStep);
    uint2 rightTextureCoordinate = uint2((float2)gid.xy + widthStep);
    uint2 topTextureCoordinate = uint2((float2)gid.xy + heightStep);
    uint2 bottomTextureCoordinate = uint2((float2)gid.xy - heightStep);
    
    float centerMultiplier = 1.0 + 4.0 * *sharpness;
    float edgeMultiplier = *sharpness;
    
    float3 textureColor = inTexture.read(textureCoordinate).rgb;
    float3 leftTextureColor = inTexture.read(leftTextureCoordinate).rgb;
    float3 rightTextureColor = inTexture.read(rightTextureCoordinate).rgb;
    float3 topTextureColor = inTexture.read(topTextureCoordinate).rgb;
    float3 bottomTextureColor = inTexture.read(bottomTextureCoordinate).rgb;
    float4 outColor = float4((textureColor * centerMultiplier - (leftTextureColor * edgeMultiplier + rightTextureColor * edgeMultiplier + topTextureColor * edgeMultiplier + bottomTextureColor * edgeMultiplier)), inTexture.read(bottomTextureCoordinate).w);
    outTexture.write(outColor,gid);
}



