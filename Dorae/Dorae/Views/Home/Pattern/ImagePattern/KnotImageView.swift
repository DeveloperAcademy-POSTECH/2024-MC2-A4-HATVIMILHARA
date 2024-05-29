//
//  KnotImageView.swift
//  Dorae
//
//  Created by Damin on 5/23/24.
//

import SwiftUI

struct KnotImageView: View {
    @Environment(KnotDataManager.self) var knotDataManager: KnotDataManager
    @Bindable var imagePatternViewModel: ImagePatternViewModel
    
    let knot: Knot
    let index: Int
    var body: some View {
        Group {
            if let image = UIImage(named: knotDataManager.getKnotName(knot: knot)) {
                let boundingBox = image.croppedBoundingBox()
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: boundingBox.height,
                                   height: getHeight(for: knot, boundingBox: boundingBox))
                            .onAppear {
                                setKnotSizeDict(knot: knot, boundingBox: boundingBox)
                                imagePatternViewModel.checkSizeCalFinished(knotList: knotDataManager.knotList)
                            }
                            .onChange(of: knotDataManager.knotList) { _, _ in
                                setKnotSizeDict(knot: knot, boundingBox: boundingBox)
                                imagePatternViewModel.checkSizeCalFinished(knotList: knotDataManager.knotList)
                            }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: boundingBox.height)
                .frame(height: getHeight(for: knot, boundingBox: boundingBox))
            } else {
                Text("Image not found")
            }
        }
    }

    /// 카테고리 별로 비율을 다르게 줄 수도 있어서 일단 분기처리
       private func getHeight(for knot: Knot, boundingBox: CGRect) -> CGFloat {
           switch knot {
           case .basic:
               return boundingBox.height * 0.3
           case .applied:
               return boundingBox.height * 0.3
           case .etc:
               return boundingBox.height * 0.5
           }
       }
    
    private func setKnotSizeDict(knot: Knot, boundingBox: CGRect) {
        var bottomHeightRatio: CGFloat = 0
        var bottomWidthRatio: CGFloat = 1
        var topHeightRatio: CGFloat = 0
        var topWidthRatio: CGFloat = 1
        
        switch knot {
        case .basic(let knot):
            bottomHeightRatio = knot.bottomHeightRatio
            bottomWidthRatio = knot.bottomWidthRatio
            topWidthRatio = knot.topWidthRatio
            topHeightRatio = knot.topHeightRatio
        default:
            break
        }

        imagePatternViewModel.boundingSizeDict[index] = boundingBox.size
        var availableBottomSize = CGSize(width: 0, height: 0)
        
        let availableBottomHeight = bottomHeightRatio * boundingBox.height * 0.4
        let availableBottomWidth = bottomWidthRatio * boundingBox.width * 0.4
        availableBottomSize = CGSize(width: availableBottomWidth, height: availableBottomHeight)
        imagePatternViewModel.bottomSizeDict[index] = availableBottomSize
        
        var availableTopSize = CGSize(width: 0, height: 0)
        let availableTopWidth = topWidthRatio * boundingBox.width * 0.4
        let availableTopHeight = topHeightRatio * boundingBox.height * 0.4

        availableTopSize = CGSize(width: availableTopWidth, height: availableTopHeight)
        imagePatternViewModel.topSizeDict[index] = availableTopSize
    }
}

