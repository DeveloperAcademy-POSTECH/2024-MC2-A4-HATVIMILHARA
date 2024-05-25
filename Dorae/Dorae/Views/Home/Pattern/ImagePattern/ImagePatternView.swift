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
    @State private var imageReduction: Bool = false
    
    @Bindable var pattern: Pattern
    
    var body: some View {
        VStack {
            HStack {
                Text("이미지 도안")
                    .font(.title)
                    .bold()
                Spacer()
                Button {
                    //TODO: 확대축소 기능 구현
                    imageReduction.toggle()
                } label: {
                    Image(imageReduction ? "enlargeBtn" : "reductionBtn")
                }
            }
            .padding(.horizontal)
            ScrollView {
                VStack {
                    ForEach(Array(pattern.knotList.enumerated()), id: \.offset) { idx, knot in
                        KnotImageView(imagePatternViewModel: imagePatternVM, knot: knot, index: idx)
                            .offset(y: imagePatternVM.offsetYDict[idx] ?? 0)
                    }
                    
                }
            }
            .scrollIndicators(.hidden)
        }
           
    }
}
