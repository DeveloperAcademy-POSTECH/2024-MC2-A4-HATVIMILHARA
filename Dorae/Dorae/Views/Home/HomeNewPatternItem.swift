//
//  HomeNewPatternItem.swift
//  Dorae
//
//  Created by 지영 on 5/26/24.
//

import SwiftUI

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
        .foregroundStyle(Color.newKnotButton)
    }
}
