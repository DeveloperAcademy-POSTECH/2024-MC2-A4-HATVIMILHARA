//
//  ImagePatternView.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import SwiftUI
import CoreGraphics


struct ImagePatternView: View {
    @Environment(KnotDataManager.self) var knotDataManager
    @State private var imagePatternVM = ImagePatternViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(Array(knotDataManager.knotList.enumerated()), id: \.offset) { idx, knot in
                    KnotImageView(imagePatternViewModel: imagePatternVM, knot: knot, index: idx)
                        .offset(y: imagePatternVM.offsetYDict[idx] ?? 0)
                }
                
            }
            .padding()
        }
    }
}

#Preview {
    ImagePatternView()
        .environment(KnotDataManager())
}
