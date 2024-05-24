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
                                print("\(knotDataManager.getKnotName(knot: knot)) bounding boxSize: \(boundingBox.size)")
                                print("인덱스", index)
                                setKnotSizeDict(knot: knot, boundingBox: boundingBox)
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
    
    func setKnotSizeDict(knot: Knot, boundingBox: CGRect) {
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
        
        let availableBottomHeight = bottomHeightRatio * boundingBox.height
        let availableBottomWidth = bottomWidthRatio * boundingBox.width
        availableBottomSize = CGSize(width: availableBottomWidth, height: availableBottomHeight)
        imagePatternViewModel.bottomSizeDict[index] = availableBottomSize
        
        var availableTopSize = CGSize(width: 0, height: 0)
        let availableTopWidth = topWidthRatio * boundingBox.width
        let availableTopHeight = topHeightRatio * boundingBox.height

        availableTopSize = CGSize(width: availableTopWidth, height: availableTopHeight)
        imagePatternViewModel.topSizeDict[index] = availableTopSize
    }
}

