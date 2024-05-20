//
//  PatternView.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import SwiftUI

struct PatternView: View {
    @State private var isEditButton: Bool = true
    
    var body: some View {
        ZStack {
            Color.black
            
            HStack {
                ZStack {
                    // 도안에 표시되는 라운드 사각형
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .frame(width: 900)
                    
                    HStack {
                        // 그림 도안 뷰
                        TextPatternView()
                        
                        Divider()
                            .background(Color.black)
                            .frame(height: 900)
                            .rotationEffect(.degrees(180))
                        
                        // 글 도안 뷰
                        TextPatternView()
                    }
                    .padding(20)
                    
                }
                .padding(20)
                
                
                ZStack {
                    // 도안에 표시되는 라운드 사각형
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .frame(width: 350)
                    
                    // 매듭 리스트 뷰
                    ZStack {
                        TextPatternView()
                        
                        if isEditButton {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.gray)
                                .opacity(0.8)
                                .frame(width: 350)
                        }
                    }
                    .padding(20)
                }
                .padding(20)
            }
        }
    }
}

#Preview {
    PatternView()
}
