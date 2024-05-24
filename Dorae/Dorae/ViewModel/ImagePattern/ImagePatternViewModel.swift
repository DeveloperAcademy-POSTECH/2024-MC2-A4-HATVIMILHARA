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
    var boundingSizeDict: [Int:CGSize] = [:]
    var topSizeDict: [Int:CGSize] = [:]
    var bottomSizeDict: [Int:CGSize] = [:]
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
            guard let previousKnotBottomSize = self.bottomSizeDict[idx-1] else { return }
            guard let currentKnotBottomSize = self.bottomSizeDict[idx] else { return }
            
            // 위 빈공간 넓이보다 내 공간 넓이가 작으면
            if previousKnotBottomSize.width > currentKnotBottomSize.width {
                // 이전 매듭 공간 높이 만큼 올리고, 이전 매듭에 적용된 오프셋만큼 더 올려줌
                self.offsetYDict[idx] = -previousKnotBottomSize.height + (self.offsetYDict[idx - 1] ?? 0)
                return
            }
            
            // 위 조건에 안걸렸을때(위 빈공간 보다 작지 않을때) 이전 매듭의 오프셋을 확인해서 값이 있으면 (마이너스 값) 내 오프셋에다가 위 오프셋 그대로 적용
            if self.offsetYDict[idx - 1] ?? 0 < 0 {
                self.offsetYDict[idx] = self.offsetYDict[idx - 1]
            }
            
            // top offset 적용을 위해 하나씩 이전의 매듭을 참조하면서 내 오프셋을 계산
            for preIdx in stride(from: idx-1, through: 0, by: -1) {
                guard let currentKnotTopSize = self.topSizeDict[idx] else { return }

                if currentKnotTopSize.width > self.boundingSizeDict[preIdx]?.width ?? 0 {
                    let preRectHeight = self.boundingSizeDict[preIdx]?.height ?? 0
                    if currentKnotTopSize.height - preRectHeight >= 0 {
                        
                        self.offsetYDict[idx] = -preRectHeight + (self.offsetYDict[idx] ?? 0)
                        
                        // 매듭이 들어간 만큼 top 공간 사이즈 값을 줄여줌
                        self.topSizeDict[idx] = CGSize(width: currentKnotTopSize.width, height: currentKnotTopSize.height - preRectHeight)
                    }else {
                        self.offsetYDict[idx] = -currentKnotTopSize.height + (self.offsetYDict[idx] ?? 0)
                        
                        // 매듭이 들어간 만큼 top 공간 사이즈 값을 줄여줌
                        self.topSizeDict[idx] = CGSize(width: currentKnotTopSize.width, height: 0)
                    }
                }
            }
        }else {
            self.offsetYDict[idx] = 0

        }
    }
}
