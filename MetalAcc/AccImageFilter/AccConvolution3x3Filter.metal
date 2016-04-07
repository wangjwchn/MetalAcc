//
//  AccConvolution3x3Filter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/5.
//  Copyright © 2016年 JW. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
kernel void Convolution3x3(texture2d<float, access::read> inTexture [[texture(0)]],
                        texture2d<float, access::write> outTexture [[texture(1)]],
                        device float *x11 [[buffer(0)]],
                        device float *x12 [[buffer(1)]],
                        device float *x13 [[buffer(2)]],
                        device float *x21 [[buffer(3)]],
                        device float *x22 [[buffer(4)]],
                        device float *x23 [[buffer(5)]],
                        device float *x31 [[buffer(6)]],
                        device float *x32 [[buffer(7)]],
                        device float *x33 [[buffer(8)]],
                        uint2 gid [[thread_position_in_grid]])
{
    const float3x3 convolutionMatrix = float3x3(float3(*x11,*x12,*x13),float3(*x21,*x22,*x23),float3(*x31,*x32,*x33));
    
    const float3 bottomColor = inTexture.read(uint2(gid.x,gid.y-1)).rgb;
    const float3 bottomLeftColor = inTexture.read(uint2(gid.x-1,gid.y-1)).rgb;
    const float3 bottomRightColor = inTexture.read(uint2(gid.x,gid.y+1)).rgb;
    const float4 centerColor = inTexture.read(gid);
    const float3 leftColor = inTexture.read(uint2(gid.x-1,gid.y)).rgb;
    const float3 rightColor = inTexture.read(uint2(gid.x+1,gid.y)).rgb;
    const float3 topColor = inTexture.read(uint2(gid.x,gid.y+1)).rgb;
    const float3 topRightColor = inTexture.read(uint2(gid.x+1,gid.y+1)).rgb;
    const float3 topLeftColor = inTexture.read(uint2(gid.x-1,gid.y+1)).rgb;
    
    float3 resultColor = topLeftColor * convolutionMatrix[0][0] + topColor * convolutionMatrix[0][1] + topRightColor * convolutionMatrix[0][2];
    resultColor += leftColor * convolutionMatrix[1][0] + centerColor.rgb * convolutionMatrix[1][1] + rightColor * convolutionMatrix[1][2];
    resultColor += bottomLeftColor * convolutionMatrix[2][0] + bottomColor * convolutionMatrix[2][1] + bottomRightColor * convolutionMatrix[2][2];
    const float4 outColor = float4(resultColor,centerColor.a);
    outTexture.write(outColor,gid);
}

