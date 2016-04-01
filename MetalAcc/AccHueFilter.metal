//
//  AccHueFilter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//
// Adapted from http://stackoverflow.com/questions/9234724/how-to-change-hue-of-a-texture-with-glsl - see for code and discussion
#include <metal_stdlib>
using namespace metal;
kernel void Hue(texture2d<float, access::read> inTexture [[texture(0)]],
                     texture2d<float, access::write> outTexture [[texture(1)]],
                     device float *hueAdjust [[buffer(0)]],
                     uint2 gid [[thread_position_in_grid]])
{
    const float4 kRGBToYPrime = float4(0.299, 0.587, 0.114, 0.0);
    const float4 kRGBToI = float4(0.595716, -0.274453, -0.321263, 0.0);
    const float4 kRGBToQ = float4(0.211456, -0.522591, 0.31135, 0.0);
    
    const float4 kYIQToR = float4(1.0, 0.9563, 0.6210, 0.0);
    const float4 kYIQToG = float4(1.0, -0.2721, -0.6474, 0.0);
    const float4 kYIQToB = float4(1.0, -1.1070, 1.7046, 0.0);

    float4 inColor = inTexture.read(gid);
    
    // Convert to YIQ
    float   YPrime  = dot (inColor, kRGBToYPrime);
    float   I      = dot (inColor, kRGBToI);
    float   Q      = dot (inColor, kRGBToQ);
    
    
    // Calculate the hue and chroma
    float   hue     = atan2(Q, I);
    float   chroma  = sqrt (I * I + Q * Q);

    // Make the user's adjustments
    hue += (- *hueAdjust);
    
    // Convert back to YIQ
    Q = chroma * sin (hue);
    I = chroma * cos (hue);
    
    // Convert back to RGB
    float4  yIQ = float4 (YPrime, I, Q, 0.0);
    float4 outColor = float4(dot(yIQ, kYIQToR),dot (yIQ, kYIQToG),dot (yIQ, kYIQToB),inColor.a);
    
    outTexture.write(outColor, gid);
}

