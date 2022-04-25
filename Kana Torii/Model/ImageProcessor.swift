//
//  ImageProcessor.swift
//  Kana Torii
//
//  Created by Clément FLORET on 12/10/2020.
//

import Foundation
import CoreVideo
import CoreImage
import UIKit

struct ImageProcessor {
    static func pixelBuffer(forImage image:CGImage) -> CVPixelBuffer? {
        
        let frameSize = CGSize(width: image.width, height: image.height)
        
        var pixelBuffer:CVPixelBuffer? = nil
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(frameSize.width), Int(frameSize.height), kCVPixelFormatType_32BGRA , nil, &pixelBuffer)
        
        if status != kCVReturnSuccess {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags.init(rawValue: 0))
        let data = CVPixelBufferGetBaseAddress(pixelBuffer!)
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
        let context = CGContext(data: data, width: Int(frameSize.width), height: Int(frameSize.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        context?.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        return pixelBuffer
    }
    
    static func invertColorsImage(forImageView imageView:UIImageView) -> UIImageView? {
        if let imageToInvert = imageView.image {
            let ciImage = convertCGImageToCIImage(image: imageToInvert.cgImage!)
            if let filter = CIFilter(name: "CIColorInvert") {
                filter.setValue(ciImage, forKey: kCIInputImageKey)
                var newImage = UIImage(ciImage: filter.outputImage!)
                let newCgImage = convertCIImageToCGImage(image: newImage.ciImage!)
                newImage = UIImage(cgImage: newCgImage!)
                imageView.image = newImage
            }
        }
        return imageView
    }
    
    static func convertCGImageToCIImage(image: CGImage) -> CIImage! {
        let ciImage = CIImage(cgImage: image)
        return ciImage
    }
    
    static func convertCIImageToCGImage(image: CIImage) -> CGImage! {
        let context = CIContext(options: nil)
        return context.createCGImage(image, from: image.extent)
    }
}
