//
//  ImagePatternView.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import SwiftUI
import CoreGraphics


struct ImagePatternView: View {
    @Environment(KnotDataManager.self) var knotDataManager: KnotDataManager
    @State private var imagePatternVM = ImagePatternViewModel()
    
    @Bindable var pattern: Pattern
    
    var body: some View {
        VStack {
                VStack {
                    ForEach(Array(pattern.knotList.enumerated()), id: \.offset) { idx, knot in
                        KnotImageView(imagePatternViewModel: imagePatternVM, knot: knot, index: idx)
                            .offset(y: imagePatternVM.offsetYDict[idx] ?? 0)
                    }
                }
        }
           
    }
}
