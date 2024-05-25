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
    
    var body: some View {
        VStack {
            HStack {
                Text("이미지 도안")
                    .font(.title)
                    .bold()
                Spacer()
                Button {
                    //TODO: 사이즈 버튼 이미지로 바꾸기
                    print("사이즈 버튼 클릭")
                } label: {
                    Text("사이즈 버튼")
                }
            }
            .padding(.horizontal)
            ScrollView {
                VStack {
                    ForEach(Array(knotDataManager.knotList.enumerated()), id: \.offset) { idx, knot in
                        KnotImageView(imagePatternViewModel: imagePatternVM, knot: knot, index: idx)
                            .offset(y: imagePatternVM.offsetYDict[idx] ?? 0)
                    }
                    
                }
            }
            .scrollIndicators(.hidden)
        }
           
    }
}
