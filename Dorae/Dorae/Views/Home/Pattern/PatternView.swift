//
//  PatternView.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import SwiftUI

struct PatternView: View {
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
//                .frame(width: 840 )
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
    }
        
}

#Preview {
    PatternView()
}
