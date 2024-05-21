//
//  HomePatternCell.swift
//  Dorae
//
//  Created by 지영 on 5/21/24.
//

import SwiftUI

struct HomePatternItem: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: "compass.drawing")
                .resizable()
                .padding()
                .frame(width: 160, height: 180)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            Spacer()
                .frame(height: 16)
            Text("도안제목")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.white)
            Text("2024. 06. 22")
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(.white)
        }
        
    }
}

struct HomeNewPatternItem: View {
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "plus")
                .padding(.bottom, 12)
            Text("새 매듭 도안")
            Text("생성하기")
        }
        .frame(width: 160, height: 180)
            .clipShape(
            RoundedRectangle(cornerRadius: 15)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5, 5]))
        )
        .foregroundStyle(Color(hex: "FF735A"))
    }
}

#Preview {
    HomePatternItem()
}
