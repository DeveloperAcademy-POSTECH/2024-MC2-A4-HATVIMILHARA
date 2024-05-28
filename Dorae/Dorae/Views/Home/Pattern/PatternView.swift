//
//  PatternView.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import SwiftUI

struct PatternView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var pattern: Pattern
    
    var body: some View {
        
        HStack(spacing: 0) {
            VStack(alignment: .leading) {
                Text("도안")
                    .padding(EdgeInsets(top: 24, leading: 16, bottom: 4, trailing: 0))
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
                    .padding(EdgeInsets(top: 24, leading: 16, bottom: 4, trailing: 0))
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
            HStack(spacing: 0) {
                VStack {
                    HStack {
                        Text("그림 도안")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Spacer()
                        Button {
                            //TODO: 확대축소 기능 구현
                            imageReduction.toggle()
                        } label: {
                            Image(imageReduction ? "enlargeBtn" : "reductionBtn")
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 12)
                    .frame(height: 60)
                    Divider()
                    ScrollView {
                        ImagePatternView(pattern: pattern)
                    }
                    .scrollIndicators(.hidden)
                }
                .frame(width: geometry.size.width/2)
                
                Divider()
                    .rotationEffect(.zero)
                
                
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Text("글 도안")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Spacer()
                        EditButton()
                            .foregroundStyle(.red)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 12)
                    .frame(height: 60)
                    Divider()
                    TextPatternView(pattern: pattern)
                        .frame(width: geometry.size.width/2)
                }
            }
            
        }
    }
}


