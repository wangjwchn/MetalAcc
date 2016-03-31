//
//  Kernels.metal
//  MetalImage
//
//  Created by Geppy Parziale on 1/5/16.
//  Copyright © 2016 iNVASIVECODE Inc. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

kernel void Pixelate(texture2d<float, access::read> inTexture [[texture(0)]],
					 texture2d<float, access::write> outTexture [[texture(1)]],
					 device unsigned int *pixelSize [[buffer(0)]],
					 uint2 gid [[thread_position_in_grid]])
{
	const uint2 pixellateGrid = uint2((gid.x / pixelSize[0]) * pixelSize[0], (gid.y / pixelSize[0]) * pixelSize[0]);
	const float4 colorAtPixel = inTexture.read(pixellateGrid);
	outTexture.write(colorAtPixel, gid);
}


kernel void Grayscale(texture2d<float, access::read> inTexture [[texture(0)]],
                              texture2d<float, access::write> outTexture [[texture(1)]],
                              device float *factor [[buffer(0)]],
                              uint2 gid [[thread_position_in_grid]])
{
    float4 inColor = inTexture.read(gid);
    float value = dot(inColor.rgb, float3(0.299, 0.587, 0.114));
    float4 grayColor(value, value, value, 1.0);
    float4 outColor = mix(grayColor, inColor, *factor);
    outTexture.write(outColor, gid);
}


kernel void Brightness(texture2d<float, access::read> inTexture [[texture(0)]],
                      texture2d<float, access::write> outTexture [[texture(1)]],
                      device float *factor [[buffer(0)]],
                      uint2 gid [[thread_position_in_grid]])
{
    float4 inColor = inTexture.read(gid);
    float4 outColor(inColor.r * *factor,
                    inColor.g * *factor,
                    inColor.b * *factor,
                    1.0);
    outTexture.write(outColor, gid);
}

kernel void Saturation(texture2d<float, access::read> inTexture [[texture(0)]],
                       texture2d<float, access::write> outTexture [[texture(1)]],
                       device float *factor [[buffer(0)]],
                       uint2 gid [[thread_position_in_grid]])
{
    float4 inColor = inTexture.read(gid);
    float value = dot(inColor.rgb, float3(0.2125, 0.7154, 0.0721));
    float4 grayColor(value, value, value, 1.0);
    float4 outColor = mix(grayColor, inColor, *factor);
    outTexture.write(outColor, gid);
}

kernel void Gamma(texture2d<float, access::read> inTexture [[texture(0)]],
                  texture2d<float, access::write> outTexture [[texture(1)]],
                  device float *factor [[buffer(0)]],
                  uint2 gid [[thread_position_in_grid]])
{
    float4 inColor = inTexture.read(gid);
    float4 outColor(pow(inColor.r,*factor),
                    pow(inColor.g,*factor),
                    pow(inColor.b,*factor),
                    1.0);

    outTexture.write(outColor, gid);
}

kernel void ColorInvert(texture2d<float, access::read> inTexture [[texture(0)]],
                        texture2d<float, access::write> outTexture [[texture(1)]],
                        uint2 gid [[thread_position_in_grid]])
{
    float4 inColor = inTexture.read(gid);
    float4 outColor(1.0 - inColor.r,
                    1.0 - inColor.g,
                    1.0 - inColor.b,
                    1.0);
    
    outTexture.write(outColor, gid);
}

