//
//  Image+.swift
//  Dorae
//
//  Created by Damin on 5/23/24.
//

import UIKit

extension UIImage {
    func croppedBoundingBox() -> CGRect {
        guard let cgImage = self.cgImage else { return .zero }
        let width = cgImage.width
        let height = cgImage.height
        let bitmapInfo = cgImage.bitmapInfo
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let rawData = UnsafeMutablePointer<UInt8>.allocate(capacity: width * height * 4)
        let context = CGContext(data: rawData, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        guard let drawingContext = context else { return .zero }
        drawingContext.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        var minX: Int = width
        var minY: Int = height
        var maxX: Int = 0
        var maxY: Int = 0
        
        for y in 0..<height {
            for x in 0..<width {
                let pixelIndex = (y * width + x) * 4
                let alpha = rawData[pixelIndex + 3]
                
                if alpha > 0 {
                    if x < minX { minX = x }
                    if y < minY { minY = y }
                    if x > maxX { maxX = x }
                    if y > maxY { maxY = y }
                }
            }
        }
        
        rawData.deallocate()
        
        return CGRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
    }
}
