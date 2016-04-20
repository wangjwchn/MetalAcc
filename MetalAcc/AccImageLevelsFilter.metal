//
//  AccImageLevelsFilter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//
/*
 ** Levels control (input (+gamma), output)
 ** Details: http://blog.mouaif.org/2009/01/28/levels-control-shader/
 */
#define LevelsControlInputRange(color, minInput, maxInput)				min(max(color - minInput, float3(0.0)) / (maxInput - minInput), float3(1.0))
#define LevelsControlInput(color, minInput, gamma, maxInput)				GammaCorrection(LevelsControlInputRange(color, minInput, maxInput), gamma)
#define LevelsControlOutputRange(color, minOutput, maxOutput) 			mix(minOutput, maxOutput, color)
#define LevelsControl(color, minInput, gamma, maxInput, minOutput, maxOutput) 	LevelsControlOutputRange(LevelsControlInput(color, minInput, gamma, maxInput), minOutput, maxOutput)
#define GammaCorrection(color, gamma)   pow(color, 1.0 / gamma)
#include <metal_stdlib>
using namespace metal;
kernel void ImageLevels(
    texture2d<float, access::write> outTexture [[texture(0)]],
    texture2d<float, access::read> inTexture [[texture(1)]],
    device float *minR [[buffer(0)]],device float *minG [[buffer(1)]],
    device float *minB [[buffer(2)]],device float *midR [[buffer(3)]],
    device float *midG [[buffer(4)]],device float *midB [[buffer(5)]],
    device float *maxR [[buffer(6)]],device float *maxG [[buffer(7)]],
    device float *maxB [[buffer(8)]],device float *minOutR [[buffer(9)]],
    device float *minOutG [[buffer(10)]],
    device float *minOutB [[buffer(11)]],
    device float *maxOutR [[buffer(12)]],
    device float *maxOutG [[buffer(13)]],
    device float *maxOutB [[buffer(14)]],
    uint2 gid [[thread_position_in_grid]])
{
    const float3 levelMinimum = float3(*minR,*minG,*minB);
    const float3 levelMiddle = float3(*midR,*midG,*midB);
    const float3 levelMaximum = float3(*maxR,*maxG,*maxB);
    const float3 minOutput = float3(*minOutR,*minOutG,*minOutB);
    const float3 maxOutput = float3(*maxOutR,*maxOutG,*maxOutB);
    const float4 inColor = inTexture.read(gid);
    const float4 outColor = float4(LevelsControl(inColor.rgb, levelMinimum, levelMiddle, levelMaximum, minOutput, maxOutput), inColor.a);
    outTexture.write(outColor, gid);
}

