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
                            .frame(width: boundingBox.width, height: boundingBox.height)
                            .clipped()
                            .onAppear {
                                print("\(knotDataManager.getKnotName(knot: knot)) bounding box: \(boundingBox)")
                                print("인덱스", index)
                                
                                /// basicKnot 가 아닐경우 아래 계산이 필요 없어서 리턴
                                guard let basicKnot = knotDataManager.getBasicKnotData(knot: knot) else { return }
                                setKnotSizeDict(basicKnot: basicKnot, boundingBox: boundingBox)
                                imagePatternViewModel.checkSizeCalFinished(knotList: knotDataManager.knotList)
                            }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(height: boundingBox.height)
            } else {
                Text("Image not found")
            }
        }
    }
    
    func setKnotSizeDict(basicKnot: BasicKnot, boundingBox: CGRect) {
        imagePatternViewModel.boundingSizeDict[index] = boundingBox.size
        var availableBottomSize = CGSize(width: 0, height: 0)
        var availableTopSize = CGSize(width: 0, height: 0)
        
        let bottomHeightRatio: CGFloat = basicKnot.bottomHeightRatio
        let bottomWidthRatio: CGFloat = basicKnot.bottomWidthRatio
        
        let availableBottomHeight = bottomHeightRatio * boundingBox.height
        let availableBottomWidth = bottomWidthRatio * boundingBox.width
        availableBottomSize = CGSize(width: availableBottomWidth, height: availableBottomHeight)
        imagePatternViewModel.bottomSizeDict[index] = availableBottomSize
        
        let topWidthRatio: CGFloat = basicKnot.topWidthRatio
        let topHeightRatio: CGFloat = basicKnot.topHeightRatio
        
        let availableTopWidth = topWidthRatio * boundingBox.width
        let availableTopHeight = topHeightRatio * boundingBox.height
        availableTopSize = CGSize(width: availableTopWidth, height: availableTopHeight)
        imagePatternViewModel.topSizeDict[index] = availableTopSize
    }
}

