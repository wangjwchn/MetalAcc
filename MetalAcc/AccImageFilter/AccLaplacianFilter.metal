//
//  AccLaplacianFilter.metal
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/5.
//  Copyright © 2016年 JW. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
kernel void Laplacian(texture2d<float, access::read> inTexture [[texture(0)]],
                     texture2d<float, access::write> outTexture [[texture(1)]],
                     uint2 gid [[thread_position_in_grid]])
{
    const float3x3 convolutionMatrix = float3x3(float3(0.5,1.0,0.5),float3(1.0,-6.0,1.0),float3(0.5,1.0,0.5));
    
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

    // Normalize the results to allow for negative gradients in the 0.0-1.0 colorspace
    resultColor = resultColor + 0.5;
    
    const float4 outColor = float4(resultColor,centerColor.a);
    outTexture.write(outColor,gid);

}