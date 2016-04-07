//
//  AccRGBDilationFilter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/6.
//  Copyright © 2016年 JW. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
kernel void RGBDilation(texture2d<float, access::read> inTexture [[texture(0)]],
                     texture2d<float, access::write> outTexture [[texture(1)]],
                     device int *dilationRadius [[buffer(0)]],
                     uint2 gid [[thread_position_in_grid]])
{
    uint2 centerTextureCoordinate = gid;
    uint2 oneStepNegativeTextureCoordinate = uint2(gid - uint2(1,1));
    uint2 oneStepPositiveTextureCoordinate = uint2(gid + uint2(1,1));
    uint2 twoStepsNegativeTextureCoordinate = uint2(gid - uint2(2,2));
    uint2 twoStepsPositiveTextureCoordinate = uint2(gid + uint2(2,2));
    uint2 threeStepsNegativeTextureCoordinate = uint2(gid - uint2(3,3));
    uint2 threeStepsPositiveTextureCoordinate = uint2(gid + uint2(3,3));
    uint2 fourStepsNegativeTextureCoordinate = uint2(gid - uint2(4,4));
    uint2 fourStepsPositiveTextureCoordinate = uint2(gid + uint2(4,4));
    
    float4 outColor;
    switch (*dilationRadius){
        case 1:
        {
            float centerIntensity = inTexture.read(centerTextureCoordinate).r;
            float oneStepPositiveIntensity = inTexture.read(oneStepPositiveTextureCoordinate).r;
            float oneStepNegativeIntensity = inTexture.read(oneStepNegativeTextureCoordinate).r;
            float maxValue = max(centerIntensity, oneStepPositiveIntensity);
            maxValue = max(maxValue, oneStepNegativeIntensity);
            outColor = float4(float3(maxValue), oneStepNegativeIntensity);
            break;
        }
        case 2:
        {
            float centerIntensity = inTexture.read(centerTextureCoordinate).r;
            float oneStepPositiveIntensity = inTexture.read(oneStepPositiveTextureCoordinate).r;
            float oneStepNegativeIntensity = inTexture.read(oneStepNegativeTextureCoordinate).r;
            float twoStepsPositiveIntensity = inTexture.read(twoStepsPositiveTextureCoordinate).r;
            float twoStepsNegativeIntensity = inTexture.read(twoStepsNegativeTextureCoordinate).r;
            float maxValue = max(centerIntensity, oneStepPositiveIntensity);
            maxValue = max(maxValue, oneStepNegativeIntensity);
            maxValue = max(maxValue, twoStepsPositiveIntensity);
            maxValue = max(maxValue, twoStepsNegativeIntensity);
            outColor = float4(float3(maxValue), twoStepsNegativeIntensity);
        }
        case 3:
        {
            float centerIntensity = inTexture.read(centerTextureCoordinate).r;
            float oneStepPositiveIntensity = inTexture.read(oneStepPositiveTextureCoordinate).r;
            float oneStepNegativeIntensity = inTexture.read(oneStepNegativeTextureCoordinate).r;
            float twoStepsPositiveIntensity = inTexture.read(twoStepsPositiveTextureCoordinate).r;
            float twoStepsNegativeIntensity = inTexture.read(twoStepsNegativeTextureCoordinate).r;
            float threeStepsPositiveIntensity = inTexture.read(threeStepsPositiveTextureCoordinate).r;
            float threeStepsNegativeIntensity = inTexture.read(threeStepsNegativeTextureCoordinate).r;
            float maxValue = max(centerIntensity, oneStepPositiveIntensity);
            maxValue = max(maxValue, oneStepNegativeIntensity);
            maxValue = max(maxValue, twoStepsPositiveIntensity);
            maxValue = max(maxValue, twoStepsNegativeIntensity);
            maxValue = max(maxValue, threeStepsPositiveIntensity);
            maxValue = max(maxValue, threeStepsNegativeIntensity);
            outColor = float4(float3(maxValue), threeStepsNegativeIntensity);
        }
        case 4:
        {
            float centerIntensity = inTexture.read(centerTextureCoordinate).r;
            float oneStepPositiveIntensity = inTexture.read(oneStepPositiveTextureCoordinate).r;
            float oneStepNegativeIntensity = inTexture.read(oneStepNegativeTextureCoordinate).r;
            float twoStepsPositiveIntensity = inTexture.read(twoStepsPositiveTextureCoordinate).r;
            float twoStepsNegativeIntensity = inTexture.read(twoStepsNegativeTextureCoordinate).r;
            float threeStepsPositiveIntensity = inTexture.read(threeStepsPositiveTextureCoordinate).r;
            float threeStepsNegativeIntensity = inTexture.read(threeStepsNegativeTextureCoordinate).r;
            float fourStepsPositiveIntensity = inTexture.read(fourStepsPositiveTextureCoordinate).r;
            float fourStepsNegativeIntensity = inTexture.read(fourStepsNegativeTextureCoordinate).r;
            float maxValue = max(centerIntensity, oneStepPositiveIntensity);
            maxValue = max(maxValue, oneStepNegativeIntensity);
            maxValue = max(maxValue, twoStepsPositiveIntensity);
            maxValue = max(maxValue, twoStepsNegativeIntensity);
            maxValue = max(maxValue, threeStepsPositiveIntensity);
            maxValue = max(maxValue, threeStepsNegativeIntensity);
            maxValue = max(maxValue, fourStepsPositiveIntensity);
            maxValue = max(maxValue, fourStepsNegativeIntensity);
            outColor = float4(float3(maxValue), fourStepsNegativeIntensity);
        }
        default: break;
    }
    outTexture.write(outColor,gid);
}