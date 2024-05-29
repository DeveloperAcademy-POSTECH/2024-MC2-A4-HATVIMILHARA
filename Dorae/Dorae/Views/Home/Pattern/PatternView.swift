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
    @Environment(\.editMode) var editMode
    
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
                    .overlay {
                        if pattern.knotList.isEmpty && editMode?.wrappedValue.isEditing == false && pattern.braid.isEmpty {
                            ZStack {
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(.black.opacity(0.5))
                                
                                Text("매듭을 눌러 도안을 추가해보세요")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 34, weight: .bold))
                            }
                        }
                    }
            }
            .padding(.horizontal, 24)
            
            VStack(alignment: .leading) {
                Text("매듭")
                    .padding(EdgeInsets(top: 24, leading: 16, bottom: 4, trailing: 0))
                    .font(.title2.bold())
                    .foregroundStyle(.white)
                    .opacity(editMode?.wrappedValue.isEditing == true ? 0.6 : 1)
                
                KnotListView(pattern: pattern)
                    .overlay {
                        if editMode?.wrappedValue.isEditing == true && !pattern.knotList.isEmpty {
                            RoundedRectangle(cornerRadius: 24)
                                .opacity(0.6)
                                .padding(.trailing, -20)
                        }
                    }
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
                VStack(spacing: 0) {
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
                
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .top) {
                        Text("글 도안")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Spacer()
                        EditButton()
                            .foregroundStyle(.red)
                    }
                    .padding(.horizontal, 24)
                    .frame(height: 60)
                    Divider()
                    TextPatternView(pattern: pattern)
                        .frame(width: geometry.size.width/2)
                }
            }
        }
    }
}
