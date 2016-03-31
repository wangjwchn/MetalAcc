![MetalAcc](https://raw.githubusercontent.com/wangjwchn/MetalAcc/master/cover.png?token=ANBWxJ4T8E4b9BbzKQ5TQPakNKgW_yKKks5XBkdRwA%3D%3D)
GPU-Based Media Processing Library Using Metal in Swift
#Overview
MetalAcc is a GPU-Based media processing library that lets you apply GPU-accelerated filters to images.

This library is highly insperad by famous library [GPUImage](http://github.com/BradLarson/GPUImage). Basically following the nterface of GPUImage,
but using [Metal](https://developer.apple.com/metal/) and [Swift](https://www.swift.com), Apple's new graphics and compute application programming interface and programing language.

This library is currently under programing.And more filters will be adding soon.If you want to add a new filter for this library,see [here]() to follow the steps.
#Requirements
|Device Name 							|GPU          |
|--------------------------------|-------------|
|iPhone 6s							|Apple A9 GPU |
|iPhone 6s Plus						|Apple A9 GPU |
|iPhone 6								|Apple A8 GPU |
|iPhone 6 Plus						|Apple A8 GPU |
|iPhone 5s							|Apple A7 GPU |
|iPad Pro Wi-Fi						|Apple A9 GPU |
|iPad Pro Wi-Fi + Cellular			|Apple A9 GPU |
|iPad Air 2 Wi-Fi					|Apple A8 GPU |
|iPad Air 2 Wi-Fi + Cellular		|Apple A8 GPU |
|iPad Air Wi-Fi						|Apple A7 GPU |
|iPad Air Wi-Fi + Cellular			|Apple A7 GPU |
|iPad mini 4 Wi-Fi					|Apple A8 GPU |
|iPad mini 4 Wi-Fi + Cellular		|Apple A8 GPU |
|iPad mini 3 Wi-Fi					|Apple A7 GPU |
|iPad mini 3 Wi-Fi + Cellular		|Apple A7 GPU |
|iPad mini 2 Wi-Fi					|Apple A7 GPU |
|iPad mini 2 Wi-Fi + Cellular		|Apple A7 GPU |
|iPod Touch (6th generation)		|Apple A8 GPU |



#Instructions
##Using Image filter
```swift
let image = UIImage(named: "DemoImage")!

//Add Image
let accimage = AccImage()
accimage.AddImage(image)

//Add filter
let filter = AccBrightnessFilter()
filter.brightness = 0.95
accimage.AddFilter(filter)

//Processing
let outimage = accimage.Processing()
 imageview.image = outimage
```
####AccBrightnessFilter: Adjusts the brightness of the image
 - brightness: The adjusted brightness (-1.0 ~ 1.0, with 0.0 as the default)

####AccContrastFilter: Adjusts the contrast of the image

- contrast: The adjusted contrast (0.0 ~ 4.0, with 1.0 as the default)

####AccSaturationFilter: Adjusts the saturation of an image

- saturation: The degree of saturation or desaturation to apply to the image (0.0 ~ 2.0, with 1.0 as the default)
 
####AccImageGammaFilter: Adjusts the gamma of an image

 - gamma: The gamma adjustment to apply (0.0 ~ 3.0, with 1.0 as the default)
 
####AccPixelateFilter:Pixelate an image
 - pixelSize:The degree of pixelating (>0)

####AccColorInvertFilter: Inverts the colors of an image

####AccGaussianBlurFilter:Gaussian blur
 - sigma:The standard deviation of gaussian blur filter

####AccSobelFilter: Initialize a Sobel filter on a given device using the default color
 - transform. Default: BT.601/JPEG {0.299f, 0.587f, 0.114f}

####AccGrayscaleFilter: Converts an image to grayscale
 
####AccContrastFilter: Adjusts the contrast of the image
 - contrast: The adjusted contrast (0.0 - 4.0, with 1.0 as the default)
 
#Contribution
####Follow these steps to add a new filter to this library:

1.Add a shading function in AccImageFilterShaders.metal.

2.Create a new filter class inherited class 'AccImageFilter'.

2.1.Override function init(),add a name,this name must be as same as the shading function in AccImageFilterShaders.metal. 

2.2.Override function applyFilter() to add a commandBuffer and commit.You can use the generic function in superclass to simplify the code.

3.Completed.Thanks for your contribution!

#License
MetalAcc is released under the MIT license. See [LICENSE](https://github.com/wangjwchn/MetalAcc/raw/master/LICENSE) for details.