//
//  PatternView.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import SwiftUI

struct PatternView: View {
    @Environment(KnotDataManager.self) var knotDataManager
    @Environment(\.modelContext) var modelContext
    @Bindable var pattern: Pattern
    
    var body: some View {
    
        HStack(spacing: 0) {
            VStack(alignment: .leading) {
                Text("도안")
                    .padding(EdgeInsets(top: 22, leading: 16, bottom: 8, trailing: 0))
                    .font(.title2.bold())
                    .foregroundStyle(.white)
                PatternPartView(pattern: pattern)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
            }
            .padding(.horizontal, 24)

            VStack(alignment: .leading) {
                Text("매듭")
                    .padding(EdgeInsets(top: 22, leading: 16, bottom: 8, trailing: 0))
                    .font(.title2.bold())
                    .foregroundStyle(.white)
                KnotListView(pattern: pattern)
                //TODO: 프레임 크기 뗀석기
                    .frame(width: 306)
            }
        }
        .background(Color.background)
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationTitle($pattern.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
    }
}


struct PatternPartView: View {
    @Bindable var pattern: Pattern
    @State private var imageReduction: Bool = false

    var body: some View {
        GeometryReader { geometry in
            HStack {
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
                        ImagePatternView(pattern: pattern)
                    }
                    .scrollIndicators(.hidden)
                }
                    .frame(width: geometry.size.width/2)
                    .padding(.top, 20)
                Divider()
                    .rotationEffect(.zero)
                TextPatternView(pattern: pattern)
                    .frame(width: geometry.size.width/2)
            }
            
        }
    }
}


