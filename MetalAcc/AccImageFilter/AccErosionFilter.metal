//
//  AccErosionFilter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/6.
//  Copyright © 2016年 JW. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
kernel void Erosion(texture2d<float, access::read> inTexture [[texture(0)]],
                     texture2d<float, access::write> outTexture [[texture(1)]],
                     device int *erosionRadius [[buffer(0)]],
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
    switch (*erosionRadius){
        case 1:
        {
            float centerIntensity = inTexture.read(centerTextureCoordinate).r;
            float oneStepPositiveIntensity = inTexture.read(oneStepPositiveTextureCoordinate).r;
            float oneStepNegativeIntensity = inTexture.read(oneStepNegativeTextureCoordinate).r;
            float minValue = min(centerIntensity, oneStepPositiveIntensity);
            minValue = min(minValue, oneStepNegativeIntensity);
            outColor = float4(float3(minValue), 1.0);
            break;
        }
        case 2:
        {
            float centerIntensity = inTexture.read(centerTextureCoordinate).r;
            float oneStepPositiveIntensity = inTexture.read(oneStepPositiveTextureCoordinate).r;
            float oneStepNegativeIntensity = inTexture.read(oneStepNegativeTextureCoordinate).r;
            float twoStepsPositiveIntensity = inTexture.read(twoStepsPositiveTextureCoordinate).r;
            float twoStepsNegativeIntensity = inTexture.read(twoStepsNegativeTextureCoordinate).r;
            float minValue = min(centerIntensity, oneStepPositiveIntensity);
            minValue = min(minValue, oneStepNegativeIntensity);
            minValue = min(minValue, twoStepsPositiveIntensity);
            minValue = min(minValue, twoStepsNegativeIntensity);
            outColor = float4(float3(minValue), 1.0);
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
            float minValue = min(centerIntensity, oneStepPositiveIntensity);
            minValue = min(minValue, oneStepNegativeIntensity);
            minValue = min(minValue, twoStepsPositiveIntensity);
            minValue = min(minValue, twoStepsNegativeIntensity);
            minValue = min(minValue, threeStepsPositiveIntensity);
            minValue = min(minValue, threeStepsNegativeIntensity);
            outColor = float4(float3(minValue), 1.0);
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
            float minValue = min(centerIntensity, oneStepPositiveIntensity);
            minValue = min(minValue, oneStepNegativeIntensity);
            minValue = min(minValue, twoStepsPositiveIntensity);
            minValue = min(minValue, twoStepsNegativeIntensity);
            minValue = min(minValue, threeStepsPositiveIntensity);
            minValue = min(minValue, threeStepsNegativeIntensity);
            minValue = min(minValue, fourStepsPositiveIntensity);
            minValue = min(minValue, fourStepsNegativeIntensity);
            outColor = float4(float3(minValue), 1.0);
        }
        default: break;
    }
    outTexture.write(outColor,gid);
}