//
//  AccWhiteBalanceFilter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
kernel void WhiteBalance(texture2d<float, access::read> inTexture [[texture(0)]],
                         texture2d<float, access::write> outTexture [[texture(1)]],
                         device float *temperature [[buffer(0)]],
                         device float *tint [[buffer(1)]],
                         uint2 gid [[thread_position_in_grid]])
{
    const float3 warmFilter = float3(0.93, 0.54, 0.0);
    const float3x3 RGBtoYIQ = float3x3(float3(0.299, 0.587, 0.114),
                                       float3(0.596, -0.274, -0.322),
                                       float3(0.212, -0.523, 0.311));
    const float3x3 YIQtoRGB = float3x3(float3(1.0, 0.956, 0.621),
                                       float3(1.0, -0.272, -0.647),
                                       float3(1.0, -1.105, 1.702));
    
    float4 inColor = inTexture.read(gid);
    float3 yiq = RGBtoYIQ * inColor.rgb;
    yiq.b = clamp(yiq.b + *tint * 0.5226 * 0.1, -0.5226, 0.5226);
    float3 rgb = YIQtoRGB * yiq;
    
    float3 processed = float3(
                              (rgb.r < 0.5 ? (2.0 * rgb.r * warmFilter.r) : (1.0 - 2.0 * (1.0 - rgb.r) * (1.0 - warmFilter.r))), //adjusting temperature
                              (rgb.g < 0.5 ? (2.0 * rgb.g * warmFilter.g) : (1.0 - 2.0 * (1.0 - rgb.g) * (1.0 - warmFilter.g))),
                              (rgb.b < 0.5 ? (2.0 * rgb.b * warmFilter.b) : (1.0 - 2.0 * (1.0 - rgb.b) * (1.0 - warmFilter.b))));
    
    float4 outColor = float4(mix(rgb, processed, *temperature), inColor.a);
    outTexture.write(outColor, gid);
}

