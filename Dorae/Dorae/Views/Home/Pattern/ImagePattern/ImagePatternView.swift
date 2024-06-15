//
//  ImagePatternView.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import SwiftUI

struct ImagePatternView: View {
    @State private var imagePatternVM = ImagePatternViewModel()
    @Bindable var pattern: Pattern
    
    var body: some View {
        VStack {
            ForEach(Array(pattern.knotList.enumerated()), id: \.offset) { idx, knot in
                KnotImageView(pattern: pattern, imagePatternViewModel: imagePatternVM, knot: knot, index: idx)
                    .offset(y: imagePatternVM.offsetYDict[idx] ?? 0)
            }
        }
        .padding(.top, 24)
    }
}
