//
//  AccChromaKeyFilter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/1.
//  Copyright © 2016年 JW. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
kernel void ChromaKey(texture2d<float, access::read> inTexture [[texture(0)]],
                      texture2d<float, access::write> outTexture [[texture(1)]],
                      device float *thresholdSensitivity [[buffer(0)]],
                      device float *smoothing [[buffer(1)]],
                      device float *R [[buffer(2)]],
                      device float *G [[buffer(3)]],
                      device float *B [[buffer(4)]],
                      uint2 gid [[thread_position_in_grid]])
{
    float3 colorToReplace = float3(*R,*G,*B);
    float maskY = 0.2989 * colorToReplace.r + 0.5866 * colorToReplace.g + 0.1145 * colorToReplace.b;
    float maskCr = 0.7132 * (colorToReplace.r - maskY);
    float maskCb = 0.5647 * (colorToReplace.b - maskY);
    float4 inColor = inTexture.read(gid);
    float Y = 0.2989 * inColor.r + 0.5866 * inColor.g + 0.1145 * inColor.b;
    float Cr = 0.7132 * (inColor.r - Y);
    float Cb = 0.5647 * (inColor.b - Y);
    float blendValue = smoothstep(*thresholdSensitivity, *thresholdSensitivity + *smoothing, distance(float2(Cr, Cb),float2(maskCr, maskCb)));
    float4 outColor = float4(inColor.rgb,inColor.a * blendValue);
    outTexture.write(outColor, gid);
}

