![MetalAcc](https://raw.githubusercontent.com/wangjwchn/MetalAcc/master/cover.png?token=ANBWxJ4T8E4b9BbzKQ5TQPakNKgW_yKKks5XBkdRwA%3D%3D)
GPU-based media processing library using Metal written in Swift.
#Overview
MetalAcc is a GPU-Based media processing library that lets you apply GPU-accelerated filters to images.

This library is highly insperad by famous library [Acc](http://github.com/BradLarson/Acc). Basically following the nterface of Acc,
but using [Metal](https://developer.apple.com/metal/) and [Swift](https://www.swift.com), Apple's new graphics and compute application programming interface and programing language.

This library is currently under programing.And more filters will be adding soon.If you want to add a new filter for this library,see [here](https://github.com/wangjwchn/MetalAcc#contribution).
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
### Color adjustments ###

- **AccBrightnessFilter**: Adjusts the brightness of the image
  - *brightness*: The adjusted brightness (-1.0 ~ 1.0, with 0.0 as the default)

- **AccExposureFilter**: Adjusts the exposure of the image
  - *exposure*: The adjusted exposure (-10.0 ~ 10.0, with 0.0 as the default)

- **AccContrastFilter**: Adjusts the contrast of the image
  - *contrast*: The adjusted contrast (0.0 ~ 4.0, with 1.0 as the default)

- **AccSaturationFilter**: Adjusts the saturation of an image
  - *saturation*: The degree of saturation or desaturation to apply to the image (0.0 ~ 2.0, with 1.0 as the default)

- **AccGammaFilter**: Adjusts the gamma of an image
  - *gamma*: The gamma adjustment to apply (0.0 ~ 3.0, with 1.0 as the default)

- **AccLevelsFilter**: Photoshop-like levels adjustment. The min, max, minOut and maxOut parameters are floats in the range [0, 1]. If you have parameters from Photoshop in the range [0, 255] you must first convert them to be [0, 1]. The gamma/mid parameter is a float >= 0. This matches the value from Photoshop. If you want to apply levels to RGB as well as individual channels you need to use this filter twice - first for the individual channels and then for all channels.

- **AccColorMatrixFilter**: Transforms the colors of an image by applying a matrix to them
  - *colorMatrix*: A 4x4 matrix used to transform each color in an image
  - *intensity*: The degree to which the new transformed color replaces the original color for each pixel


 
- **AccRGBFilter**: Adjusts the individual RGB channels of an image
  - *red,green,blue*: Normalized values by which each color channel is multiplied. The range is from 0.0 up, with 1.0 as the default.

- **AccHueFilter**: Adjusts the hue of an image
  - *hue*: The hue angle, in degrees. 90 degrees by default

<!--
- **AccVibranceFilter**: Adjusts the vibrance of an image
  - *vibrance*: The vibrance adjustment to apply, using 0.0 as the default, and a suggested min/max of around -1.2 and 1.2, respectively.
-->


- **AccWhiteBalanceFilter**: Adjusts the white balance of an image.
  - *temperature*: The temperature to adjust the image by, in ºK. A value of 4000 is very cool and 7000 very warm. The default value is 5000. Note that the scale between 4000 and 5000 is nearly as visually significant as that between 5000 and 7000.
  - *tint*: The tint to adjust the image by. A value of -200 is *very* green and 200 is *very* pink. The default value is 0.  

<!-- 
- **AccToneCurveFilter**: Adjusts the colors of an image based on spline curves for each color channel.
  - *redControlPoints*:
  - *greenControlPoints*:
  - *blueControlPoints*: 
  - *rgbCompositeControlPoints*: The tone curve takes in a series of control points that define the spline curve for each color component, or for all three in the composite. These are stored as NSValue-wrapped CGPoints in an NSArray, with normalized X and Y coordinates from 0 - 1. The defaults are (0,0), (0.5,0.5), (1,1).
-->

- **AccHighlightShadowFilter**: Adjusts the shadows and highlights of an image
  - *shadows*: Increase to lighten shadows, from 0.0 to 1.0, with 0.0 as the default.
  - *highlights*: Decrease to darken highlights, from 1.0 to 0.0, with 1.0 as the default.

<!-- 
- **AccHighlightShadowTintFilter**: Allows you to tint the shadows and highlights of an image independently using a color and intensity
  - *shadowTintColor*: Shadow tint RGB color (GPUVector4). Default: `{1.0f, 0.0f, 0.0f, 1.0f}` (red).
  - *highlightTintColor*: Highlight tint RGB color (GPUVector4). Default: `{0.0f, 0.0f, 1.0f, 1.0f}` (blue).
  - *shadowTintIntensity*: Shadow tint intensity, from 0.0 to 1.0. Default: 0.0
  - *highlightTintIntensity*: Highlight tint intensity, from 0.0 to 1.0, with 0.0 as the default.


- **AccLookupFilter**: Uses an RGB color lookup image to remap the colors in an image. First, use your favourite photo editing application to apply a filter to lookup.png from Acc/framework/Resources. For this to work properly each pixel color must not depend on other pixels (e.g. blur will not work). If you need a more complex filter you can create as many lookup tables as required. Once ready, use your new lookup.png file as a second input for AccLookupFilter.

- **AccAmatorkaFilter**: A photo filter based on a Photoshop action by Amatorka: http://amatorka.deviantart.com/art/Amatorka-Action-2-121069631 . If you want to use this effect you have to add lookup_amatorka.png from the Acc Resources folder to your application bundle.

- **AccMissEtikateFilter**: A photo filter based on a Photoshop action by Miss Etikate: http://miss-etikate.deviantart.com/art/Photoshop-Action-15-120151961 . If you want to use this effect you have to add lookup_miss_etikate.png from the Acc Resources folder to your application bundle.

- **AccSoftEleganceFilter**: Another lookup-based color remapping filter. If you want to use this effect you have to add lookup_soft_elegance_1.png and lookup_soft_elegance_2.png from the Acc Resources folder to your application bundle.

- **AccSkinToneFilter**: A skin-tone adjustment filter that affects a unique range of light skin-tone colors and adjusts the pink/green or pink/orange range accordingly. Default values are targetted at fair caucasian skin, but can be adjusted as required.
  - *skinToneAdjust*: Amount to adjust skin tone. Default: 0.0, suggested min/max: -0.3 and 0.3 respectively.
  - *skinHue*: Skin hue to be detected. Default: 0.05 (fair caucasian to reddish skin).
  - *skinHueThreshold*: Amount of variance in skin hue. Default: 40.0.
  - *maxHueShift*: Maximum amount of hue shifting allowed. Default: 0.25.
  - *maxSaturationShift* = Maximum amount of saturation to be shifted (when using orange). Default: 0.4.
  - *upperSkinToneColor* = `AccSkinToneUpperColorGreen` or `AccSkinToneUpperColorOrange`
--> 
  
- **AccColorInvertFilter**: Inverts the colors of an image

- **AccGrayscaleFilter**: Converts an image to grayscale (a slightly faster implementation of the saturation filter, without the ability to vary the color contribution)

- **AccMonochromeFilter**: Converts the image to a single-color version, based on the luminance of each pixel
  - *intensity*: The degree to which the specific color replaces the normal image color (0.0 - 1.0, with 1.0 as the default)
  - *color*: The color to use as the basis for the effect, with (0.6, 0.45, 0.3, 1.0) as the default.

- **AccFalseColorFilter**: Uses the luminance of the image to mix between two user-specified colors
  - *firstColor*: The first and second colors specify what colors replace the dark and light areas of the image, respectively. The defaults are (0.0, 0.0, 0.5) amd (1.0, 0.0, 0.0).
  - *secondColor*: 

- **AccHazeFilter**: Used to add or remove haze (similar to a UV filter)
  - *distance*: Strength of the color applied. Default 0. Values between -.3 and .3 are best.
  - *slope*: Amount of color change. Default 0. Values between -.3 and .3 are best.

- **AccSepiaFilter**: Simple sepia tone filter
  - *intensity*: The degree to which the sepia tone replaces the normal image color (0.0 - 1.0, with 1.0 as the default)

- **AccOpacityFilter**: Adjusts the alpha channel of the incoming image
  - *opacity*: The value to multiply the incoming alpha channel for each pixel by (0.0 - 1.0, with 1.0 as the default)

- **AccSolidColorGenerator**: This outputs a generated image with a solid color. You need to define the image size using -forceProcessingAtSize:
  - *color*: The color, in a four component format, that is used to fill the image.

- **AccLuminanceThresholdFilter**: Pixels with a luminance above the threshold will appear white, and those below will be black
  - *threshold*: The luminance threshold, from 0.0 to 1.0, with a default of 0.5

- **AccLuminanceThresholdFilter**: Pixels with a luminance above the threshold will appear white, and those below will be black 
  - *rangeReduction*: The degree to reduce the luminance range, from 0.0 to 1.0. Default is 0.6.

<!-- 
- **AccAdaptiveThresholdFilter**: Determines the local luminance around a pixel, then turns the pixel black if it is below that local luminance and white if above. This can be useful for picking out text under varying lighting conditions.
  - *blurRadiusInPixels*: A multiplier for the background averaging blur radius in pixels, with a default of 4.

- **AccAverageLuminanceThresholdFilter**: This applies a thresholding operation where the threshold is continually adjusted based on the average luminance of the scene.
  - *thresholdMultiplier*: This is a factor that the average luminance will be multiplied by in order to arrive at the final threshold to use. By default, this is 1.0.

- **AccHistogramFilter**: This analyzes the incoming image and creates an output histogram with the frequency at which each color value occurs. The output of this filter is a 3-pixel-high, 256-pixel-wide image with the center (vertical) pixels containing pixels that correspond to the frequency at which various color values occurred. Each color value occupies one of the 256 width positions, from 0 on the left to 255 on the right. This histogram can be generated for individual color channels (kAccHistogramRed, kAccHistogramGreen, kAccHistogramBlue), the luminance of the image (kAccHistogramLuminance), or for all three color channels at once (kAccHistogramRGB).
  - *downsamplingFactor*: Rather than sampling every pixel, this dictates what fraction of the image is sampled. By default, this is 16 with a minimum of 1. This is needed to keep from saturating the histogram, which can only record 256 pixels for each color value before it becomes overloaded.

- **AccHistogramGenerator**: This is a special filter, in that it's primarily intended to work with the AccHistogramFilter. It generates an output representation of the color histograms generated by AccHistogramFilter, but it could be repurposed to display other kinds of values. It takes in an image and looks at the center (vertical) pixels. It then plots the numerical values of the RGB components in separate colored graphs in an output texture. You may need to force a size for this filter in order to make its output visible.

- **AccAverageColor**: This processes an input image and determines the average color of the scene, by averaging the RGBA components for each pixel in the image. A reduction process is used to progressively downsample the source image on the GPU, followed by a short averaging calculation on the CPU. The output from this filter is meaningless, but you need to set the colorAverageProcessingFinishedBlock property to a block that takes in four color components and a frame time and does something with them.

- **AccLuminosity**: Like the AccAverageColor, this reduces an image to its average luminosity. You need to set the luminosityProcessingFinishedBlock to handle the output of this filter, which just returns a luminosity value and a frame time.
-->

- **AccChromaKeyFilter**: For a given color in the image, sets the alpha channel to 0. This is similar to the AccChromaKeyBlendFilter, only instead of blending in a second image for a matching color this doesn't take in a second image and just turns a given color transparent.
  - *thresholdSensitivity*: How close a color match needs to exist to the target color to be replaced (default of 0.4)
  - *smoothing*: How smoothly to blend for the color match (default of 0.1)

 
#Contribution
####Follow these steps to add a new filter to this library:

1.Add a shading function in AccImageFilterShaders.metal.

2.Create a new filter class inherited class 'AccImageFilter'.

2.1.Override function init(),add a name,this name must be as same as the shading function in AccImageFilterShaders.metal. 

2.2.Override function applyFilter() to add a commandBuffer and commit.You can use the generic function in superclass to simplify the code.

3.Completed.Thanks for your contribution!

#License
MetalAcc is released under the MIT license. See [LICENSE](https://github.com/wangjwchn/MetalAcc/raw/master/LICENSE) for details.