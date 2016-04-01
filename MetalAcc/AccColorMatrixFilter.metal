//
//  AccColorMatrixFilter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
kernel void ColorMatrix(texture2d<float, access::read> inTexture [[texture(0)]],
                  texture2d<float, access::write> outTexture [[texture(1)]],
                    device float *intensity [[buffer(0)]],
                    device float *x11 [[buffer(1)]],
                    device float *x12 [[buffer(2)]],
                    device float *x13 [[buffer(3)]],
                    device float *x14 [[buffer(4)]],
                    device float *x21 [[buffer(5)]],
                    device float *x22 [[buffer(6)]],
                    device float *x23 [[buffer(7)]],
                    device float *x24 [[buffer(8)]],
                    device float *x31 [[buffer(9)]],
                    device float *x32 [[buffer(10)]],
                    device float *x33 [[buffer(11)]],
                    device float *x34 [[buffer(12)]],
                    device float *x41 [[buffer(13)]],
                    device float *x42 [[buffer(14)]],
                    device float *x43 [[buffer(15)]],
                    device float *x44 [[buffer(16)]],
                    uint2 gid [[thread_position_in_grid]])
{
    float4 inColor = inTexture.read(gid);
    float4x4 colorMatrix = float4x4(float4(*x11,*x12,*x13,*x14),
                                          float4(*x21,*x22,*x23,*x24),
                                          float4(*x31,*x32,*x33,*x34),
                                          float4(*x41,*x42,*x43,*x44));
    
    
    float4 result = float4(inColor * colorMatrix);
    float4 outColor = float4(*intensity * result) + ((1.0 - *intensity) * inColor);
    outTexture.write(outColor, gid);
}
