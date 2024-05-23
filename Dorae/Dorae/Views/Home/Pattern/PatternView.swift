//
//  PatternView.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import SwiftUI

struct PatternView: View {
    @State private var patternTitle = "제목없음"
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading) {
                Text("도안")
                    .padding(.leading, 16)
                    .padding(.top, 22)
                    .padding(.bottom, 8)
                    .font(.title2.bold())
                    .foregroundStyle(.white)
                HStack {
                    Text("그림도안")
                    Divider()
                        .rotationEffect(.zero)
                    Text("글도안")
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 24))
            }
            .padding(.horizontal, 24)

            VStack(alignment: .leading) {
                Text("매듭")
                    .padding(.leading, 16)
                    .padding(.top, 22)
                    .padding(.bottom, 8)
                    .font(.title2.bold())
                    .foregroundStyle(.white)
                KnotView()
                //TODO: 프레임 크기 뗀석기
                    .frame(width: 306)
            }
        }
        .background(Color.background)
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationTitle($patternTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
    }
}

