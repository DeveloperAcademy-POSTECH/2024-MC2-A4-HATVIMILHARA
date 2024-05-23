//
//  ImagePatternViewModel.swift
//  Dorae
//
//  Created by Damin on 5/23/24.
//

import Foundation

@Observable
final class ImagePatternViewModel {
    
    // MARK: - 이미지 도안에서 쓸 데이터
    var topSizeDict: [Int:CGSize] = [:]
    var bottomsizeDict: [Int:CGSize] = [:]
    var offsetYDict: [Int:CGFloat] = [:]
    
    private var sizeCalCount = 0
    
    func checkSizeCalFinished(knotList: [Knot]) {
        sizeCalCount += 1
        if sizeCalCount == knotList.count {
            sizeCalCount = 0
            for idx in 0..<knotList.count {
                calCurrentOffset(idx: idx)
            }
        }
    }
    
    func calCurrentOffset(idx: Int)  {
        if idx > 0 {
            guard let previousKnotBottomSize = self.bottomsizeDict[idx-1] else { return }
            guard let currentKnotBottomSize = self.bottomsizeDict[idx] else { return }
            
            if previousKnotBottomSize.width > currentKnotBottomSize.width {
                print("yOffset", -previousKnotBottomSize.height)
                self.offsetYDict[idx] = -previousKnotBottomSize.height + (self.offsetYDict[idx - 1] ?? 0)
                return
            }
            
            guard let currentKnotTopSize = self.topSizeDict[idx] else { return }
            
            if self.offsetYDict[idx - 1] ?? 0 < 0 {
                self.offsetYDict[idx] = self.offsetYDict[idx - 1]
            }
            
            for preIdx in stride(from: idx-1, through: 0, by: -1) {
                
                if currentKnotTopSize.width > self.bottomsizeDict[preIdx]?.width ?? 0 {
                    if currentKnotTopSize.height + (self.offsetYDict[preIdx] ?? 0) >= 0 {
                        self.offsetYDict[idx] = (self.offsetYDict[preIdx] ?? 0) + (self.offsetYDict[idx] ?? 0)
                    }
                }
                break
            }
        }else {
            self.offsetYDict[idx] = 0

        }
    }
}
