//
//  AccUIImage.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/19.
//  Copyright © 2016年 wangjwchn. All rights reserved.
//

import UIKit
public extension UIImage{
    public func toMTLTexture()-> MTLTexture {
        let imageRef: CGImageRef = self.CGImage!
        let width: Int = CGImageGetWidth(imageRef)
        let height: Int = CGImageGetHeight(imageRef)
        let colorSpace: CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()!
        let rawData  = malloc(height * width * 4)//byte
        let bytesPerPixel: Int = 4
        let bytesPerRow: Int = bytesPerPixel * width
        let bitsPerComponent: Int = 8
        
        let bitmapContext: CGContextRef = CGBitmapContextCreate(rawData, width, height, bitsPerComponent, bytesPerRow, colorSpace, (CGBitmapInfo.ByteOrder32Big.rawValue | CGImageAlphaInfo.PremultipliedLast.rawValue))!
        
        CGContextTranslateCTM(bitmapContext, 0, CGFloat(height))
        CGContextScaleCTM(bitmapContext, 1, -1)
        CGContextDrawImage(bitmapContext,CGRect(x: 0, y: 0,width: CGFloat(width), height: CGFloat(height)),imageRef)
        
        let textureDescriptor: MTLTextureDescriptor = MTLTextureDescriptor.texture2DDescriptorWithPixelFormat(.RGBA8Unorm, width: width, height: height, mipmapped: false)
        
        let texture: MTLTexture = MTLCreateSystemDefaultDevice()!.newTextureWithDescriptor(textureDescriptor)
        let region: MTLRegion = MTLRegionMake2D(0, 0, width, height)
        texture.replaceRegion(region, mipmapLevel: 0, withBytes: rawData, bytesPerRow: bytesPerRow)
        free(rawData)
        return texture
    }
}