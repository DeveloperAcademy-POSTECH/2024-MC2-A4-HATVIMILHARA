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
                    .padding(.leading, 16)
                    .padding(.top, 22)
                    .padding(.bottom, 8)
                    .font(.title2.bold())
                    .foregroundStyle(.white)
                PatternPartView()
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
                KnotView(pattern: pattern)
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
    var body: some View {
        GeometryReader { geometry in
            HStack {
                ImagePatternView()
                    .frame(width: geometry.size.width/2)
                    .padding(.vertical, 20)
                Divider()
                    .rotationEffect(.zero)
                TextPatternView()
                    .frame(width: geometry.size.width/2)
            }
            
        }
    }
}


