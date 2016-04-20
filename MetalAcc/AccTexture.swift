//
//  AccTexture.swift
//  MetalAcc
//
//  Created by 王佳玮 on 16/4/19.
//  Copyright © 2016年 wangjwchn. All rights reserved.
//

import MetalKit
public extension MTLTexture{
    
    public func sameSizeEmptyTexture()->MTLTexture{
        let textureDescriptor = MTLTextureDescriptor.texture2DDescriptorWithPixelFormat(self.pixelFormat, width: self.width, height: self.height, mipmapped: false)
        return MTLCreateSystemDefaultDevice()!.newTextureWithDescriptor(textureDescriptor)
    }
    
    public func threadGroups()->MTLSize{
        let groupCount = threadGroupCount()
        return MTLSizeMake(Int(self.width) / groupCount.width, Int(self.height) / groupCount.height, 1)
    }
    public func threadGroupCount()->MTLSize{
        return MTLSizeMake(16, 16, 1)
    }
    
    public func toImage() -> UIImage {
        let bytesPerPixel: Int = 4
        let imageByteCount = self.width * self.height * bytesPerPixel
        let bytesPerRow = self.width * bytesPerPixel
        var src = [UInt8](count: Int(imageByteCount), repeatedValue: 0)
        
        let region = MTLRegionMake2D(0, 0, self.width, self.height)
        self.getBytes(&src, bytesPerRow: bytesPerRow, fromRegion: region, mipmapLevel: 0)
        
        let bitmapInfo = CGBitmapInfo(rawValue: (CGBitmapInfo.ByteOrder32Big.rawValue | CGImageAlphaInfo.PremultipliedLast.rawValue))
        
        let grayColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitsPerComponent = 8
        let context = CGBitmapContextCreate(&src, self.width, self.height, bitsPerComponent, bytesPerRow, grayColorSpace, bitmapInfo.rawValue);
        
        let dstImageFilter = CGBitmapContextCreateImage(context);
        
        return UIImage(CGImage: dstImageFilter!, scale: 0.0, orientation: UIImageOrientation.DownMirrored)
    }
}